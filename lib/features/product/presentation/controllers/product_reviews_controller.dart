import 'package:aura/features/product/domain/entities/sub_entities/product_review_entity.dart';
import 'package:aura/features/product/presentation/cubit/review_cubit.dart';
import 'package:aura/features/product/presentation/widgets/add_review_modal_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductReviewsController {
  int selectedFilter = 0; // 0: All, 1: 5 Stars, 2: 4 Stars

  List<String> getFilterLabels(List<ProductReviewEntity> allReviews) {
    final count = allReviews.length;
    final stars5Count = allReviews.where((r) => r.rating.round() == 5).length;
    final stars4Count = allReviews.where((r) => r.rating.round() == 4).length;

    return [
      'All ($count)',
      '★ 5 Stars ($stars5Count)',
      '★ 4 Stars ($stars4Count)',
    ];
  }

  List<ProductReviewEntity> getFilteredReviews(
    List<ProductReviewEntity> allReviews,
  ) {
    if (selectedFilter == 1) {
      return allReviews.where((r) => r.rating.round() == 5).toList();
    } else if (selectedFilter == 2) {
      return allReviews.where((r) => r.rating.round() == 4).toList();
    }
    return allReviews;
  }

  void onFilterSelected(int index, VoidCallback onUpdate) {
    if (selectedFilter == index) return;
    selectedFilter = index;
    onUpdate();
  }

  void showAddReviewModal(BuildContext context, String productId) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (bottomSheetContext) {
        return AddReviewModalSheet(
          productId: productId,
          onSubmitReview: (rating, comment) {
            context.read<ReviewCubit>().submitReview(
                  productId: productId,
                  rating: rating,
                  comment: comment,
                );
          },
        );
      },
    );
  }
}
