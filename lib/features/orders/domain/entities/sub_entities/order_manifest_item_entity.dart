class OrderManifestItemEntity {
  const OrderManifestItemEntity({
    required this.id,
    required this.name,
    required this.subtitle,
    required this.quantity,
    required this.price,
    required this.imageUrl,
  });

  final String id;
  final String name;
  final String subtitle;
  final int quantity;
  final String price;
  final String imageUrl;
}
