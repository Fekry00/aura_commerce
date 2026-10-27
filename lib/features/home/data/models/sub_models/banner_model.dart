import 'package:aura/core/network/api/end_points.dart';
import 'package:aura/features/home/domain/entities/sub_entities/banner_entity.dart';

class BannerModel extends BannerEntity {
  const BannerModel({
    required super.id,
    required super.title,
    required super.imageUrl,
    super.linkType,
    super.linkTargetId,
    super.externalUrl,
    super.sortOrder,
    super.isActive = true,
  });

  factory BannerModel.fromJson(Map<String, dynamic> json) {
    return BannerModel(
      id: json['id'] is int
          ? json['id'] as int
          : int.tryParse(json['id']?.toString() ?? '0') ?? 0,
      title: json['title'] as String? ?? '',
      imageUrl: EndPoint.fixImageUrl(
          (json['imageUrl'] ?? json['image_url'] ?? json['image']) as String?),
      linkType: (json['linkType'] ?? json['link_type']) as String?,
      linkTargetId: json['linkTargetId'] is int
          ? json['linkTargetId'] as int
          : int.tryParse(json['linkTargetId']?.toString() ?? ''),
      externalUrl: (json['externalUrl'] ?? json['external_url']) as String?,
      sortOrder: json['sortOrder'] is int
          ? json['sortOrder'] as int
          : int.tryParse(json['sortOrder']?.toString() ?? ''),
      isActive: json['isActive'] as bool? ?? (json['is_active'] as bool? ?? true),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'imageUrl': imageUrl,
      'linkType': linkType,
      'linkTargetId': linkTargetId,
      'externalUrl': externalUrl,
      'sortOrder': sortOrder,
      'isActive': isActive,
    };
  }
}

