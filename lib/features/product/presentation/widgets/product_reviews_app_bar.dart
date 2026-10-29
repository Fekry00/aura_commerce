import 'package:aura/core/theme/app_colors.dart';
import 'package:aura/core/theme/app_typography.dart';
import 'package:aura/features/product/presentation/utils/product_ui_helper.dart';
import 'package:flutter/material.dart';

class ProductReviewsAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  final int reviewsCount;
  final VoidCallback? onBackTap;
  final VoidCallback? onAddReviewTap;

  const ProductReviewsAppBar({
    super.key,
    required this.reviewsCount,
    this.onBackTap,
    this.onAddReviewTap,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back_ios_new_rounded,
          size: 18,
          color: AppColors.onSurface,
        ),
        onPressed: onBackTap ?? () => Navigator.pop(context),
      ),
      title: Column(
        children: [
          Text(
            'Client Reviews',
            style: AppTypography.headlineSm.copyWith(
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
          Text(
            ProductUiHelper.formatReviewsHeader(reviewsCount),
            style: AppTypography.bodySm.copyWith(
              color: AppColors.slateBody,
              fontSize: 10,
            ),
          ),
        ],
      ),
      actions: [
        IconButton(
          icon: const Icon(
            Icons.rate_review_outlined,
            color: Color(0xFF1E382B),
            size: 20,
          ),
          onPressed: onAddReviewTap,
        ),
      ],
    );
  }
}
