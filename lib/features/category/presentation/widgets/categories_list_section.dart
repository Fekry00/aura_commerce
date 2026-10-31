import 'package:aura/features/category/domain/entities/category_entity.dart';
import 'package:aura/features/category/presentation/cubit/category_cubit.dart';
import 'package:aura/features/category/presentation/cubit/category_state.dart';
import 'package:aura/features/category/presentation/widgets/categories_empty_state.dart';
import 'package:aura/features/category/presentation/widgets/categories_error_state.dart';
import 'package:aura/features/category/presentation/widgets/category_card.dart';
import 'package:aura/core/theme/app_typography.dart';
import 'package:aura/features/category/presentation/widgets/category_shimmer_skeleton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoriesListSection extends StatelessWidget {
  const CategoriesListSection({
    super.key,
    required this.onCategoryTap,
    required this.onRetry,
  });

  final ValueChanged<CategoryEntity> onCategoryTap;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryCubit, CategoryState>(
      builder: (context, state) {
        if (state is GetCategoriesLoadingState || state is CategoryInitialState) {
          return const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: AppSpacing.margin),
              child: CategoryShimmerSkeleton(),
            ),
          );
        }

        if (state is GetCategoriesErrorState) {
          return SliverToBoxAdapter(
            child: CategoriesErrorState(
              message: state.errMessage,
              onRetry: onRetry,
            ),
          );
        }

        final categories = (state is GetCategoriesSuccessState)
            ? state.categories
            : context.read<CategoryCubit>().allCategories;

        if (categories.isEmpty) {
          return const SliverToBoxAdapter(
            child: CategoriesEmptyState(),
          );
        }

        return SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final category = categories[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 14),
                  child: CategoryCard(
                    category: category,
                    onTap: () => onCategoryTap(category),
                  ),
                );
              },
              childCount: categories.length,
            ),
          ),
        );
      },
    );
  }
}
