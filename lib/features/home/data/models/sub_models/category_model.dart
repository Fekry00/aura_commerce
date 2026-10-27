import 'package:aura/core/network/api/end_points.dart';
import 'package:aura/features/home/domain/entities/sub_entities/category_entity.dart';

class CategoryModel extends CategoryEntity {
  const CategoryModel({
    required super.id,
    required super.name,
    super.slug,
    super.description,
    super.image,
    super.parentCategoryId,
    super.isActive = true,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'] is int
          ? json['id'] as int
          : int.tryParse(json['id']?.toString() ?? '0') ?? 0,
      name: json['name'] as String? ?? '',
      slug: json['slug'] as String?,
      description: json['description'] as String?,
      image: EndPoint.fixImageUrl(
          (json['image'] ?? json['imageUrl'] ?? json['image_url']) as String?),
      parentCategoryId: json['parentCategoryId'] is int
          ? json['parentCategoryId'] as int
          : int.tryParse(json['parentCategoryId']?.toString() ?? ''),
      isActive: json['isActive'] as bool? ?? (json['is_active'] as bool? ?? true),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'slug': slug,
      'description': description,
      'image': image,
      'parentCategoryId': parentCategoryId,
      'isActive': isActive,
    };
  }
}

