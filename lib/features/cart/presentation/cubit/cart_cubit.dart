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

  Future<void> fetchCart() async {
    emit(const CartLoadingState());

    final result = await getCartUseCase();

    result.fold(
      (failure) => emit(CartErrorState(message: failure.errMessage)),
      (cart) => emit(CartSuccessState(cart: cart)),
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
      (failure) => null,
      (isAdded) => fetchCart(),
    );
  }

  Future<void> clearCart() async {
    final result = await clearCartUseCase();

    result.fold(
      (failure) => null,
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
      (failure) => null,
      (isUpdated) {
        if (state is CartSuccessState) {
          fetchCart();
        }
      },
    );
  }

  Future<void> removeCartItem(String itemId) async {
    final result = await removeCartItemUseCase(itemId: itemId);

    result.fold(
      (failure) => null,
      (isRemoved) {
        if (state is CartSuccessState) {
          fetchCart();
        }
      },
    );
  }

  Future<void> applyVoucher(String promoCode) async {
    final result = await applyVoucherUseCase(promoCode: promoCode);

    result.fold(
      (failure) => null,
      (isApplied) {
        if (state is CartSuccessState) {
          fetchCart();
        }
      },
    );
  }

  Future<void> removeVoucher() async {
    final result = await removeVoucherUseCase();

    result.fold(
      (failure) => null,
      (isRemoved) {
        if (state is CartSuccessState) {
          fetchCart();
        }
      },
    );
  }
}
