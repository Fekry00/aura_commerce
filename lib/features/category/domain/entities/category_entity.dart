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
