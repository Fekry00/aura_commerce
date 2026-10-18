import 'package:aura/features/home/domain/entities/sub_entities/banner_entity.dart';

class BannerModel extends BannerEntity {
  const BannerModel({
    required super.id,
    required super.tag,
    required super.title,
    required super.subtitle,
    required super.ctaText,
    required super.imageUrl,
  });

  factory BannerModel.fromJson(Map<String, dynamic> json) {
    return BannerModel(
      id: json['id']?.toString() ?? '',
      tag: json['tag'] as String? ?? '',
      title: json['title'] as String? ?? '',
      subtitle: json['subtitle'] as String? ?? '',
      ctaText: (json['cta_text'] ?? json['ctaText']) as String? ?? '',
      imageUrl: (json['image_url'] ?? json['imageUrl']) as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'tag': tag,
      'title': title,
      'subtitle': subtitle,
      'cta_text': ctaText,
      'image_url': imageUrl,
    };
  }
}
