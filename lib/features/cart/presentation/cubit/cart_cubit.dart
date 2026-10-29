import 'package:aura/features/cart/domain/entities/cart_entity.dart';
import 'package:aura/features/cart/domain/usecases/add_to_cart_usecase.dart';
import 'package:aura/features/cart/domain/usecases/apply_voucher_usecase.dart';
import 'package:aura/features/cart/domain/usecases/clear_cart_usecase.dart';
import 'package:aura/features/cart/domain/usecases/get_cart_usecase.dart';
import 'package:aura/features/cart/domain/usecases/remove_cart_item_usecase.dart';
import 'package:aura/features/cart/domain/usecases/remove_voucher_usecase.dart';
import 'package:aura/features/cart/domain/usecases/update_cart_quantity_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit({
    required this.getCartUseCase,
    required this.addToCartUseCase,
    required this.updateCartQuantityUseCase,
    required this.removeCartItemUseCase,
    required this.clearCartUseCase,
    required this.applyVoucherUseCase,
    required this.removeVoucherUseCase,
  }) : super(const CartInitialState());

  final GetCartUseCase getCartUseCase;
  final AddToCartUseCase addToCartUseCase;
  final UpdateCartQuantityUseCase updateCartQuantityUseCase;
  final RemoveCartItemUseCase removeCartItemUseCase;
  final ClearCartUseCase clearCartUseCase;
  final ApplyVoucherUseCase applyVoucherUseCase;
  final RemoveVoucherUseCase removeVoucherUseCase;

  CartEntity? _currentCart;
  CartEntity? get currentCart => _currentCart;

  @override
  void emit(CartState state) {
    if (!isClosed) {
      super.emit(state);
    }
  }

  Future<void> fetchCart({String? successMessage}) async {
    emit(const CartLoadingState());

    final result = await getCartUseCase();

    result.fold(
      (failure) => emit(CartErrorState(message: failure.errMessage)),
      (cart) {
        _currentCart = cart;
        if (successMessage != null) {
          emit(CartActionSuccessState(cart: cart, message: successMessage));
        } else {
          emit(CartSuccessState(cart: cart));
        }
      },
    );
  }

  Future<void> addToCart({
    required int productId,
    int quantity = 1,
  }) async {
    final result = await addToCartUseCase(
      productId: productId,
      quantity: quantity,
    );

    result.fold(
      (failure) => emit(CartErrorState(message: failure.errMessage)),
      (isAdded) => fetchCart(),
    );
  }

  Future<void> clearCart() async {
    final result = await clearCartUseCase();

    result.fold(
      (failure) => emit(CartErrorState(message: failure.errMessage)),
      (isCleared) => fetchCart(),
    );
  }

  Future<void> updateCartItemQuantity({
    required String itemId,
    required int quantity,
  }) async {
    final result = await updateCartQuantityUseCase(
      itemId: itemId,
      quantity: quantity,
    );

    result.fold(
      (failure) => emit(CartErrorState(message: failure.errMessage)),
      (isUpdated) => fetchCart(),
    );
  }

  Future<void> incrementQuantity(String itemId, int currentQuantity) async {
    await updateCartItemQuantity(
      itemId: itemId,
      quantity: currentQuantity + 1,
    );
  }

  Future<void> decrementQuantity(String itemId, int currentQuantity) async {
    if (currentQuantity > 1) {
      await updateCartItemQuantity(
        itemId: itemId,
        quantity: currentQuantity - 1,
      );
    } else {
      await removeCartItem(itemId);
    }
  }

  Future<void> removeCartItem(String itemId) async {
    final result = await removeCartItemUseCase(itemId: itemId);

    result.fold(
      (failure) => emit(CartErrorState(message: failure.errMessage)),
      (isRemoved) => fetchCart(),
    );
  }

  Future<void> applyVoucher(String promoCode) async {
    final clean = promoCode.trim();
    if (clean.isEmpty) {
      emit(const CartErrorState(
        message: 'Please enter a promo code (e.g. WELCOME10)',
      ));
      return;
    }

    emit(const CartLoadingState());

    final result = await applyVoucherUseCase(promoCode: clean);

    await result.fold(
      (failure) async => emit(CartErrorState(message: failure.errMessage)),
      (isApplied) async =>
          fetchCart(successMessage: 'Promo code applied successfully!'),
    );
  }

  Future<void> removeVoucher() async {
    emit(const CartLoadingState());

    final result = await removeVoucherUseCase();

    await result.fold(
      (failure) async => emit(CartErrorState(message: failure.errMessage)),
      (isRemoved) async => fetchCart(successMessage: 'Promo code removed'),
    );
  }

  void proceedToCheckout() {
    final cart = _currentCart;
    if (cart == null || cart.isEmpty) {
      emit(const CartErrorState(message: 'Your cart is empty.'));
      return;
    }
    emit(CartNavigateToCheckoutState(cart: cart));
  }

  void initiateExpressCheckout() {
    emit(const CartInfoMessageState(
      message: 'Initializing Express Wallet checkout...',
    ));
  }
}
