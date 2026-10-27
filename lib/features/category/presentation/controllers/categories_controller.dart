import 'package:aura/core/routing/routes.dart';
import 'package:aura/core/utils/functions/custom_snack_bar.dart';
import 'package:aura/features/category/domain/entities/category_entity.dart';
import 'package:aura/features/category/presentation/cubit/category_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoriesController {
  final TextEditingController searchController = TextEditingController();
  int selectedPillIndex = 0;
  String deliverTo = 'New York, 10001';
  CategoryEntity? selectedCategory;

  void dispose() {
    searchController.dispose();
  }

  void onSearchChanged(BuildContext context, String query) {
    context.read<CategoryCubit>().searchCategories(query);
  }

  void clearSearch(BuildContext context, VoidCallback onCleared) {
    searchController.clear();
    context.read<CategoryCubit>().searchCategories('');
    onCleared();
  }

  void onPillSelected(
    BuildContext context, {
    required int index,
    required String pillText,
    required List<CategoryEntity> allCategories,
    required VoidCallback onUpdate,
  }) {
    selectedPillIndex = index;
    if (index == 0) {
      selectedCategory = null;
    } else if (index - 1 < allCategories.length) {
      selectedCategory = allCategories[index - 1];
    } else {
      selectedCategory = null;
    }
    onUpdate();
    context.read<CategoryCubit>().filterByPill(pillText);
  }

  Future<void> onRefresh(
    BuildContext context, {
    required VoidCallback onReset,
  }) async {
    searchController.clear();
    selectedPillIndex = 0;
    selectedCategory = null;
    onReset();
    await context.read<CategoryCubit>().getCategories();
  }

  void onExploreHero(BuildContext context, List<CategoryEntity> allCategories) {
    final targetCategory = selectedCategory ??
        (allCategories.isNotEmpty ? allCategories.first : null);
    if (targetCategory != null) {
      Navigator.pushNamed(
        context,
        Routes.categoryDetailsView,
        arguments: targetCategory,
      );
    }
  }

  void onCategoryTapped(BuildContext context, CategoryEntity category) {
    Navigator.pushNamed(
      context,
      Routes.categoryDetailsView,
      arguments: category,
    );
  }

  void onAddressSelected(
    BuildContext context, {
    required String title,
    required VoidCallback onUpdated,
  }) {
    deliverTo = title;
    onUpdated();
    Navigator.pop(context);
    showCustomSnackBar(
      context,
      message: 'Delivery residence switched to $title',
      type: SnackBarType.info,
    );
  }

  void onCommissionSubmitted(BuildContext context, String note) {
    Navigator.pop(context);
    showCustomSnackBar(
      context,
      message: 'Commission inquiry submitted to your Private Concierge!',
      type: SnackBarType.success,
    );
  }
}
