class BannerEntity {
  const BannerEntity({
    required this.id,
    required this.title,
    required this.imageUrl,
    this.linkType,
    this.linkTargetId,
    this.externalUrl,
    this.sortOrder,
    this.isActive = true,
  });

  final int id;
  final String title;
  final String imageUrl;
  final String? linkType;
  final int? linkTargetId;
  final String? externalUrl;
  final int? sortOrder;
  final bool isActive;
}