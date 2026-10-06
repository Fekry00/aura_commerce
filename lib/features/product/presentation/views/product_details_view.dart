import 'package:aura/core/theme/app_colors.dart';
import 'package:aura/core/theme/app_typography.dart';
import 'package:aura/features/product/presentation/widgets/product_detail_app_bar.dart';
import 'package:aura/features/product/presentation/widgets/product_image_section.dart';
import 'package:aura/features/product/presentation/widgets/product_specifications_card.dart';
import 'package:aura/features/product/presentation/widgets/product_sticky_bottom_bar.dart';
import 'package:aura/features/product/presentation/widgets/product_variants_selector.dart';
import 'package:flutter/material.dart';

class ProductDetailsView extends StatelessWidget {
  final Map<String, dynamic> product;

  const ProductDetailsView({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const ProductDetailAppBar(),
      bottomNavigationBar: const ProductStickyBottomBar(),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProductImageSection(
              imageUrl: product['image'] ?? 'https://images.unsplash.com/photo-1523275335684-37898b6baf30?q=80&w=600',
              rating: (product['rating'] as num?)?.toDouble() ?? 4.9,
              reviews: product['reviews'] ?? 128,
            ),
            Padding(
              padding: const EdgeInsets.all(AppSpacing.margin),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product['title'] ?? 'Aethel Minimalist Chronograph 40mm',
                    style: AppTypography.headlineSm.copyWith(fontWeight: FontWeight.w800),
                  ),
                  const SizedBox(height: AppSpacing.spaceSm),
                  Row(
                    children: [
                      Text(
                        product['price'] ?? '\$1,450.00',
                        style: AppTypography.priceHero,
                      ),
                      const SizedBox(width: AppSpacing.spaceSm + 2),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.spaceSm,
                          vertical: AppSpacing.spaceXs - 1,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFE8F5E9),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          'IN STOCK',
                          style: AppTypography.labelCaps.copyWith(
                            color: const Color(0xFF2E7D32),
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.spaceXs + 2),
                  Text(
                    'Or 4 interest-free payments of \$362.50 with Klarna',
                    style: AppTypography.bodySm.copyWith(color: AppColors.slateBody),
                  ),
                  const SizedBox(height: AppSpacing.spaceLg),
                  const Divider(thickness: 0.5),
                  const SizedBox(height: AppSpacing.spaceMd),
                  const ProductVariantsSelector(),
                  const SizedBox(height: AppSpacing.spaceLg),
                  const Divider(thickness: 0.5),
                  const SizedBox(height: AppSpacing.spaceMd),
                  const ProductSpecificationsCard(),
                  const SizedBox(height: AppSpacing.spaceXl),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}