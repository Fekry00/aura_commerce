import 'package:aura/core/di/injection_container.dart';
import 'package:aura/features/cart/domain/usecases/add_to_cart_usecase.dart';
import 'package:aura/features/product/domain/entities/product_details_entity.dart';
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
    this.addToCartUseCase,
  }) : super(const ProductInitialState());

  final GetProductDetailsUseCase getProductDetailsUseCase;
  final ToggleProductFavoriteUseCase toggleProductFavoriteUseCase;
  final GetProductsUseCase getProductsUseCase;
  final AddToCartUseCase? addToCartUseCase;

  ProductDetailsEntity? _currentDetails;
  ProductDetailsEntity? get currentDetails => _currentDetails;

  int _quantity = 1;
  int get quantity => _quantity;

  int _selectedColorIndex = 0;
  int get selectedColorIndex => _selectedColorIndex;

  int _selectedSizeIndex = 0;
  int get selectedSizeIndex => _selectedSizeIndex;

  int _activeImageIndex = 0;
  int get activeImageIndex => _activeImageIndex;

  @override
  void emit(ProductState state) {
    if (!isClosed) {
      super.emit(state);
    }
  }

  void incrementQuantity() {
    _quantity++;
    _emitSuccessWithDetails();
  }

  void decrementQuantity() {
    if (_quantity > 1) {
      _quantity--;
      _emitSuccessWithDetails();
    }
  }

  void selectColor(int index) {
    if (_selectedColorIndex == index) return;
    _selectedColorIndex = index;
    _emitSuccessWithDetails();
  }

  void selectSize(int index) {
    if (_selectedSizeIndex == index) return;
    _selectedSizeIndex = index;
    _emitSuccessWithDetails();
  }

  void selectImage(int index) {
    if (_activeImageIndex == index) return;
    _activeImageIndex = index;
    _emitSuccessWithDetails();
  }

  String formatTotalPrice(double basePrice) {
    final total = basePrice * _quantity;
    return total.toStringAsFixed(2);
  }

  void _emitSuccessWithDetails() {
    if (_currentDetails != null) {
      emit(ProductSuccessState(
        productDetails: _currentDetails!,
        quantity: _quantity,
        selectedColorIndex: _selectedColorIndex,
        selectedSizeIndex: _selectedSizeIndex,
        activeImageIndex: _activeImageIndex,
      ));
    }
  }

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
      (listModel) {
        if (listModel.items.isEmpty) {
          emit(const ProductListEmptyState());
        } else {
          emit(
            ProductListSuccessState(
              products: listModel.items,
              pagination: listModel.pagination,
            ),
          );
        }
      },
    );
  }

  Future<void> fetchProductDetails(String productId) async {
    emit(const ProductLoadingState());

    final result = await getProductDetailsUseCase(productId: productId);

    result.fold(
      (failure) => emit(ProductErrorState(message: failure.errMessage)),
      (details) {
        _currentDetails = details;
        _quantity = 1;
        _selectedColorIndex = 0;
        _selectedSizeIndex = 0;
        _activeImageIndex = 0;
        emit(ProductSuccessState(
          productDetails: details,
          quantity: _quantity,
          selectedColorIndex: _selectedColorIndex,
          selectedSizeIndex: _selectedSizeIndex,
          activeImageIndex: _activeImageIndex,
        ));
      },
    );
  }

  Future<void> addToCart({
    required int productId,
    int? quantity,
  }) async {
    final qty = quantity ?? _quantity;
    emit(const AddToCartLoadingState());

    final useCase = addToCartUseCase ?? sl<AddToCartUseCase>();
    final result = await useCase(
      productId: productId,
      quantity: qty,
    );

    result.fold(
      (failure) {
        emit(AddToCartErrorState(message: failure.errMessage));
        _emitSuccessWithDetails();
      },
      (success) {
        emit(AddToCartSuccessState(
          message: 'Added $qty item(s) to Bag!',
          quantity: qty,
        ));
        _emitSuccessWithDetails();
      },
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
