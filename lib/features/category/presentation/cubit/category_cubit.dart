import 'package:aura/features/category/domain/entities/category_entity.dart';
import 'package:aura/features/category/domain/usecases/get_categories_usecase.dart';
import 'package:aura/features/category/domain/usecases/get_category_details_usecase.dart';
import 'package:aura/features/product/domain/entities/sub_entities/product_item_entity.dart';
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

  int _selectedPillIndex = 0;
  int get selectedPillIndex => _selectedPillIndex;

  CategoryEntity? _selectedCategory;
  CategoryEntity? get selectedCategory => _selectedCategory;

  String _deliverTo = 'New York, 10001';
  String get deliverTo => _deliverTo;

  int _selectedSubDepartmentIndex = 0;
  int get selectedSubDepartmentIndex => _selectedSubDepartmentIndex;

  CategoryEntity? _currentCategoryDetails;
  CategoryEntity? get currentCategoryDetails => _currentCategoryDetails;

  @override
  void emit(CategoryState state) {
    if (!isClosed) {
      super.emit(state);
    }
  }

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
          emit(GetCategoriesSuccessState(
            categories: categories,
            selectedCategory: _selectedCategory,
            selectedPillIndex: _selectedPillIndex,
            deliverTo: _deliverTo,
          ));
        }
      },
    );
  }

  void searchCategories(String query) {
    if (query.trim().isEmpty) {
      emit(GetCategoriesSuccessState(
        categories: _allCategories,
        selectedCategory: _selectedCategory,
        selectedPillIndex: _selectedPillIndex,
        deliverTo: _deliverTo,
      ));
      return;
    }

    final filtered = _allCategories
        .where((cat) =>
            cat.name.toLowerCase().contains(query.toLowerCase()) ||
            (cat.description?.toLowerCase().contains(query.toLowerCase()) ?? false))
        .toList();

    emit(GetCategoriesSuccessState(
      categories: filtered,
      selectedCategory: _selectedCategory,
      selectedPillIndex: _selectedPillIndex,
      deliverTo: _deliverTo,
    ));
  }

  void selectPill({
    required int index,
    required String pillText,
  }) {
    _selectedPillIndex = index;
    if (index == 0) {
      _selectedCategory = null;
    } else if (index - 1 < _allCategories.length) {
      _selectedCategory = _allCategories[index - 1];
    } else {
      _selectedCategory = null;
    }

    filterByPill(pillText);
  }

  void filterByPill(String pill) {
    if (pill == 'All Maisons' || pill == 'All') {
      emit(GetCategoriesSuccessState(
        categories: _allCategories,
        selectedCategory: _selectedCategory,
        selectedPillIndex: _selectedPillIndex,
        deliverTo: _deliverTo,
      ));
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
      categories: filtered.isNotEmpty ? filtered : _allCategories,
      selectedCategory: _selectedCategory,
      selectedPillIndex: _selectedPillIndex,
      deliverTo: _deliverTo,
    ));
  }

  void resetFilters() {
    _selectedPillIndex = 0;
    _selectedCategory = null;
    emit(GetCategoriesSuccessState(
      categories: _allCategories,
      selectedCategory: null,
      selectedPillIndex: 0,
      deliverTo: _deliverTo,
    ));
  }

  void switchDeliveryAddress(String address) {
    _deliverTo = address;
    emit(CategoryActionMessageState(
      message: 'Delivery residence switched to $address',
      isSuccess: false,
    ));
    if (state is GetCategoriesSuccessState) {
      final cur = state as GetCategoriesSuccessState;
      emit(GetCategoriesSuccessState(
        categories: cur.categories,
        selectedCategory: cur.selectedCategory,
        selectedPillIndex: cur.selectedPillIndex,
        deliverTo: address,
      ));
    }
  }

  void submitCommissionInquiry(String note) {
    emit(const CategoryActionMessageState(
      message: 'Commission inquiry submitted to your Private Concierge!',
      isSuccess: true,
    ));
  }

  Future<void> getCategoryDetails(int id) async {
    emit(const GetCategoryDetailsLoadingState());

    final result = await getCategoryDetailsUseCase(id);

    result.fold(
      (failure) => emit(GetCategoryDetailsErrorState(errMessage: failure.errMessage)),
      (category) {
        _currentCategoryDetails = category;
        emit(GetCategoryDetailsSuccessState(
          category: category,
          selectedSubDepartmentIndex: _selectedSubDepartmentIndex,
        ));
      },
    );
  }

  void setInitialSubDepartment(
    CategoryEntity category,
    String? initialSubDepartment,
  ) {
    _currentCategoryDetails = category;
    _selectedSubDepartmentIndex = 0;
    if (initialSubDepartment != null && category.subDepartments.isNotEmpty) {
      final index = category.subDepartments.indexWhere(
        (s) => s.name.toLowerCase() == initialSubDepartment.toLowerCase(),
      );
      if (index != -1) {
        _selectedSubDepartmentIndex = index + 1;
      }
    }
  }

  void selectSubDepartment(int index) {
    _selectedSubDepartmentIndex = index;
    if (_currentCategoryDetails != null) {
      emit(GetCategoryDetailsSuccessState(
        category: _currentCategoryDetails!,
        selectedSubDepartmentIndex: index,
      ));
    }
  }

  List<ProductItemEntity> filterProducts({
    required List<ProductItemEntity> allProducts,
    required List<SubDepartmentEntity> subDepartments,
    int? subDepartmentIndex,
  }) {
    final index = subDepartmentIndex ?? _selectedSubDepartmentIndex;
    if (index == 0 || subDepartments.isEmpty) {
      return allProducts;
    }
    final subName = subDepartments[index - 1].name.toLowerCase();
    return allProducts.where((prod) {
      final text =
          '${prod.name.toLowerCase()} ${(prod.description ?? '').toLowerCase()}';
      return text.contains(subName);
    }).toList();
  }
}
