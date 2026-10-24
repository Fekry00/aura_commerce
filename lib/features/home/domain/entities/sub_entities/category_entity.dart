class CategoryEntity {
  const CategoryEntity({
    required this.id,
    required this.name,
    this.slug,
    this.description,
    this.image,
    this.parentCategoryId,
    this.isActive = true,
  });

  final int id;
  final String name;
  final String? slug;
  final String? description;
  final String? image;
  final int? parentCategoryId;
  final bool isActive;
}