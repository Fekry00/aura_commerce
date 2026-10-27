import 'package:aura/core/routing/main_tab_controller.dart';
import 'package:aura/core/routing/routes.dart';
import 'package:aura/core/utils/functions/custom_snack_bar.dart';
import 'package:aura/features/orders/presentation/cubit/orders_cubit.dart';
import 'package:aura/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:aura/features/profile/presentation/widgets/saved_addresses_bottom_sheet.dart';
import 'package:aura/features/profile/presentation/widgets/sign_out_confirmation_dialog.dart';
import 'package:aura/features/profile/presentation/widgets/vault_pay_bottom_sheet.dart';
import 'package:aura/features/wishlist/presentation/cubit/wishlist_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Pure UI controller for Profile screen actions, dialog triggers, and cubit delegations.
class ProfileController {
  const ProfileController();

  /// Opens the Sign Out confirmation dialog, and calls Cubit signOut if confirmed.
  Future<void> onSignOutPressed(BuildContext context) async {
    final confirmed = await SignOutConfirmationDialog.show(context);
    if (confirmed == true && context.mounted) {
      context.read<ProfileCubit>().signOut();
    }
  }

  void onMyOrdersPressed(BuildContext context) {
    Navigator.pushNamed(context, Routes.ordersView);
  }

  void onWishlistPressed(BuildContext context) {
    MainTabController.switchTab(1);
  }

  void onSavedAddressesPressed(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => const SavedAddressesBottomSheet(),
    );
  }

  void onVaultPayPressed(
    BuildContext context, {
    VoidCallback? onPreferenceChanged,
  }) {
    VaultPayBottomSheet.show(
      context,
      onPreferenceChanged: onPreferenceChanged,
    );
  }

  Future<void> onRefresh(BuildContext context) async {
    await Future.wait([
      context.read<ProfileCubit>().fetchProfile(),
      context.read<OrdersCubit>().fetchMyOrders(),
      context.read<WishlistCubit>().fetchWishlist(),
    ]);
  }

  void onQuickActionTap(
    BuildContext context,
    String title,
    ScrollController? scrollController, {
    VoidCallback? onUpdate,
  }) {
    if (title == 'Wishlist') {
      onWishlistPressed(context);
      return;
    }
    if (title == 'My Orders') {
      onMyOrdersPressed(context);
      return;
    }
    if (title == 'Addresses') {
      onSavedAddressesPressed(context);
      return;
    }
    if (title == 'Vault Pay') {
      onVaultPayPressed(
        context,
        onPreferenceChanged: () => onUpdate?.call(),
      );
      return;
    }
    if (scrollController != null && scrollController.hasClients) {
      scrollController.animateTo(
        0,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeOutCubic,
      );
    } else {
      Scrollable.maybeOf(context)?.position.animateTo(
            0,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeOutCubic,
          );
    }
    showCustomSnackBar(
      context,
      message: 'Opening $title...',
      type: SnackBarType.info,
    );
    onUpdate?.call();
  }
}
