import 'package:aura/core/di/injection_container.dart';
import 'package:aura/core/theme/app_colors.dart';
import 'package:aura/core/theme/app_typography.dart';
import 'package:aura/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:aura/features/product/presentation/cubit/product_cubit.dart';
import 'package:aura/features/product/presentation/cubit/product_state.dart';
import 'package:aura/features/product/presentation/widgets/product_detail_app_bar.dart';
import 'package:aura/features/product/presentation/widgets/product_image_section.dart';
import 'package:aura/features/product/presentation/widgets/product_specifications_card.dart';
import 'package:aura/features/product/presentation/widgets/product_sticky_bottom_bar.dart';
import 'package:aura/features/product/presentation/widgets/product_variants_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductDetailsView extends StatelessWidget {
  final Map<String, dynamic> product;

  const ProductDetailsView({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    final productId = product['id']?.toString() ?? '1';
    final intId = int.tryParse(productId) ?? 1;

    return BlocProvider(
      create: (context) => sl<ProductCubit>()..fetchProductDetails(productId),
      child: BlocBuilder<ProductCubit, ProductState>(
        builder: (context, state) {
          final details =
              state is ProductSuccessState ? state.productDetails : null;
          final liveProduct = details?.product;

          final title = liveProduct?.name ??
              (product['title'] ?? product['name'] ?? 'Product Details');

          final rawPrice = liveProduct?.minPrice.toDouble() ??
              (product['price'] is num
                  ? (product['price'] as num).toDouble()
                  : double.tryParse(product['price']?.toString().replaceAll(RegExp(r'[^0-9.]'), '') ?? '0') ?? 0.0);

          final price = liveProduct != null
              ? '${liveProduct.minPrice.toStringAsFixed(0)} EGP'
              : (product['price'] ?? '0 EGP');

          final comparePrice = liveProduct?.compareAtPrice != null
              ? '${liveProduct!.compareAtPrice!.toStringAsFixed(0)} EGP'
              : null;

          final inStock = liveProduct?.inStock ?? true;
          final description = liveProduct?.description ??
              product['description'] as String? ??
              'Authentic luxury product from our private catalogue.';

          final imageUrl = liveProduct?.thumbnailUrl ??
              product['image'] ??
              product['thumbnailUrl'] ??
              '';

          final rating = liveProduct?.rating ??
              (product['rating'] as num?)?.toDouble() ??
              4.9;
          final reviewsCount = liveProduct?.reviewsCount ??
              product['reviews'] as int? ??
              120;

          return Scaffold(
            backgroundColor: Colors.white,
            appBar: const ProductDetailAppBar(),
            bottomNavigationBar: ProductStickyBottomBar(
              productId: intId,
              basePrice: rawPrice > 0 ? rawPrice : 1000.0,
              onAddToBag: (qty) {
                try {
                  context.read<CartCubit>().addToCart(
                        productId: intId,
                        quantity: qty,
                      );
                } catch (_) {}
              },
            ),
            body: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ProductImageSection(
                    imageUrl: imageUrl,
                    rating: rating,
                    reviews: reviewsCount,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(AppSpacing.margin),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (liveProduct?.categoryName != null) ...[
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFF1E382B).withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              liveProduct!.categoryName!.toUpperCase(),
                              style: AppTypography.labelCaps.copyWith(
                                color: const Color(0xFF1E382B),
                                fontSize: 10,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          const SizedBox(height: AppSpacing.spaceSm),
                        ],
                        Text(
                          title,
                          style: AppTypography.headlineSm
                              .copyWith(fontWeight: FontWeight.w800),
                        ),
                        const SizedBox(height: AppSpacing.spaceSm),
                        Row(
                          children: [
                            Text(
                              price,
                              style: AppTypography.priceHero,
                            ),
                            if (comparePrice != null) ...[
                              const SizedBox(width: AppSpacing.spaceSm),
                              Text(
                                comparePrice,
                                style: AppTypography.bodySm.copyWith(
                                  color: AppColors.slateBody,
                                  decoration: TextDecoration.lineThrough,
                                ),
                              ),
                            ],
                            const SizedBox(width: AppSpacing.spaceSm + 2),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: AppSpacing.spaceSm,
                                vertical: AppSpacing.spaceXs - 1,
                              ),
                              decoration: BoxDecoration(
                                color: inStock
                                    ? const Color(0xFFE8F5E9)
                                    : const Color(0xFFFFEBEE),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                inStock ? 'IN STOCK' : 'OUT OF STOCK',
                                style: AppTypography.labelCaps.copyWith(
                                  color: inStock
                                      ? const Color(0xFF2E7D32)
                                      : const Color(0xFFC62828),
                                  fontSize: 10,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: AppSpacing.spaceMd),
                        Text(
                          description,
                          style: AppTypography.bodySm.copyWith(
                            color: AppColors.slateBody,
                            height: 1.5,
                          ),
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
        },
      ),
    );
  }
}