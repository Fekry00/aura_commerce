import 'package:aura/core/utils/functions/custom_snack_bar.dart';
import 'package:aura/features/product/domain/entities/sub_entities/product_item_entity.dart';
import 'package:aura/features/product/presentation/cubit/review_cubit.dart';
import 'package:aura/features/product/presentation/cubit/review_state.dart';
import 'package:aura/features/product/presentation/widgets/add_review_modal_sheet.dart';
import 'package:aura/features/product/presentation/widgets/product_reviews_app_bar.dart';
import 'package:aura/features/product/presentation/widgets/product_reviews_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductReviewsView extends StatelessWidget {
  final ProductItemEntity product;

  const ProductReviewsView({
    super.key,
    required this.product,
  });

  void _showAddReviewModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (bottomSheetContext) => AddReviewModalSheet(
        productId: product.id.toString(),
        onSubmitReview: (rating, comment) {
          context.read<ReviewCubit>().submitReview(
                productId: product.id.toString(),
                rating: rating,
                comment: comment,
              );
        },
      ),
    );
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

        return Scaffold(
          backgroundColor: const Color(0xFFF9FAFB),
          appBar: ProductReviewsAppBar(
            reviewsCount: count,
            onBackTap: () => Navigator.pop(context),
            onAddReviewTap: () => _showAddReviewModal(context),
          ),
          body: ProductReviewsBody(
            product: product,
            reviews: reviews,
            isLoading: isLoading,
            onWriteReviewTap: () => _showAddReviewModal(context),
          ),
        );
      },
    );
  }
}