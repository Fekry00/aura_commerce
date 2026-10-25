import 'package:aura/features/category/domain/entities/category_entity.dart';

class SubDepartmentModel extends SubDepartmentEntity {
  const SubDepartmentModel({
    required super.id,
    required super.name,
    super.badge,
    super.description,
    super.editionsCount,
    super.image,
    super.iconKey,
  });

  factory SubDepartmentModel.fromJson(Map<String, dynamic> json) {
    return SubDepartmentModel(
      id: json['id'] is int
          ? json['id'] as int
          : int.tryParse(json['id']?.toString() ?? '0') ?? 0,
      name: json['name'] as String? ?? '',
      badge: json['badge'] as String?,
      description: json['description'] as String?,
      editionsCount: (json['editionsCount'] ?? json['editions_count']) as String?,
      image: json['image'] as String?,
      iconKey: (json['iconKey'] ?? json['icon_key']) as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      if (badge != null) 'badge': badge,
      if (description != null) 'description': description,
      if (editionsCount != null) 'editionsCount': editionsCount,
      if (image != null) 'image': image,
      if (iconKey != null) 'iconKey': iconKey,
    };
  }
}

class CategoryModel extends CategoryEntity {
  const CategoryModel({
    required super.id,
    required super.name,
    required super.slug,
    super.description,
    super.parentCategoryId,
    super.isActive = true,
    super.image,
    super.createdAt,
    super.creationsCount,
    super.collectionLabel,
    super.subDepartments = const [],
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    final subDepsJson = json['subDepartments'] ?? json['sub_departments'];
    List<SubDepartmentEntity> subDeps = [];
    if (subDepsJson is List) {
      subDeps = subDepsJson
          .map((e) => SubDepartmentModel.fromJson(e as Map<String, dynamic>))
          .toList();
    }

    return CategoryModel(
      id: json['id'] is int
          ? json['id'] as int
          : int.tryParse(json['id']?.toString() ?? '0') ?? 0,
      name: json['name'] as String? ?? '',
      slug: json['slug'] as String? ?? '',
      description: json['description'] as String?,
      parentCategoryId: json['parentCategoryId'] != null
          ? (json['parentCategoryId'] is int
              ? json['parentCategoryId'] as int
              : int.tryParse(json['parentCategoryId'].toString()))
          : (json['parent_category_id'] != null
              ? (json['parent_category_id'] is int
                  ? json['parent_category_id'] as int
                  : int.tryParse(json['parent_category_id'].toString()))
              : null),
      isActive: (json['isActive'] ?? json['is_active']) as bool? ?? true,
      image: json['image'] as String?,
      createdAt: (json['createdAt'] ?? json['created_at']) as String?,
      creationsCount: (json['creationsCount'] ?? json['creations_count']) as String?,
      collectionLabel: (json['collectionLabel'] ?? json['collection_label']) as String?,
      subDepartments: subDeps,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'slug': slug,
      if (description != null) 'description': description,
      'parentCategoryId': parentCategoryId,
      'isActive': isActive,
      if (image != null) 'image': image,
      if (createdAt != null) 'createdAt': createdAt,
      if (creationsCount != null) 'creationsCount': creationsCount,
      if (collectionLabel != null) 'collectionLabel': collectionLabel,
      'subDepartments': subDepartments
          .map((e) => e is SubDepartmentModel
              ? e.toJson()
              : {
                  'id': e.id,
                  'name': e.name,
                  'badge': e.badge,
                  'description': e.description,
                  'editionsCount': e.editionsCount,
                  'image': e.image,
                  'iconKey': e.iconKey,
                })
          .toList(),
    };
  }
}
