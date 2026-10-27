import 'package:equatable/equatable.dart';

class SubDepartmentEntity extends Equatable {
  const SubDepartmentEntity({
    required this.id,
    required this.name,
    this.badge,
    this.description,
    this.editionsCount,
    this.image,
    this.iconKey,
  });

  final int id;
  final String name;
  final String? badge;
  final String? description;
  final String? editionsCount;
  final String? image;
  final String? iconKey;

  @override
  List<Object?> get props => [
        id,
        name,
        badge,
        description,
        editionsCount,
        image,
        iconKey,
      ];
}

class CategoryEntity extends Equatable {
  const CategoryEntity({
    required this.id,
    required this.name,
    required this.slug,
    this.description,
    this.parentCategoryId,
    this.isActive = true,
    this.image,
    this.createdAt,
    this.creationsCount,
    this.collectionLabel,
    this.subDepartments = const [],
  });

  final int id;
  final String name;
  final String slug;
  final String? description;
  final int? parentCategoryId;
  final bool isActive;
  final String? image;
  final String? createdAt;
  final String? creationsCount;
  final String? collectionLabel;
  final List<SubDepartmentEntity> subDepartments;

  CategoryEntity copyWith({
    int? id,
    String? name,
    String? slug,
    String? description,
    int? parentCategoryId,
    bool? isActive,
    String? image,
    String? createdAt,
    String? creationsCount,
    String? collectionLabel,
    List<SubDepartmentEntity>? subDepartments,
  }) {
    return CategoryEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      slug: slug ?? this.slug,
      description: description ?? this.description,
      parentCategoryId: parentCategoryId ?? this.parentCategoryId,
      isActive: isActive ?? this.isActive,
      image: image ?? this.image,
      createdAt: createdAt ?? this.createdAt,
      creationsCount: creationsCount ?? this.creationsCount,
      collectionLabel: collectionLabel ?? this.collectionLabel,
      subDepartments: subDepartments ?? this.subDepartments,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        slug,
        description,
        parentCategoryId,
        isActive,
        image,
        createdAt,
        creationsCount,
        collectionLabel,
        subDepartments,
      ];
}
