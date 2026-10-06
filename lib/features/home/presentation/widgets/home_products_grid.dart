import 'package:aura/core/routing/routes.dart';
import 'package:aura/core/widgets/product_card.dart';
import 'package:flutter/material.dart';

class HomeProductsGrid extends StatefulWidget {
  const HomeProductsGrid({super.key});

  @override
  State<HomeProductsGrid> createState() => _HomeProductsGridState();
}

class _HomeProductsGridState extends State<HomeProductsGrid> {
  final List<Map<String, dynamic>> _products = [
    {
      'title': 'Aethel Minimalist...',
      'price': '\$1,450',
      'rating': 4.9,
      'reviews': 128,
      'badge': 'BESTSELLER',
      'isFavorite': false,
      'image':
          'https://images.unsplash.com/photo-1523275335684-37898b6baf30?q=80&w=600',
    },
    {
      'title': 'Verona Nappa...',
      'price': '\$890',
      'rating': 4.8,
      'reviews': 94,
      'badge': null,
      'isFavorite': true,
      'image':
          'https://images.unsplash.com/photo-1584917865442-de89df76afd3?q=80&w=600',
    },
    {
      'title': 'Oud & Bergamot...',
      'price': '\$320',
      'rating': 5.0,
      'reviews': 210,
      'badge': null,
      'isFavorite': false,
      'image':
          'https://images.unsplash.com/photo-1592945403244-b3fbafd7f539?q=80&w=600',
    },
    {
      'title': 'Structured Cashme...',
      'price': '\$1,280',
      'rating': 4.7,
      'reviews': 65,
      'badge': 'NEW',
      'isFavorite': false,
      'image':
          'https://images.unsplash.com/photo-1539571696357-5a69c17a67c6?q=80&w=600',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: _products.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        childAspectRatio: 0.65,
      ),
      itemBuilder: (context, index) {
        final item = _products[index];
        return ProductCard(
          title: item['title'] as String,
          price: item['price'] as String,
          imageUrl: item['image'] as String,
          rating: item['rating'] as double,
          reviewsCount: item['reviews'] as int,
          badgeText: item['badge'] as String?,
          isFavorite: item['isFavorite'] as bool,
          onFavoriteTap: () {
            setState(() {
              item['isFavorite'] = !(item['isFavorite'] as bool);
            });
          },
          onAddToCart: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Added ${item['title']} to bag!'),
                duration: const Duration(seconds: 1),
              ),
            );
          },
          onTap: () {
            Navigator.pushNamed(
              context,
              Routes.productDetailsView,
              arguments: item,
            );
          },
        );
      },
    );
  }
}
