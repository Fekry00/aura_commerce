import 'package:aura/core/theme/app_colors.dart';
import 'package:aura/core/theme/app_typography.dart';
import 'package:flutter/material.dart';

enum MilestoneState { completed, active, pending }

class TrackingMilestoneStepItem extends StatelessWidget {
  final String title;
  final String time;
  final String description;
  final MilestoneState state;
  final bool isLast;

  const TrackingMilestoneStepItem({
    super.key,
    required this.title,
    required this.time,
    required this.description,
    required this.state,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              _buildNodeIcon(),
              if (!isLast)
                Expanded(
                  child: Container(
                    width: 2,
                    margin: const EdgeInsets.symmetric(vertical: 3),
                    color: state == MilestoneState.completed
                        ? AppColors.secondary.withValues(alpha: 0.6)
                        : AppColors.outlineVariant.withValues(alpha: 0.6),
                  ),
                ),
            ],
          ),
          const SizedBox(width: AppSpacing.spaceMd),
          // Content
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: isLast ? 0 : AppSpacing.spaceMd),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text(
                          title,
                          style: AppTypography.bodyMd.copyWith(
                            fontWeight: FontWeight.w700,
                            color: state == MilestoneState.active
                                ? AppColors.secondary
                                : (state == MilestoneState.pending
                                      ? AppColors.slateBody
                                      : AppColors.slateHeadline),
                          ),
                        ),
                      ),
                      Text(
                        time,
                        style: AppTypography.labelSm.copyWith(
                          color: state == MilestoneState.active
                              ? AppColors.secondary
                              : AppColors.slateBody,
                          fontWeight: state == MilestoneState.active
                              ? FontWeight.w700
                              : FontWeight.w500,
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Text(
                    description,
                    style: AppTypography.bodySm.copyWith(
                      color: AppColors.slateBody,
                      fontSize: 11.5,
                      height: 1.35,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNodeIcon() {
    switch (state) {
      case MilestoneState.completed:
        return Container(
          width: 22,
          height: 22,
          decoration: const BoxDecoration(
            color: AppColors.primaryContainer,
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.check_rounded, size: 13, color: Colors.white),
        );
      case MilestoneState.active:
        return Container(
          width: 22,
          height: 22,
          decoration: BoxDecoration(
            color: AppColors.secondaryContainer,
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.secondary, width: 2),
          ),
          child: Center(
            child: Container(
              width: 8,
              height: 8,
              decoration: const BoxDecoration(
                color: AppColors.secondary,
                shape: BoxShape.circle,
              ),
            ),
          ),
        );
      case MilestoneState.pending:
        return Container(
          width: 22,
          height: 22,
          decoration: BoxDecoration(
            color: AppColors.surfaceContainerLow,
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.outlineVariant),
          ),
          child: Center(
            child: Text(
              'H',
              style: AppTypography.labelCaps.copyWith(
                color: AppColors.slateBody,
                fontWeight: FontWeight.w700,
                fontSize: 10,
              ),
            ),
          ),
        );
    }
  }
}
