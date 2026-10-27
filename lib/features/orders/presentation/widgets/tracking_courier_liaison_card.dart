import 'package:aura/core/theme/app_colors.dart';
import 'package:aura/core/theme/app_typography.dart';
import 'package:aura/features/orders/presentation/widgets/tracking_courier_protocol_box.dart';
import 'package:flutter/material.dart';

class TrackingCourierLiaisonCard extends StatelessWidget {
  final VoidCallback? onCall;
  final VoidCallback? onMessage;

  const TrackingCourierLiaisonCard({
    super.key,
    this.onCall,
    this.onMessage,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.spaceMd),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(AppSpacing.spaceMd),
        border: Border.all(
          color: AppColors.outlineVariant.withValues(alpha: 0.5),
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Stack(
                children: [
                  const CircleAvatar(
                    radius: 24,
                    backgroundImage: NetworkImage(
                      'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?q=80&w=300',
                    ),
                  ),
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: Container(
                      width: 14,
                      height: 14,
                      decoration: const BoxDecoration(
                        color: AppColors.secondary,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.check_rounded,
                        size: 10,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: AppSpacing.spaceSm + 2),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Marcus Vance',
                      style: AppTypography.bodyMd.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      'Senior White-Glove Stylist & Escort',
                      style: AppTypography.bodySm.copyWith(
                        color: AppColors.slateBody,
                        fontSize: 11,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Row(
                      children: [
                        const Icon(
                          Icons.star_rounded,
                          size: 14,
                          color: AppColors.secondary,
                        ),
                        const SizedBox(width: 2),
                        Text(
                          '5.0',
                          style: AppTypography.labelSm.copyWith(
                            fontWeight: FontWeight.w700,
                            color: AppColors.secondary,
                          ),
                        ),
                        Text(
                          ' • 420+ Secure Deliveries',
                          style: AppTypography.bodySm.copyWith(
                            color: AppColors.slateBody,
                            fontSize: 10.5,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: onCall,
                borderRadius: BorderRadius.circular(18),
                child: Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: AppColors.surfaceContainerLow,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.phone_outlined,
                    size: 18,
                    color: AppColors.slateHeadline,
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.spaceSm),
              InkWell(
                onTap: onMessage,
                borderRadius: BorderRadius.circular(18),
                child: Container(
                  width: 36,
                  height: 36,
                  decoration: const BoxDecoration(
                    color: AppColors.primaryContainer,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.chat_bubble_outline_rounded,
                    size: 16,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.spaceMd),
          const TrackingCourierProtocolBox(),
        ],
      ),
    );
  }
}
