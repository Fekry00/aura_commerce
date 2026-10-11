import 'package:aura/core/theme/app_colors.dart';
import 'package:aura/core/theme/app_typography.dart';
import 'package:aura/core/utils/functions/custom_snack_bar.dart';
import 'package:flutter/material.dart';

class ProfileQuickActionsGrid extends StatelessWidget {
  final ScrollController? scrollController;
  final ValueChanged<String>? onActionTap;

  const ProfileQuickActionsGrid({
    super.key,
    this.scrollController,
    this.onActionTap,
  });

  void _handleTap(BuildContext context, String title) {
    if (scrollController != null && scrollController!.hasClients) {
      scrollController!.animateTo(0, duration: const Duration(milliseconds: 500), curve: Curves.easeOutCubic);
    } else {
      Scrollable.maybeOf(context)?.position.animateTo(0, duration: const Duration(milliseconds: 500), curve: Curves.easeOutCubic);
    }
    showCustomSnackBar(context, message: 'Navigating to $title...', type: SnackBarType.info);
    onActionTap?.call(title);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(child: _buildActionCard(context, Icons.inventory_2_outlined, '2 Active', true, 'My Orders', 'Scheduled in Manhattan')),
            const SizedBox(width: AppSpacing.spaceMd),
            Expanded(child: _buildActionCard(context, Icons.bookmark_outline_rounded, '28', false, 'Wishlist', '3 Price Drop Alerts')),
          ],
        ),
        const SizedBox(height: AppSpacing.spaceMd),
        Row(
          children: [
            Expanded(child: _buildActionCard(context, Icons.my_location_rounded, '2 Locations', false, 'Addresses', 'White-glove primary')),
            const SizedBox(width: AppSpacing.spaceMd),
            Expanded(child: _buildActionCard(context, Icons.credit_card_outlined, 'Verified', true, 'Vault Pay', 'Amex Centurion & Apple ...')),
          ],
        ),
      ],
    );
  }

  Widget _buildActionCard(BuildContext context, IconData icon, String badgeText, bool isGreen, String title, String subtitle) {
    return InkWell(
      onTap: () => _handleTap(context, title),
      borderRadius: BorderRadius.circular(AppSpacing.spaceMd),
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.spaceMd),
        decoration: BoxDecoration(
          color: AppColors.surfaceContainerLowest,
          borderRadius: BorderRadius.circular(AppSpacing.spaceMd),
          border: Border.all(color: AppColors.outlineVariant, width: 1.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.all(AppSpacing.spaceSm),
                  decoration: const BoxDecoration(color: AppColors.surfaceContainerLow, shape: BoxShape.circle),
                  child: Icon(icon, size: AppSpacing.spaceMd, color: AppColors.slateHeadline),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: AppSpacing.spaceSm, vertical: AppSpacing.spaceXs / 2),
                  decoration: BoxDecoration(
                    color: isGreen ? const Color(0xFFD1FADF) : AppColors.surfaceContainerHigh,
                    borderRadius: BorderRadius.circular(AppSpacing.margin),
                  ),
                  child: Text(
                    badgeText,
                    style: AppTypography.labelCaps.copyWith(color: isGreen ? const Color(0xFF027A48) : AppColors.onSurfaceVariant, fontWeight: FontWeight.w700),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.spaceMd),
            Text(title, style: AppTypography.headlineSm.copyWith(fontWeight: FontWeight.w700)),
            const SizedBox(height: AppSpacing.spaceXs / 2),
            Text(subtitle, maxLines: 1, overflow: TextOverflow.ellipsis, style: AppTypography.bodySm.copyWith(color: AppColors.slateBody, fontSize: 11)),
          ],
        ),
      ),
    );
  }
}
