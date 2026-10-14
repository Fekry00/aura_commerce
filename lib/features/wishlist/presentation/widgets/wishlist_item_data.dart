class WishlistItemData {
  final String id;
  final String title;
  final String category;
  final double price;
  final double? originalPrice;
  final String imageUrl;
  final String? badge;
  final String stockStatus;
  final bool isLowStock;
  final bool hasComplimentary;

  const WishlistItemData({
    required this.id,
    required this.title,
    required this.category,
    required this.price,
    this.originalPrice,
    required this.imageUrl,
    this.badge,
    required this.stockStatus,
    this.isLowStock = false,
    this.hasComplimentary = false,
  });

  static const List<WishlistItemData> sampleItems = [
    WishlistItemData(
      id: '5',
      title: 'Vitamin C Serum',
      category: 'Skin Care • Atelier Lab',
      price: 999.00,
      originalPrice: 1199.00,
      imageUrl:
          'https://images.unsplash.com/photo-1620916566398-39f1143ab7be?q=80&w=600',
      badge: '-16% Privilege',
      stockStatus: 'In Stock (100 units available)',
    ),
    WishlistItemData(
      id: '12',
      title: 'Aethel Chronograph 40mm',
      category: 'Haute Horlogerie',
      price: 1450.00,
      imageUrl:
          'https://images.unsplash.com/photo-1522335789203-aabd1fc54bc9?q=80&w=600',
      stockStatus: 'Low Vault Stock (3 left)',
      isLowStock: true,
    ),
    WishlistItemData(
      id: '19',
      title: 'Verona Nappa Handbag',
      category: 'Maison Leather • Forest Green',
      price: 890.00,
      originalPrice: 980.00,
      imageUrl:
          'https://images.unsplash.com/photo-1584917865442-de89df76afd3?q=80&w=600',
      badge: 'Exclusive',
      stockStatus: 'In Stock',
    ),
    WishlistItemData(
      id: '27',
      title: 'Oud & Bergamot Extrait',
      category: 'Artisan Fragrance • 100ml',
      price: 320.00,
      imageUrl:
          'https://images.unsplash.com/photo-1592945403244-b3fbafd7f539?q=80&w=600',
      stockStatus: 'Complimentary Flacon Sample',
      hasComplimentary: true,
    ),
  ];
}
