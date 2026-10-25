import 'package:aura/features/product/domain/usecases/get_product_details_usecase.dart';
import 'package:aura/features/product/domain/usecases/get_products_usecase.dart';
import 'package:aura/features/product/domain/usecases/toggle_product_favorite_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit({
    required this.getProductDetailsUseCase,
    required this.toggleProductFavoriteUseCase,
    required this.getProductsUseCase,
  }) : super(const ProductInitialState());

  final GetProductDetailsUseCase getProductDetailsUseCase;
  final ToggleProductFavoriteUseCase toggleProductFavoriteUseCase;
  final GetProductsUseCase getProductsUseCase;

  Future<void> fetchProducts({
    String? search,
    int? categoryId,
    String? filterBy,
    bool? inStock,
    num? minPrice,
    num? maxPrice,
    String? sortBy,
    int? page,
    int? perPage,
  }) async {
    emit(const ProductLoadingState());

    final result = await getProductsUseCase(
      search: search,
      categoryId: categoryId,
      filterBy: filterBy,
      inStock: inStock,
      minPrice: minPrice,
      maxPrice: maxPrice,
      sortBy: sortBy,
      page: page,
      perPage: perPage,
    );

    result.fold(
      (failure) => emit(ProductErrorState(message: failure.errMessage)),
      (listModel) => emit(
        ProductListSuccessState(
          products: listModel.items,
          pagination: listModel.pagination,
        ),
      ),
    );
  }

  Future<void> fetchProductDetails(String productId) async {
    emit(const ProductLoadingState());

    final result = await getProductDetailsUseCase(productId: productId);

    result.fold(
      (failure) => emit(ProductErrorState(message: failure.errMessage)),
      (details) => emit(ProductSuccessState(productDetails: details)),
    );
  }

  Future<void> toggleFavorite(String productId) async {
    final result = await toggleProductFavoriteUseCase(productId: productId);

    result.fold(
      (failure) => null,
      (isFavorite) {
        if (state is ProductSuccessState) {
          fetchProductDetails(productId);
        }
      },
    );
  }
}
