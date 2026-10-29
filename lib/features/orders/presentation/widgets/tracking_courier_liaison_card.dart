import 'package:aura/core/theme/app_colors.dart';
import 'package:aura/core/theme/app_typography.dart';
import 'package:aura/features/orders/presentation/widgets/tracking_courier_protocol_box.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class TrackingCourierLiaisonCard extends StatelessWidget {
  final String courierName;
  final String courierRole;
  final String courierBadge;
  final String? courierAvatarUrl;
  final VoidCallback? onCall;
  final VoidCallback? onMessage;

  const TrackingCourierLiaisonCard({
    super.key,
    this.courierName = 'Aura Armored Courier',
    this.courierRole = 'White-Glove Private Transit Specialist',
    this.courierBadge = 'Aura Verified Dispatch',
    this.courierAvatarUrl,
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
                  ClipOval(
                    child: (courierAvatarUrl != null &&
                            courierAvatarUrl!.isNotEmpty)
                        ? CachedNetworkImage(
                            imageUrl: courierAvatarUrl!,
                            width: 48,
                            height: 48,
                            fit: BoxFit.cover,
                            placeholder: (context, url) => Container(
                              width: 48,
                              height: 48,
                              color: AppColors.surfaceContainerLow,
                            ),
                            errorWidget: (context, url, error) => Container(
                              width: 48,
                              height: 48,
                              color: AppColors.primaryContainer,
                              child: const Icon(
                                Icons.shield_outlined,
                                color: Colors.white,
                                size: 22,
                              ),
                            ),
                          )
                        : Container(
                            width: 48,
                            height: 48,
                            color: AppColors.primaryContainer,
                            child: const Icon(
                              Icons.shield_outlined,
                              color: Colors.white,
                              size: 22,
                            ),
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
                      courierName,
                      style: AppTypography.bodyMd.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      courierRole,
                      style: AppTypography.bodySm.copyWith(
                        color: AppColors.slateBody,
                        fontSize: 11,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Row(
                      children: [
                        const Icon(
                          Icons.verified_user_outlined,
                          size: 13,
                          color: AppColors.secondary,
                        ),
                        const SizedBox(width: 3),
                        Text(
                          courierBadge,
                          style: AppTypography.bodySm.copyWith(
                            color: AppColors.slateBody,
                            fontSize: 10.5,
                            fontWeight: FontWeight.w500,
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
                  decoration: const BoxDecoration(
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
                  child: const Icon(
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
