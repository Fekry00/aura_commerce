import 'package:aura/core/di/injection_container.dart' as di;
import 'package:aura/core/network/api/end_points.dart';
import 'package:aura/core/theme/app_colors.dart';
import 'package:aura/core/theme/app_typography.dart';
import 'package:aura/features/product/domain/entities/sub_entities/product_review_entity.dart';
import 'package:aura/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ReviewerAvatar extends StatelessWidget {
  final ProductReviewEntity review;
  final double radius;

  const ReviewerAvatar({
    super.key,
    required this.review,
    this.radius = AppSpacing.spaceMd,
  });

  @override
  Widget build(BuildContext context) {
    String? avatarUrl = review.authorAvatar?.trim();

    if (avatarUrl == null || avatarUrl.isEmpty) {
      try {
        final currentProfile = di.sl<ProfileCubit>().currentProfile;
        if (currentProfile != null &&
            currentProfile.user.avatarUrl.isNotEmpty &&
            currentProfile.user.name.trim().toLowerCase() ==
                review.authorName.trim().toLowerCase()) {
          avatarUrl = currentProfile.user.avatarUrl.trim();
        }
      } catch (_) {}
    }

    avatarUrl = EndPoint.fixImageUrl(avatarUrl);

    final hasValidImage = avatarUrl.isNotEmpty &&
        (avatarUrl.startsWith('http://') || avatarUrl.startsWith('https://'));

    if (hasValidImage) {
      return CircleAvatar(
        radius: radius,
        backgroundColor: AppColors.surfaceContainerLow,
        backgroundImage: CachedNetworkImageProvider(avatarUrl),
        onBackgroundImageError: (_, __) {},
      );
    }

    return CircleAvatar(
      radius: radius,
      backgroundColor: const Color(0xFF111827),
      child: Text(
        review.authorInitials,
        style: AppTypography.labelSm.copyWith(
          color: Colors.white,
          fontSize: radius * 0.7,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
