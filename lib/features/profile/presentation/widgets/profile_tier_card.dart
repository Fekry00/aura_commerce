import 'package:aura/core/theme/app_colors.dart';
import 'package:aura/core/theme/app_typography.dart';
import 'package:flutter/material.dart';

class ProfileTierCard extends StatelessWidget {
  final String userName, userTier, customerId, patronSince, avatarUrl, targetTier;
  final double progress;
  final String spentAmount, remainingToPrivilege, deliveredCount, curationsCount, vaultCredit;

  const ProfileTierCard({
    super.key,
    this.userName = 'Claire Daniels',
    this.userTier = 'Tier 01',
    this.customerId = '#AL-98421',
    this.patronSince = 'Oct 2022',
    this.avatarUrl = 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?q=80&w=300',
    this.targetTier = 'TIER 02 SOVEREIGN',
    this.progress = 0.78,
    this.spentAmount = '\$12,450 spent',
    this.remainingToPrivilege = '\$2,550 to Sovereign Privileges',
    this.deliveredCount = '14',
    this.curationsCount = '28',
    this.vaultCredit = '\$450',
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.margin),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(AppSpacing.margin),
        border: Border.all(color: AppColors.outlineVariant, width: 1.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildUserInfoHeader(),
          const SizedBox(height: AppSpacing.spaceLg),
          _buildProgressSection(),
          const SizedBox(height: AppSpacing.spaceMd),
          _buildStatsRow(),
        ],
      ),
    );
  }

  Widget _buildUserInfoHeader() {
    return Row(
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              padding: const EdgeInsets.all(AppSpacing.spaceXs / 2),
              decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: AppColors.outlineVariant, width: 1.5)),
              child: CircleAvatar(radius: AppSpacing.spaceLg + AppSpacing.spaceXs, backgroundImage: NetworkImage(avatarUrl)),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(AppSpacing.spaceXs),
                decoration: const BoxDecoration(color: AppColors.primaryContainer, shape: BoxShape.circle),
                child: const Icon(Icons.diamond_rounded, size: AppSpacing.spaceSm + AppSpacing.spaceXs, color: AppColors.mintHighlight),
              ),
            ),
          ],
        ),
        const SizedBox(width: AppSpacing.spaceMd),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(userName, style: AppTypography.headlineSm.copyWith(fontWeight: FontWeight.w700)),
                  const SizedBox(width: AppSpacing.spaceSm),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: AppSpacing.spaceSm, vertical: AppSpacing.spaceXs / 2),
                    decoration: BoxDecoration(color: const Color(0xFFD1FADF), borderRadius: BorderRadius.circular(AppSpacing.margin)),
                    child: Text(userTier, style: AppTypography.labelCaps.copyWith(color: const Color(0xFF027A48), fontWeight: FontWeight.w700)),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.spaceXs / 2),
              Text('VIP Luminary • $customerId', style: AppTypography.bodySm.copyWith(color: AppColors.slateBody)),
              Text('Patron since $patronSince', style: AppTypography.bodySm.copyWith(color: AppColors.slateBody)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildProgressSection() {
    final int percent = (progress * 100).round();
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('PATH TO $targetTier', style: AppTypography.labelCaps.copyWith(fontWeight: FontWeight.w700, letterSpacing: 0.5)),
            Text('$percent%', style: AppTypography.labelCaps.copyWith(color: AppColors.secondary, fontWeight: FontWeight.w700)),
          ],
        ),
        const SizedBox(height: AppSpacing.spaceSm),
        ClipRRect(
          borderRadius: BorderRadius.circular(AppSpacing.spaceXs),
          child: LinearProgressIndicator(value: progress, minHeight: AppSpacing.spaceSm - 2, backgroundColor: AppColors.surfaceContainer, color: AppColors.primaryContainer),
        ),
        const SizedBox(height: AppSpacing.spaceSm),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(spentAmount, style: AppTypography.bodySm.copyWith(fontSize: 11, color: AppColors.slateBody)),
            Text(remainingToPrivilege, style: AppTypography.bodySm.copyWith(fontSize: 11, color: AppColors.slateBody)),
          ],
        ),
      ],
    );
  }

  Widget _buildStatsRow() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.spaceMd),
      decoration: BoxDecoration(color: AppColors.surfaceContainerLow, borderRadius: BorderRadius.circular(AppSpacing.spaceMd)),
      child: Row(
        children: [
          _buildStatItem(deliveredCount, 'DELIVERED', AppColors.slateHeadline),
          Container(width: 1.0, height: AppSpacing.spaceLg, color: AppColors.outlineVariant),
          _buildStatItem(curationsCount, 'CURATIONS', AppColors.slateHeadline),
          Container(width: 1.0, height: AppSpacing.spaceLg, color: AppColors.outlineVariant),
          _buildStatItem(vaultCredit, 'VAULT CREDIT', AppColors.secondary),
        ],
      ),
    );
  }

  Widget _buildStatItem(String val, String label, Color color) {
    return Expanded(
      child: Column(
        children: [
          Text(val, style: AppTypography.headlineSm.copyWith(fontWeight: FontWeight.w700, color: color)),
          const SizedBox(height: AppSpacing.spaceXs / 2),
          Text(label, style: AppTypography.labelCaps.copyWith(fontSize: 9, color: AppColors.slateBody)),
        ],
      ),
    );
  }
}
