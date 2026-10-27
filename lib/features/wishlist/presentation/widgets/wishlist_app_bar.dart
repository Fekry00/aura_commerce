import 'package:aura/core/theme/app_colors.dart';
import 'package:aura/core/theme/app_typography.dart';
import 'package:aura/core/widgets/app_bar_user_avatar.dart';
import 'package:aura/features/profile/data/services/user_address_manager.dart';
import 'package:aura/features/profile/presentation/widgets/saved_addresses_bottom_sheet.dart';
import 'package:flutter/material.dart';

class WishlistAppBar extends StatelessWidget implements PreferredSizeWidget {
  const WishlistAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.margin,
          vertical: AppSpacing.spaceXs,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildBrand(),
            const SizedBox(width: AppSpacing.spaceSm),
            Flexible(child: _buildDeliveryChip(context)),
            const SizedBox(width: AppSpacing.spaceSm),
            _buildActions(),
          ],
        ),
      ),
    );
  }

  Widget _buildBrand() => Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'AURA',
            style: AppTypography.headlineSm.copyWith(
              fontWeight: FontWeight.w900,
              letterSpacing: 2.0,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(width: AppSpacing.spaceXs / 2),
          Container(
            width: AppSpacing.spaceSm - 2,
            height: AppSpacing.spaceSm - 2,
            decoration: const BoxDecoration(
                color: AppColors.mintHighlight, shape: BoxShape.circle),
          ),
        ],
      );

  Widget _buildDeliveryChip(BuildContext context) {
    final defaultAddress = UserAddressManager.getDefaultAddress();
    final addressText = defaultAddress != null
        ? (defaultAddress.address.isNotEmpty
            ? defaultAddress.address
            : defaultAddress.label)
        : 'Manage delivery';

    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          builder: (_) => const SavedAddressesBottomSheet(),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.spaceSm, vertical: AppSpacing.spaceXs),
        decoration: BoxDecoration(
          color: AppColors.surfaceContainerHigh,
          borderRadius: BorderRadius.circular(AppSpacing.spaceLg),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.location_on,
                size: AppSpacing.spaceMd, color: AppColors.secondary),
            const SizedBox(width: AppSpacing.spaceXs / 2),
            Flexible(
              child: Text(
                'Deliver: $addressText',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTypography.labelSm.copyWith(
                    color: AppColors.onSurface, fontWeight: FontWeight.w600),
              ),
            ),
            const SizedBox(width: AppSpacing.spaceXs / 2),
            const Icon(Icons.expand_more,
                size: AppSpacing.spaceMd, color: AppColors.outline),
          ],
        ),
      ),
    );
  }

  Widget _buildActions() => const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Badge(
            backgroundColor: AppColors.error,
            smallSize: AppSpacing.spaceSm,
            child: Icon(Icons.notifications_none_rounded,
                size: AppSpacing.spaceLg, color: AppColors.onSurface),
          ),
          SizedBox(width: AppSpacing.spaceSm),
          AppBarUserAvatar(radius: AppSpacing.spaceMd - 2),
        ],
      );
}
