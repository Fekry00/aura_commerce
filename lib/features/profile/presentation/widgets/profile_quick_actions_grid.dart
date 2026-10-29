import 'package:aura/core/routing/main_tab_controller.dart';
import 'package:aura/core/routing/routes.dart';
import 'package:aura/core/theme/app_colors.dart';
import 'package:aura/core/theme/app_typography.dart';
import 'package:aura/features/profile/presentation/widgets/saved_addresses_bottom_sheet.dart';
import 'package:aura/features/profile/presentation/widgets/vault_pay_bottom_sheet.dart';
import 'package:flutter/material.dart';

class ProfileQuickActionsGrid extends StatelessWidget {
  final ScrollController? scrollController;
  final ValueChanged<String>? onActionTap;
  final int activeOrdersCount;
  final String activeOrdersSubtitle;
  final int wishlistCount;
  final String wishlistSubtitle;
  final String addressesCountText;
  final String addressesSubtitle;
  final String vaultPayStatus;
  final String vaultPaySubtitle;

  const ProfileQuickActionsGrid({
    super.key,
    this.scrollController,
    this.onActionTap,
    this.activeOrdersCount = 0,
    this.activeOrdersSubtitle = 'No active orders',
    this.wishlistCount = 0,
    this.wishlistSubtitle = 'No items saved yet',
    this.addressesCountText = '1 Primary',
    this.addressesSubtitle = 'White-glove standard',
    this.vaultPayStatus = 'Active',
    this.vaultPaySubtitle = 'Cash on Delivery & Cards',
  });

  void _handleTap(BuildContext context, String title) {
    if (title == 'Wishlist') {
      MainTabController.switchTab(1);
    } else if (title == 'My Orders') {
      Navigator.pushNamed(context, Routes.ordersView);
    } else if (title == 'Addresses') {
      showModalBottomSheet<void>(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (_) => const SavedAddressesBottomSheet(),
      );
    } else if (title == 'Vault Pay') {
      VaultPayBottomSheet.show(context);
    }
    onActionTap?.call(title);
  }

  @override
  Widget build(BuildContext context) {
    final bool hasActive = activeOrdersCount > 0;
    final String ordersBadge =
        hasActive ? '$activeOrdersCount Active' : '0 Active';

    return GridView.count(
      crossAxisCount: 2,
      crossAxisSpacing: AppSpacing.spaceSm,
      mainAxisSpacing: AppSpacing.spaceSm,
      childAspectRatio: 1.25,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        _buildActionCard(
          context,
          icon: Icons.inventory_2_outlined,
          title: 'My Orders',
          subtitle: activeOrdersSubtitle,
          badge: ordersBadge,
          badgeColor: hasActive
              ? const Color(0xFF0B3B2C)
              : AppColors.surfaceContainerHigh,
          badgeTextColor: hasActive ? Colors.white : AppColors.slateBody,
          onTap: () => _handleTap(context, 'My Orders'),
        ),
        _buildActionCard(
          context,
          icon: Icons.favorite_border_rounded,
          title: 'Wishlist',
          subtitle: wishlistSubtitle,
          badge: '$wishlistCount Curated',
          badgeColor: AppColors.surfaceContainerHigh,
          badgeTextColor: AppColors.slateBody,
          onTap: () => _handleTap(context, 'Wishlist'),
        ),
        _buildActionCard(
          context,
          icon: Icons.location_on_outlined,
          title: 'Addresses',
          subtitle: addressesSubtitle,
          badge: addressesCountText,
          badgeColor: AppColors.surfaceContainerHigh,
          badgeTextColor: AppColors.slateBody,
          onTap: () => _handleTap(context, 'Addresses'),
        ),
        _buildActionCard(
          context,
          icon: Icons.credit_card_outlined,
          title: 'Vault Pay',
          subtitle: vaultPaySubtitle,
          badge: vaultPayStatus,
          badgeColor: const Color(0xFFE8F5E9),
          badgeTextColor: const Color(0xFF2E7D32),
          onTap: () => _handleTap(context, 'Vault Pay'),
        ),
      ],
    );
  }

  Widget _buildActionCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required String badge,
    required Color badgeColor,
    required Color badgeTextColor,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(AppSpacing.margin),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppSpacing.margin),
        child: Container(
          padding: const EdgeInsets.all(AppSpacing.spaceSm + 4),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppSpacing.margin),
            border: Border.all(color: const Color(0xFFE5E7EB), width: 1.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF3F4F6),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(icon, color: const Color(0xFF1F2937), size: 20),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.spaceSm,
                      vertical: AppSpacing.space2Xs,
                    ),
                    decoration: BoxDecoration(
                      color: badgeColor,
                      borderRadius: BorderRadius.circular(AppSpacing.spaceXs),
                    ),
                    child: Text(
                      badge,
                      style: AppTypography.labelCaps.copyWith(
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        color: badgeTextColor,
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTypography.bodySm.copyWith(
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF111827),
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.space2Xs),
                  Text(
                    subtitle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTypography.bodySm.copyWith(
                      color: const Color(0xFF6B7280),
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
