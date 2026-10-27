import 'package:aura/core/theme/app_colors.dart';
import 'package:aura/core/theme/app_typography.dart';
import 'package:aura/core/utils/functions/custom_snack_bar.dart';
import 'package:aura/features/product/domain/entities/sub_entities/product_item_entity.dart';
import 'package:aura/features/product/presentation/controllers/product_reviews_controller.dart';
import 'package:aura/features/product/presentation/cubit/review_cubit.dart';
import 'package:aura/features/product/presentation/cubit/review_state.dart';
import 'package:aura/features/product/presentation/utils/product_ui_helper.dart';
import 'package:aura/features/product/presentation/widgets/product_reviews_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductReviewsView extends StatefulWidget {
  final ProductItemEntity product;

  const ProductReviewsView({
    super.key,
    required this.product,
  });

  @override
  State<ProductReviewsView> createState() => _ProductReviewsViewState();
}

class _ProductReviewsViewState extends State<ProductReviewsView> {
  late final ProductReviewsController _controller;

  @override
  void initState() {
    super.initState();
    _controller = ProductReviewsController();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ReviewCubit, ReviewState>(
      listener: (context, state) {
        if (state is ReviewSubmitSuccessState) {
          showCustomSnackBar(
            context,
            message: state.message,
            type: SnackBarType.success,
          );
        } else if (state is ReviewErrorState) {
          showCustomSnackBar(
            context,
            message: state.message,
            type: SnackBarType.error,
          );
        }
      },
      builder: (context, state) {
        final reviews = context.watch<ReviewCubit>().reviews;
        final count = reviews.length;
        final isLoading = state is ReviewLoadingState && reviews.isEmpty;

        return Material(
          color: const Color(0xFFF9FAFB),
          child: Scaffold(
            backgroundColor: const Color(0xFFF9FAFB),
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              centerTitle: true,
              leading: IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios_new_rounded,
                  size: 18,
                  color: AppColors.onSurface,
                ),
                onPressed: () => Navigator.pop(context),
              ),
              title: Column(
                children: [
                  Text(
                    'Client Reviews',
                    style: AppTypography.headlineSm.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    ProductUiHelper.formatReviewsHeader(count),
                    style: AppTypography.bodySm.copyWith(
                      color: AppColors.slateBody,
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
              actions: [
                IconButton(
                  icon: const Icon(
                    Icons.rate_review_outlined,
                    color: Color(0xFF1E382B),
                    size: 20,
                  ),
                  onPressed: () => _controller.showAddReviewModal(
                    context,
                    widget.product.id.toString(),
                  ),
                ),
              ],
            ),
            body: ProductReviewsBody(
              product: widget.product,
              reviews: reviews,
              isLoading: isLoading,
              controller: _controller,
              onStateUpdate: () => setState(() {}),
            ),
          ),
        );
      },
    );
  }
}