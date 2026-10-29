import 'package:aura/features/product/domain/entities/product_details_entity.dart';
import 'package:aura/features/product/domain/entities/sub_entities/product_item_entity.dart';
import 'package:aura/features/product/domain/entities/sub_entities/product_pagination_entity.dart';

abstract class ProductState {
  const ProductState();
}

class ProductInitialState extends ProductState {
  const ProductInitialState();
}

class ProductLoadingState extends ProductState {
  const ProductLoadingState();
}

class ProductListSuccessState extends ProductState {
  const ProductListSuccessState({
    required this.products,
    this.pagination,
  });

  final List<ProductItemEntity> products;
  final ProductPaginationEntity? pagination;
}

class ProductListEmptyState extends ProductState {
  const ProductListEmptyState({this.message = 'No products found'});

  final String message;
}

class ProductSuccessState extends ProductState {
  const ProductSuccessState({
    required this.productDetails,
    this.quantity = 1,
    this.selectedColorIndex = 0,
    this.selectedSizeIndex = 0,
    this.activeImageIndex = 0,
    this.isAddingToCart = false,
  });

  final ProductDetailsEntity productDetails;
  final int quantity;
  final int selectedColorIndex;
  final int selectedSizeIndex;
  final int activeImageIndex;
  final bool isAddingToCart;

  ProductSuccessState copyWith({
    ProductDetailsEntity? productDetails,
    int? quantity,
    int? selectedColorIndex,
    int? selectedSizeIndex,
    int? activeImageIndex,
    bool? isAddingToCart,
  }) {
    return ProductSuccessState(
      productDetails: productDetails ?? this.productDetails,
      quantity: quantity ?? this.quantity,
      selectedColorIndex: selectedColorIndex ?? this.selectedColorIndex,
      selectedSizeIndex: selectedSizeIndex ?? this.selectedSizeIndex,
      activeImageIndex: activeImageIndex ?? this.activeImageIndex,
      isAddingToCart: isAddingToCart ?? this.isAddingToCart,
    );
  }
}

class AddToCartLoadingState extends ProductState {
  const AddToCartLoadingState();
}

class AddToCartSuccessState extends ProductState {
  const AddToCartSuccessState({
    required this.message,
    this.quantity = 1,
  });

  final String message;
  final int quantity;
}
typedef AddToCartSuccess = AddToCartSuccessState;

class AddToCartErrorState extends ProductState {
  const AddToCartErrorState({required this.message});

  final String message;
}
typedef AddToCartError = AddToCartErrorState;

class ProductErrorState extends ProductState {
  const ProductErrorState({required this.message});

  final String message;
}
