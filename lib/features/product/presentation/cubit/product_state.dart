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

class ProductSuccessState extends ProductState {
  const ProductSuccessState({required this.productDetails});

  final ProductDetailsEntity productDetails;
}

class ProductErrorState extends ProductState {
  const ProductErrorState({required this.message});

  final String message;
}
