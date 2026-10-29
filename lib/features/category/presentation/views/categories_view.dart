import 'package:aura/core/routing/routes.dart';
import 'package:aura/core/theme/app_colors.dart';
import 'package:aura/core/utils/functions/custom_snack_bar.dart';
import 'package:aura/features/category/domain/entities/category_entity.dart';
import 'package:aura/features/category/presentation/cubit/category_cubit.dart';
import 'package:aura/features/category/presentation/cubit/category_state.dart';
import 'package:aura/features/category/presentation/widgets/categories_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoriesView extends StatefulWidget {
  const CategoriesView({super.key});

  @override
  State<CategoriesView> createState() => _CategoriesViewState();
}

class _CategoriesViewState extends State<CategoriesView> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onCategoryTapped(BuildContext context, CategoryEntity category) {
    Navigator.pushNamed(
      context,
      Routes.categoryDetailsView,
      arguments: category,
    );
  }

  void _onExploreHero(
    BuildContext context,
    CategoryEntity? selectedCategory,
    List<CategoryEntity> allCategories,
  ) {
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

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CategoryCubit, CategoryState>(
      listener: (context, state) {
        if (state is CategoryActionMessageState) {
          showCustomSnackBar(
            context,
            message: state.message,
            type: state.isSuccess ? SnackBarType.success : SnackBarType.info,
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColors.background,
          body: SafeArea(
            bottom: false,
            child: CategoriesViewBody(
              searchController: _searchController,
              onCategoryTapped: _onCategoryTapped,
              onExploreHero: _onExploreHero,
            ),
          ),
        );
      },
    );
  }
}
