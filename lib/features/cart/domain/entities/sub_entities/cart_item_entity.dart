class CartItemEntity {
  const CartItemEntity({
    required this.id,
    required this.category,
    required this.title,
    required this.subtitle,
    required this.price,
    required this.quantity,
    required this.imageUrl,
  });

  final String id;
  final String category;
  final String title;
  final String subtitle;
  final double price;
  final int quantity;
  final String imageUrl;
}
