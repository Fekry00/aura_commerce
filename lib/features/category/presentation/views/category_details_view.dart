import 'package:aura/core/theme/app_colors.dart';
import 'package:aura/features/category/domain/entities/category_entity.dart';
import 'package:aura/features/category/presentation/cubit/category_cubit.dart';
import 'package:aura/features/category/presentation/widgets/category_details_view_body.dart';
import 'package:aura/features/product/presentation/cubit/product_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryDetailsView extends StatefulWidget {
  final CategoryEntity category;
  final String? initialSubDepartment;

  const CategoryDetailsView({
    super.key,
    required this.category,
    this.initialSubDepartment,
  });

  @override
  State<CategoryDetailsView> createState() => _CategoryDetailsViewState();
}

class _CategoryDetailsViewState extends State<CategoryDetailsView> {
  @override
  void initState() {
    super.initState();
    final cubit = context.read<CategoryCubit>();
    cubit.setInitialSubDepartment(widget.category, widget.initialSubDepartment);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      cubit.getCategoryDetails(widget.category.id);
      context.read<ProductCubit>().fetchProducts(categoryId: widget.category.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: CategoryDetailsViewBody(initialCategory: widget.category),
    );
  }
}
