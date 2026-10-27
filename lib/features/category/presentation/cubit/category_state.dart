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
  const GetCategoriesSuccessState({required this.categories});

  final List<CategoryEntity> categories;
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
  const GetCategoryDetailsSuccessState({required this.category});

  final CategoryEntity category;
}

class GetCategoryDetailsErrorState extends CategoryState {
  const GetCategoryDetailsErrorState({required this.errMessage});

  final String errMessage;
}
