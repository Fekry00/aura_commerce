import 'package:aura/features/category/domain/entities/category_entity.dart';
import 'package:aura/features/category/domain/usecases/get_categories_usecase.dart';
import 'package:aura/features/category/domain/usecases/get_category_details_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  CategoryCubit({
    required this.getCategoriesUseCase,
    required this.getCategoryDetailsUseCase,
  }) : super(const CategoryInitialState());

  final GetCategoriesUseCase getCategoriesUseCase;
  final GetCategoryDetailsUseCase getCategoryDetailsUseCase;

  List<CategoryEntity> _allCategories = [];
  List<CategoryEntity> get allCategories => _allCategories;

  Future<void> getCategories() async {
    emit(const GetCategoriesLoadingState());

    final result = await getCategoriesUseCase();

    result.fold(
      (failure) => emit(GetCategoriesErrorState(errMessage: failure.errMessage)),
      (categories) {
        _allCategories = categories;
        if (categories.isEmpty) {
          emit(const GetCategoriesEmptyState());
        } else {
          emit(GetCategoriesSuccessState(categories: categories));
        }
      },
    );
  }

  void searchCategories(String query) {
    if (query.trim().isEmpty) {
      emit(GetCategoriesSuccessState(categories: _allCategories));
      return;
    }

    final filtered = _allCategories
        .where((cat) =>
            cat.name.toLowerCase().contains(query.toLowerCase()) ||
            (cat.description?.toLowerCase().contains(query.toLowerCase()) ?? false))
        .toList();

    emit(GetCategoriesSuccessState(categories: filtered));
  }

  void filterByPill(String pill) {
    if (pill == 'All Maisons' || pill == 'All') {
      emit(GetCategoriesSuccessState(categories: _allCategories));
      return;
    }

    final lower = pill.toLowerCase();
    final filtered = _allCategories.where((c) {
      final name = c.name.toLowerCase();
      final slug = c.slug.toLowerCase();

      if (name.contains(lower) ||
          slug.contains(lower) ||
          lower.contains(name) ||
          lower.contains(slug)) {
        return true;
      }

      if (pill == 'Vault Exclusives') {
        return c.subDepartments.any((s) =>
            s.badge?.toUpperCase().contains('VAULT') == true ||
            s.badge?.toUpperCase().contains('EXCLUSIVE') == true ||
            s.badge?.toUpperCase().contains('UNHEATED') == true);
      }

      if (pill == 'Numbered Runs') {
        return c.subDepartments.any((s) =>
            s.badge?.toUpperCase().contains('NUMBERED') == true ||
            s.badge?.toUpperCase().contains('3 LEFT') == true ||
            s.badge?.toUpperCase().contains('COMPLICATION') == true);
      }

      if (pill == 'Atelier Bespoke') {
        return c.subDepartments.any((s) =>
            s.badge?.toUpperCase().contains('BESPOKE') == true ||
            s.badge?.toUpperCase().contains('SIGNATURE') == true ||
            s.badge?.toUpperCase().contains('HERITAGE') == true ||
            s.badge?.toUpperCase().contains('HIGH JEWELRY') == true);
      }

      return false;
    }).toList();

    emit(GetCategoriesSuccessState(
        categories: filtered.isNotEmpty ? filtered : _allCategories));
  }

  Future<void> getCategoryDetails(int id) async {
    emit(const GetCategoryDetailsLoadingState());

    final result = await getCategoryDetailsUseCase(id);

    result.fold(
      (failure) => emit(GetCategoryDetailsErrorState(errMessage: failure.errMessage)),
      (category) => emit(GetCategoryDetailsSuccessState(category: category)),
    );
  }
}
