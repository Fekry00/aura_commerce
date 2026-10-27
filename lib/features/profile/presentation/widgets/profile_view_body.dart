import 'package:aura/core/di/injection_container.dart';
import 'package:aura/core/routing/routes.dart';
import 'package:aura/core/theme/app_typography.dart';
import 'package:aura/features/orders/presentation/cubit/orders_cubit.dart';
import 'package:aura/features/orders/presentation/cubit/orders_state.dart';
import 'package:aura/features/profile/presentation/controllers/profile_controller.dart';
import 'package:aura/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:aura/features/profile/presentation/cubit/profile_state.dart';
import 'package:aura/features/profile/presentation/models/profile_metrics_data.dart';
import 'package:aura/features/profile/presentation/widgets/concierge_liaison_card.dart';
import 'package:aura/features/profile/presentation/widgets/profile_app_bar.dart';
import 'package:aura/features/profile/presentation/widgets/profile_footer.dart';
import 'package:aura/features/profile/presentation/widgets/profile_header_section.dart';
import 'package:aura/features/profile/presentation/widgets/profile_quick_actions_grid.dart';
import 'package:aura/features/profile/presentation/widgets/profile_sections_list.dart';
import 'package:aura/features/profile/presentation/widgets/profile_sign_out_button.dart';
import 'package:aura/features/profile/presentation/widgets/profile_tier_card.dart';
import 'package:aura/features/wishlist/domain/entities/sub_entities/wishlist_item_entity.dart';
import 'package:aura/features/wishlist/presentation/cubit/wishlist_cubit.dart';
import 'package:aura/features/wishlist/presentation/cubit/wishlist_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileViewBody extends StatefulWidget {
  final ProfileController? controller;

  const ProfileViewBody({super.key, this.controller});

  @override
  State<ProfileViewBody> createState() => _ProfileViewBodyState();
}

class _ProfileViewBodyState extends State<ProfileViewBody> {
  final ScrollController _scrollController = ScrollController();
  late final ProfileController _controller;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? const ProfileController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: sl<ProfileCubit>()..fetchProfile()),
        BlocProvider(create: (context) => sl<OrdersCubit>()..fetchMyOrders()),
      ],
      child: BlocConsumer<ProfileCubit, ProfileState>(
        listener: (context, state) {
          if (state is ProfileSignedOutState) {
            Navigator.pushNamedAndRemoveUntil(
              context,
              Routes.signInView,
              (route) => false,
            );
          }
        },
        builder: (context, profileState) {
          final ordersState = context.watch<OrdersCubit>().state;
          final orders = ordersState is OrdersListSuccessState
              ? ordersState.orders
              : context.read<OrdersCubit>().orders;

          final wishlistState = context.watch<WishlistCubit>().state;
          final wishlistItems = wishlistState is WishlistSuccessState
              ? wishlistState.wishlist.items
              : const <WishlistItemEntity>[];

          final metrics = ProfileMetricsData.calculate(
            orders: orders,
            wishlistItems: wishlistItems,
          );

          final user = profileState.profile?.user;

          return SafeArea(
            bottom: false,
            child: RefreshIndicator(
              color: const Color(0xFF0B3B2C),
              onRefresh: () => _controller.onRefresh(context),
              child: SingleChildScrollView(
                controller: _scrollController,
                physics: const AlwaysScrollableScrollPhysics(
                  parent: BouncingScrollPhysics(),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: AppSpacing.spaceSm),
                    ProfileAppBar(
                      avatarUrl: user?.avatarUrl,
                      deliveryAddress: metrics.addressesSubtitle,
                    ),
                    const ProfileHeaderSection(),
                    const SizedBox(height: AppSpacing.spaceSm),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.margin,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ProfileTierCard(
                            userName: user?.name ?? 'Aura Client',
                            userTier: (user?.role.isNotEmpty ?? false)
                                ? (user!.role == 'customer'
                                    ? 'Customer'
                                    : user.role.toUpperCase())
                                : 'Member',
                            customerId: user?.id ?? '#AL-000',
                            patronSince: user?.patronSince ?? 'Oct 2026',
                            avatarUrl: user?.avatarUrl ?? '',
                            email: user?.email ?? '',
                            phone: user?.phone ?? '',
                            deliveredCount: metrics.deliveredCount,
                            curationsCount: metrics.curationsCount.toString(),
                            totalOrdersCount: metrics.totalOrdersCount,
                          ),
                          const SizedBox(height: AppSpacing.spaceMd),
                          ConciergeLiaisonCard(
                            liaison: profileState.profile?.liaison,
                          ),
                          const SizedBox(height: AppSpacing.spaceMd),
                          ProfileQuickActionsGrid(
                            controller: _controller,
                            scrollController: _scrollController,
                            activeOrdersCount: metrics.activeOrdersCount,
                            activeOrdersSubtitle: metrics.activeOrdersSubtitle,
                            wishlistCount: metrics.curationsCount,
                            wishlistSubtitle: metrics.wishlistSubtitle,
                            addressesCountText: metrics.addressesCountText,
                            addressesSubtitle: metrics.addressesSubtitle,
                            vaultPayStatus: metrics.vaultPayStatus,
                            vaultPaySubtitle: metrics.vaultPaySubtitle,
                            onActionTap: (_) => setState(() {}),
                          ),
                          const SizedBox(height: AppSpacing.spaceLg),
                          ProfileSectionsList(
                            controller: _controller,
                            dispatchAddress: metrics.allUniqueAddresses.isNotEmpty
                                ? '${metrics.allUniqueAddresses.length} saved location${metrics.allUniqueAddresses.length > 1 ? 's' : ''}'
                                : 'No address saved yet',
                          ),
                          const SizedBox(height: AppSpacing.spaceLg),
                          ProfileSignOutButton(
                            onTap: () => _controller.onSignOutPressed(context),
                          ),
                          const SizedBox(height: AppSpacing.spaceMd),
                          const ProfileFooter(),
                          const SizedBox(height: AppSpacing.spaceXl * 2),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
