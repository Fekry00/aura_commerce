import 'package:aura/core/widgets/product_card.dart';
import 'package:aura/features/home/domain/entities/sub_entities/product_highlight_entity.dart';
import 'package:flutter/material.dart';

class HomeProductsGrid extends StatelessWidget {
  final List<ProductHighlightEntity>? products;
  final String? emptyMessage;
  final void Function(ProductHighlightEntity item)? onFavoriteTap;
  final void Function(ProductHighlightEntity item)? onAddToCart;
  final void Function(ProductHighlightEntity item)? onProductTap;

  const HomeProductsGrid({
    super.key,
    this.products,
    this.emptyMessage,
    this.onFavoriteTap,
    this.onAddToCart,
    this.onProductTap,
  });

  @override
  Widget build(BuildContext context) {
    final items = products ?? [];

    if (items.isEmpty) {
      return Container(
        height: 140,
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.category_outlined, size: 36, color: Colors.black26),
            const SizedBox(height: 8),
            Text(
              emptyMessage ?? 'No products available right now.',
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.black54, fontSize: 13),
            ),
          ],
        ),
      );
    }

    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: items.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        childAspectRatio: 0.70,
      ),
      itemBuilder: (context, index) {
        final item = items[index];
        final priceString = '${item.price.toStringAsFixed(0)} EGP';

        return ProductCard(
          title: item.title,
          price: priceString,
          imageUrl: item.imageUrl,
          rating: item.rating.average,
          reviewsCount: item.rating.reviewsCount,
          badgeText: item.badge,
          isFavorite: item.isFavorite,
          onFavoriteTap: () => onFavoriteTap?.call(item),
          onAddToCart: () => onAddToCart?.call(item),
          onTap: () => onProductTap?.call(item),
        );
      },
    );
  }
}
