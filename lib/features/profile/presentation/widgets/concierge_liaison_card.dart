import 'package:aura/core/theme/app_colors.dart';
import 'package:aura/core/theme/app_typography.dart';
import 'package:aura/core/utils/functions/custom_snack_bar.dart';
import 'package:aura/features/profile/domain/entities/sub_entities/concierge_liaison_entity.dart';
import 'package:flutter/material.dart';

class ConciergeLiaisonCard extends StatelessWidget {
  final ConciergeLiaisonEntity? liaison;

  const ConciergeLiaisonCard({super.key, this.liaison});

  @override
  Widget build(BuildContext context) {
    final name = liaison?.name ?? 'Marcus Vance';
    final role = liaison?.role ?? 'Dedicated White-Glove Stylist & Courier';
    final dispatchStatus = liaison?.dispatchStatus ?? 'Priority Dispatch';

    return Container(
      padding: const EdgeInsets.all(AppSpacing.margin),
      decoration: BoxDecoration(
        color: AppColors.primaryContainer,
        borderRadius: BorderRadius.circular(AppSpacing.margin),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: AppSpacing.spaceSm,
                    height: AppSpacing.spaceSm,
                    decoration: const BoxDecoration(
                      color: AppColors.mintHighlight,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.spaceSm),
                  Text(
                    'PRIVATE SALON LIAISON',
                    style: AppTypography.labelCaps.copyWith(
                      color: AppColors.mintHighlight,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.0,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  const Icon(
                    Icons.bolt_rounded,
                    size: AppSpacing.spaceMd,
                    color: AppColors.onPrimaryContainer,
                  ),
                  const SizedBox(width: AppSpacing.spaceXs / 2),
                  Text(
                    dispatchStatus,
                    style: AppTypography.bodySm.copyWith(
                      color: AppColors.onPrimaryContainer,
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.spaceMd),
          Row(
            children: [
              Container(
                width: AppSpacing.spaceXl + AppSpacing.spaceSm,
                height: AppSpacing.spaceXl + AppSpacing.spaceSm,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppColors.onPrimaryContainer.withValues(alpha: 0.3),
                    width: 1.0,
                  ),
                ),
                child: const Icon(
                  Icons.spa_outlined,
                  color: AppColors.mintHighlight,
                  size: AppSpacing.spaceLg,
                ),
              ),
              const SizedBox(width: AppSpacing.spaceMd),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: AppTypography.headlineSm.copyWith(
                        color: AppColors.onPrimary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.spaceXs / 2),
                    Text(
                      role,
                      style: AppTypography.bodySm.copyWith(
                        color: AppColors.onPrimaryContainer,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.spaceMd),
          Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: () => showCustomSnackBar(
                    context,
                    message: 'Opening secure thread with $name...',
                    type: SnackBarType.success,
                  ),
                  borderRadius: BorderRadius.circular(AppSpacing.margin),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: AppSpacing.spaceMd - 2,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.secondaryContainer,
                      borderRadius: BorderRadius.circular(AppSpacing.margin),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.chat_bubble_outline_rounded,
                          size: AppSpacing.spaceMd,
                          color: AppColors.primary,
                        ),
                        const SizedBox(width: AppSpacing.spaceSm),
                        Text(
                          'Direct Message',
                          style: AppTypography.bodySm.copyWith(
                            color: AppColors.primary,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.spaceSm),
              InkWell(
                onTap: () => showCustomSnackBar(
                  context,
                  message: 'Dialing $name direct line...',
                  type: SnackBarType.success,
                ),
                borderRadius: BorderRadius.circular(AppSpacing.margin),
                child: Container(
                  width: AppSpacing.spaceXl + AppSpacing.spaceXs,
                  height: AppSpacing.spaceXl + AppSpacing.spaceXs,
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.5),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppColors.onPrimaryContainer.withValues(alpha: 0.3),
                      width: 1.0,
                    ),
                  ),
                  child: const Icon(
                    Icons.phone_outlined,
                    color: AppColors.onPrimary,
                    size: AppSpacing.spaceMd + 2,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
