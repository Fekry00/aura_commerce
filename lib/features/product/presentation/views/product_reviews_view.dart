import 'package:aura/core/theme/app_colors.dart';
import 'package:aura/core/theme/app_typography.dart';
import 'package:aura/core/utils/functions/custom_snack_bar.dart';
import 'package:aura/features/product/presentation/widgets/reviews_consensus_summary.dart';
import 'package:aura/features/product/presentation/widgets/reviews_list_section.dart';
import 'package:aura/features/product/presentation/widgets/reviews_product_header_card.dart';
import 'package:flutter/material.dart';

class ProductReviewsView extends StatelessWidget {
  final Map<String, dynamic> product;

  const ProductReviewsView({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 18, color: AppColors.onSurface),
          onPressed: () => Navigator.pop(context),
        ),
        title: Column(
          children: [
            Text(
              'Client Reviews',
              style: AppTypography.headlineSm.copyWith(fontSize: 16, fontWeight: FontWeight.w700),
            ),
            Text(
              '128 Authenticated Opinions',
              style: AppTypography.bodySm.copyWith(color: AppColors.slateBody, fontSize: 10),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.rate_review_outlined, color: Color(0xFF1E382B), size: 20),
            onPressed: () {
              showCustomSnackBar(context, message: 'Compose new review...', type: SnackBarType.info);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(AppSpacing.margin),
        child: Column(
          children: [
            ReviewsProductHeaderCard(product: product),
            const SizedBox(height: AppSpacing.spaceMd),
            const ReviewsConsensusSummary(),
            const SizedBox(height: AppSpacing.spaceLg),
            const ReviewsListSection(),
            const SizedBox(height: AppSpacing.spaceXl),
          ],
        ),
      ),
    );
  }
}