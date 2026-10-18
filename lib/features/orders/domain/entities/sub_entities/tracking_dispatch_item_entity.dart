class TrackingDispatchItemEntity {
  const TrackingDispatchItemEntity({
    required this.id,
    required this.category,
    required this.title,
    required this.subtitle,
    required this.quantity,
    required this.price,
    required this.serialTag,
    required this.imageUrl,
    this.nftCertificateId,
  });

  final String id;
  final String category;
  final String title;
  final String subtitle;
  final String quantity;
  final String price;
  final String serialTag;
  final String imageUrl;
  final String? nftCertificateId;
}
