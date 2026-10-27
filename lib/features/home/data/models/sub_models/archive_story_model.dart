import 'package:aura/core/network/api/end_points.dart';
import 'package:aura/features/home/domain/entities/sub_entities/archive_story_entity.dart';

class ArchiveStoryModel extends ArchiveStoryEntity {
  const ArchiveStoryModel({
    required super.id,
    required super.label,
    required super.title,
    required super.subtitle,
    required super.imageUrl,
  });

  factory ArchiveStoryModel.fromJson(Map<String, dynamic> json) {
    return ArchiveStoryModel(
      id: json['id']?.toString() ?? '',
      label: json['label'] as String? ?? '',
      title: json['title'] as String? ?? '',
      subtitle: json['subtitle'] as String? ?? '',
      imageUrl: EndPoint.fixImageUrl(
          (json['image_url'] ?? json['imageUrl']) as String?),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'label': label,
      'title': title,
      'subtitle': subtitle,
      'image_url': imageUrl,
    };
  }
}
