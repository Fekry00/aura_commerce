import 'package:aura/features/category/domain/entities/category_entity.dart';

abstract class CategoryState {
  const CategoryState();
}

class CategoryInitialState extends CategoryState {
  const CategoryInitialState();
}

class GetCategoriesLoadingState extends CategoryState {
  const GetCategoriesLoadingState();
}

class GetCategoriesSuccessState extends CategoryState {
  const GetCategoriesSuccessState({
    required this.categories,
    this.selectedCategory,
    this.selectedPillIndex = 0,
    this.deliverTo = 'New York, 10001',
  });

  final List<CategoryEntity> categories;
  final CategoryEntity? selectedCategory;
  final int selectedPillIndex;
  final String deliverTo;
}

class GetCategoriesEmptyState extends CategoryState {
  const GetCategoriesEmptyState({this.message = 'No categories found'});

  final String message;
}

class GetCategoriesErrorState extends CategoryState {
  const GetCategoriesErrorState({required this.errMessage});

  final String errMessage;
}

class GetCategoryDetailsLoadingState extends CategoryState {
  const GetCategoryDetailsLoadingState();
}

class GetCategoryDetailsSuccessState extends CategoryState {
  const GetCategoryDetailsSuccessState({
    required this.category,
    this.selectedSubDepartmentIndex = 0,
  });

  final CategoryEntity category;
  final int selectedSubDepartmentIndex;
}

class GetCategoryDetailsErrorState extends CategoryState {
  const GetCategoryDetailsErrorState({required this.errMessage});

  final String errMessage;
}

class CategoryActionMessageState extends CategoryState {
  const CategoryActionMessageState({
    required this.message,
    this.isSuccess = false,
  });

  final String message;
  final bool isSuccess;
}
