class BannerEntity {
  const BannerEntity({
    required this.id,
    required this.tag,
    required this.title,
    required this.subtitle,
    required this.ctaText,
    required this.imageUrl,
  });

  final String id;
  final String tag;
  final String title;
  final String subtitle;
  final String ctaText;
  final String imageUrl;
}