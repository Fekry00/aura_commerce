import 'package:aura/core/theme/app_colors.dart';
import 'package:aura/core/utils/functions/custom_snack_bar.dart';
import 'package:aura/features/wishlist/presentation/controllers/wishlist_controller.dart';
import 'package:aura/features/wishlist/presentation/cubit/wishlist_cubit.dart';
import 'package:aura/features/wishlist/presentation/cubit/wishlist_state.dart';
import 'package:aura/features/wishlist/presentation/widgets/wishlist_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Pure Skeleton View for Wishlist handling Scaffold and side effects.
class WishlistView extends StatelessWidget {
  final WishlistController? controller;

  const WishlistView({super.key, this.controller});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      body: BlocListener<WishlistCubit, WishlistState>(
        listenWhen: (previous, current) => current is WishlistErrorState,
        listener: (context, state) {
          if (state is WishlistErrorState) {
            showCustomSnackBar(
              context,
              message: state.message,
              type: SnackBarType.error,
            );
          }
        },
        child: WishlistViewBody(controller: controller),
      ),
    );
  }
}
