import 'package:aura/core/routing/routes.dart';
import 'package:aura/features/orders/presentation/cubit/orders_cubit.dart';
import 'package:aura/features/orders/presentation/cubit/orders_state.dart';
import 'package:aura/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:aura/features/profile/presentation/cubit/profile_state.dart';
import 'package:aura/features/profile/presentation/models/profile_metrics_data.dart';
import 'package:aura/features/profile/presentation/widgets/profile_content_section.dart';
import 'package:aura/features/profile/presentation/widgets/profile_shimmer_skeleton.dart';
import 'package:aura/features/profile/presentation/widgets/sign_out_confirmation_dialog.dart';
import 'package:aura/features/wishlist/domain/entities/sub_entities/wishlist_item_entity.dart';
import 'package:aura/features/wishlist/presentation/cubit/wishlist_cubit.dart';
import 'package:aura/features/wishlist/presentation/cubit/wishlist_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileViewBody extends StatefulWidget {
  const ProfileViewBody({super.key});

  @override
  State<ProfileViewBody> createState() => _ProfileViewBodyState();
}

class _ProfileViewBodyState extends State<ProfileViewBody> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProfileCubit>().fetchProfile();
      context.read<OrdersCubit>().fetchMyOrders();
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _onRefresh() => Future.wait([
        context.read<ProfileCubit>().fetchProfile(),
        context.read<OrdersCubit>().fetchMyOrders(),
        context.read<WishlistCubit>().fetchWishlist(),
      ]);

  Future<void> _onSignOut() async {
    final confirmed = await SignOutConfirmationDialog.show(context);
    if (confirmed == true && mounted) context.read<ProfileCubit>().signOut();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit, ProfileState>(
      listener: (context, state) {
        if (state is ProfileSignedOutState) {
          Navigator.pushNamedAndRemoveUntil(context, Routes.signInView, (r) => false);
        }
      },
      builder: (context, profileState) {
        final ordersState = context.watch<OrdersCubit>().state;
        final orders = ordersState is OrdersListSuccessState ? ordersState.orders : context.read<OrdersCubit>().orders;
        final wishlistState = context.watch<WishlistCubit>().state;
        final wishlistItems = wishlistState is WishlistSuccessState ? wishlistState.wishlist.items : const <WishlistItemEntity>[];
        final metrics = ProfileMetricsData.calculate(orders: orders, wishlistItems: wishlistItems);

        final isLoading =
            profileState is ProfileLoadingState && profileState.profile == null;

        return SafeArea(
          bottom: false,
          child: RefreshIndicator(
            color: const Color(0xFF0B3B2C),
            onRefresh: _onRefresh,
            child: isLoading
                ? const ProfileShimmerSkeleton()
                : SingleChildScrollView(
                    controller: _scrollController,
                    physics: const AlwaysScrollableScrollPhysics(
                      parent: BouncingScrollPhysics(),
                    ),
                    child: ProfileContentSection(
                      user: profileState.profile?.user,
                      profile: profileState.profile,
                      metrics: metrics,
                      scrollController: _scrollController,
                      onSignOut: _onSignOut,
                    ),
                  ),
          ),
        );
      },
    );
  }
}
