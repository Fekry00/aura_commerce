import 'package:aura/core/theme/app_colors.dart';
import 'package:aura/core/theme/app_typography.dart';
import 'package:aura/features/profile/presentation/controllers/profile_controller.dart';
import 'package:flutter/material.dart';

class ProfileQuickActionsGrid extends StatelessWidget {
  final ProfileController? controller;
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
    this.controller,
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
    (controller ?? const ProfileController()).onQuickActionTap(
      context,
      title,
      scrollController,
      onUpdate: () => onActionTap?.call(title),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool hasActive = activeOrdersCount > 0;
    final String ordersBadge = hasActive ? '$activeOrdersCount Active' : '0 Active';

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
          badgeColor: hasActive ? const Color(0xFF0B3B2C) : AppColors.surfaceContainerHigh,
          badgeTextColor: hasActive ? Colors.white : AppColors.slateBody,
          onTap: () => _handleTap(context, 'My Orders'),
        ),
        _buildActionCard(
          context,
          icon: Icons.favorite_border_rounded,
          title: 'Wishlist',
          subtitle: wishlistSubtitle,
          badge: '$wishlistCount Items',
          badgeColor: wishlistCount > 0 ? const Color(0xFFF3E8E2) : AppColors.surfaceContainerHigh,
          badgeTextColor: wishlistCount > 0 ? const Color(0xFF9E4A28) : AppColors.slateBody,
          onTap: () => _handleTap(context, 'Wishlist'),
        ),
        _buildActionCard(
          context,
          icon: Icons.location_on_outlined,
          title: 'Addresses',
          subtitle: addressesSubtitle,
          badge: addressesCountText,
          badgeColor: addressesCountText.startsWith('0') ? AppColors.surfaceContainerHigh : const Color(0xFFE8F5E9),
          badgeTextColor: addressesCountText.startsWith('0') ? AppColors.slateBody : const Color(0xFF2E7D32),
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
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.spaceSm + 4),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: const Color(0xFFE9ECEF),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.03),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.all(AppSpacing.spaceSm),
                  decoration: BoxDecoration(
                    color: const Color(0xFF0B3B2C).withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    icon,
                    size: 20,
                    color: const Color(0xFF0B3B2C),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 3,
                  ),
                  decoration: BoxDecoration(
                    color: badgeColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    badge,
                    style: AppTypography.labelCaps.copyWith(
                      fontSize: 9.5,
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
                  style: AppTypography.headlineSm.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTypography.bodySm.copyWith(
                    fontSize: 10.5,
                    color: AppColors.slateBody,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
