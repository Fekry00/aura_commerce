import 'package:aura/core/routing/routes.dart';
import 'package:aura/core/theme/app_colors.dart';
import 'package:aura/core/theme/app_typography.dart';
import 'package:aura/core/utils/image_cache_manager.dart';
import 'package:aura/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileTierCard extends StatelessWidget {
  final String userName;
  final String userTier;
  final String customerId;
  final String patronSince;
  final String avatarUrl;
  final String email;
  final String phone;
  final String deliveredCount;
  final String curationsCount;
  final String totalOrdersCount;

  const ProfileTierCard({
    super.key,
    this.userName = 'Aura Client',
    this.userTier = 'Member',
    this.customerId = '#AL-000',
    this.patronSince = 'Oct 2026',
    this.avatarUrl = '',
    this.email = '',
    this.phone = '',
    this.deliveredCount = '0',
    this.curationsCount = '0',
    this.totalOrdersCount = '0',
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
          _buildUserInfoHeader(context),
          if (email.isNotEmpty || phone.isNotEmpty) ...[
            const SizedBox(height: AppSpacing.spaceSm),
            _buildContactInfoRow(),
          ],
          const SizedBox(height: AppSpacing.spaceMd),
          _buildStatsRow(),
        ],
      ),
    );
  }

  Widget _buildUserInfoHeader(BuildContext context) {
    return Row(
      children: [
        InkWell(
          onTap: () {
            Navigator.of(context).pushNamed(Routes.editProfileView).then((_) {
              if (context.mounted && ModalRoute.of(context)?.isCurrent == true) {
                context.read<ProfileCubit>().fetchProfile();
              }
            });
          },
          borderRadius: BorderRadius.circular(AppSpacing.margin),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                padding: const EdgeInsets.all(AppSpacing.spaceXs / 2),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.outlineVariant, width: 1.5),
                ),
                child: CircleAvatar(
                  radius: AppSpacing.spaceLg + AppSpacing.spaceXs,
                  backgroundColor: const Color(0xFF0B3B2C),
                  backgroundImage: avatarUrl.isNotEmpty
                      ? AuraImageCacheManager.provider(avatarUrl)
                      : null,
                  child: avatarUrl.isEmpty
                      ? Text(
                          userName.isNotEmpty ? userName[0].toUpperCase() : 'A',
                          style: AppTypography.headlineSm.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                        )
                      : null,
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.all(AppSpacing.spaceXs),
                  decoration: const BoxDecoration(
                    color: AppColors.primaryContainer,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.diamond_rounded,
                    size: AppSpacing.spaceSm + AppSpacing.spaceXs,
                    color: AppColors.mintHighlight,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: AppSpacing.spaceMd),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Flexible(
                    child: Text(
                      userName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTypography.headlineSm.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.spaceSm),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.spaceSm,
                      vertical: AppSpacing.spaceXs / 2,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFD1FADF),
                      borderRadius: BorderRadius.circular(AppSpacing.margin),
                    ),
                    child: Text(
                      userTier,
                      style: AppTypography.labelCaps.copyWith(
                        color: const Color(0xFF027A48),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.spaceXs / 2),
              Text(
                'Aura Member • $customerId',
                style: AppTypography.bodySm.copyWith(color: AppColors.slateBody),
              ),
              Text(
                'Member since $patronSince',
                style: AppTypography.bodySm.copyWith(color: AppColors.slateBody),
              ),
            ],
          ),
        ),
        InkWell(
          onTap: () {
            Navigator.of(context).pushNamed(Routes.editProfileView).then((_) {
              if (context.mounted && ModalRoute.of(context)?.isCurrent == true) {
                context.read<ProfileCubit>().fetchProfile();
              }
            });
          },
          borderRadius: BorderRadius.circular(AppSpacing.margin),
          child: Container(
            padding: const EdgeInsets.all(AppSpacing.spaceSm),
            decoration: BoxDecoration(
              color: AppColors.surfaceContainerLow,
              borderRadius: BorderRadius.circular(AppSpacing.spaceSm),
            ),
            child: const Icon(
              Icons.edit_outlined,
              size: AppSpacing.spaceMd + 2,
              color: AppColors.secondary,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildContactInfoRow() {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.spaceSm + 2,
        vertical: AppSpacing.spaceXs,
      ),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLow.withValues(alpha: 0.7),
        borderRadius: BorderRadius.circular(AppSpacing.spaceSm),
      ),
      child: Row(
        children: [
          if (email.isNotEmpty) ...[
            const Icon(
              Icons.mail_outline_rounded,
              size: 14,
              color: AppColors.slateBody,
            ),
            const SizedBox(width: AppSpacing.spaceXs),
            Expanded(
              child: Text(
                email,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTypography.bodySm.copyWith(
                  fontSize: 11,
                  color: AppColors.slateBody,
                ),
              ),
            ),
          ],
          if (phone.isNotEmpty) ...[
            if (email.isNotEmpty) const SizedBox(width: AppSpacing.spaceSm),
            const Icon(
              Icons.phone_outlined,
              size: 14,
              color: AppColors.slateBody,
            ),
            const SizedBox(width: AppSpacing.spaceXs),
            Text(
              phone,
              style: AppTypography.bodySm.copyWith(
                fontSize: 11,
                color: AppColors.slateBody,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildStatsRow() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.spaceMd),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLow,
        borderRadius: BorderRadius.circular(AppSpacing.spaceMd),
      ),
      child: Row(
        children: [
          _buildStatItem(deliveredCount, 'DELIVERED', AppColors.slateHeadline),
          Container(
            width: 1.0,
            height: AppSpacing.spaceLg,
            color: AppColors.outlineVariant,
          ),
          _buildStatItem(curationsCount, 'CURATIONS', AppColors.slateHeadline),
          Container(
            width: 1.0,
            height: AppSpacing.spaceLg,
            color: AppColors.outlineVariant,
          ),
          _buildStatItem(totalOrdersCount, 'TOTAL ORDERS', const Color(0xFF0B3B2C)),
        ],
      ),
    );
  }

  Widget _buildStatItem(String val, String label, Color color) {
    return Expanded(
      child: Column(
        children: [
          Text(
            val,
            style: AppTypography.headlineSm.copyWith(
              fontWeight: FontWeight.w700,
              color: color,
            ),
          ),
          const SizedBox(height: AppSpacing.spaceXs / 2),
          Text(
            label,
            style: AppTypography.labelCaps.copyWith(
              fontSize: 9,
              color: AppColors.slateBody,
            ),
          ),
        ],
      ),
    );
  }
}
