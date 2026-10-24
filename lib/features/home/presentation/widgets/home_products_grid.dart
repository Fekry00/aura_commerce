import 'package:aura/core/routing/routes.dart';
import 'package:aura/core/widgets/product_card.dart';
import 'package:aura/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:aura/features/home/domain/entities/sub_entities/product_highlight_entity.dart';
import 'package:aura/features/home/presentation/cubit/home_cubit.dart';
import 'package:aura/features/wishlist/presentation/cubit/wishlist_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeProductsGrid extends StatelessWidget {
  final List<ProductHighlightEntity>? products;
  final String? emptyMessage;

  const HomeProductsGrid({
    super.key,
    this.products,
    this.emptyMessage,
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
          onFavoriteTap: () {
            final willBeFavorite = !item.isFavorite;
            context.read<HomeCubit>().toggleFavorite(
                  item.id,
                  currentIsFavorite: item.isFavorite,
                );
            final intId = int.tryParse(item.id);
            if (intId != null) {
              context.read<WishlistCubit>().toggleWishlist(
                    intId,
                    isCurrentlyFavorite: item.isFavorite,
                  );
            }
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  willBeFavorite
                      ? 'Added ${item.title} to Wishlist ❤️'
                      : 'Removed ${item.title} from Wishlist',
                ),
                duration: const Duration(seconds: 1),
              ),
            );
          },
          onAddToCart: () {
            final intId = int.tryParse(item.id);
            if (intId != null) {
              context.read<CartCubit>().addToCart(productId: intId);
            }
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Added ${item.title} to bag! 🛒'),
                duration: const Duration(seconds: 1),
              ),
            );
          },
          onTap: () {
            Navigator.pushNamed(
              context,
              Routes.productDetailsView,
              arguments: {
                'id': item.id,
                'title': item.title,
                'price': priceString,
                'image': item.imageUrl,
                'rating': item.rating.average,
                'reviews': item.rating.reviewsCount,
              },
            );
          },
        );
      },
    );
  }
}
