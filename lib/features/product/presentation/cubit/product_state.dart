import 'package:aura/features/product/domain/entities/product_details_entity.dart';

abstract class ProductState {
  const ProductState();
}

class ProductInitialState extends ProductState {
  const ProductInitialState();
}

class ProductLoadingState extends ProductState {
  const ProductLoadingState();
}

class ProductSuccessState extends ProductState {
  const ProductSuccessState({required this.productDetails});

  final ProductDetailsEntity productDetails;
}

class ProductErrorState extends ProductState {
  const ProductErrorState({required this.message});

  final String message;
}
