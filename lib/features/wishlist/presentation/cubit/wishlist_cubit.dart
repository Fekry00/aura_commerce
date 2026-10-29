import 'package:aura/features/cart/domain/usecases/add_to_cart_usecase.dart';
import 'package:aura/features/wishlist/domain/usecases/add_to_wishlist_usecase.dart';
import 'package:aura/features/wishlist/domain/usecases/get_wishlist_usecase.dart';
import 'package:aura/features/wishlist/domain/usecases/move_all_to_bag_usecase.dart';
import 'package:aura/features/wishlist/domain/usecases/remove_from_wishlist_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'wishlist_state.dart';

class WishlistCubit extends Cubit<WishlistState> {
  WishlistCubit({
    required this.getWishlistUseCase,
    required this.addToWishlistUseCase,
    required this.removeFromWishlistUseCase,
    required this.moveAllToBagUseCase,
    required this.addToCartUseCase,
  }) : super(const WishlistInitialState());

  final GetWishlistUseCase getWishlistUseCase;
  final AddToWishlistUseCase addToWishlistUseCase;
  final RemoveFromWishlistUseCase removeFromWishlistUseCase;
  final MoveAllToBagUseCase moveAllToBagUseCase;
  final AddToCartUseCase addToCartUseCase;

  @override
  void emit(WishlistState state) {
    if (!isClosed) {
      super.emit(state);
    }
  }

  Future<void> fetchWishlist({bool showLoading = true}) async {
    final currentCategoryIndex = (state is WishlistSuccessState)
        ? (state as WishlistSuccessState).selectedCategoryIndex
        : 0;
    final currentSortAscending = (state is WishlistSuccessState)
        ? (state as WishlistSuccessState).sortAscending
        : false;

    if (showLoading && state is! WishlistSuccessState) {
      emit(const WishlistLoadingState());
    }

    final result = await getWishlistUseCase();

    result.fold(
      (failure) => emit(WishlistErrorState(message: failure.errMessage)),
      (wishlist) => emit(WishlistSuccessState(
        wishlist: wishlist,
        selectedCategoryIndex: currentCategoryIndex,
        sortAscending: currentSortAscending,
      )),
    );
  }

  void selectCategory(int index) {
    if (state is WishlistSuccessState) {
      final current = state as WishlistSuccessState;
      if (current.selectedCategoryIndex != index) {
        emit(current.copyWith(selectedCategoryIndex: index));
      }
    }
  }

  void toggleSort() {
    if (state is WishlistSuccessState) {
      final current = state as WishlistSuccessState;
      emit(current.copyWith(sortAscending: !current.sortAscending));
    }
  }

  Future<void> addToWishlist(int productId) async {
    final result = await addToWishlistUseCase(productId: productId);
    result.fold(
      (failure) => emit(WishlistErrorState(message: failure.errMessage)),
      (_) async {
        final fetchResult = await getWishlistUseCase();
        fetchResult.fold(
          (failure) => emit(WishlistErrorState(message: failure.errMessage)),
          (updatedWishlist) {
            final cur = state is WishlistSuccessState ? (state as WishlistSuccessState) : null;
            emit(WishlistItemAddedSuccessState(
              wishlist: updatedWishlist,
              selectedCategoryIndex: cur?.selectedCategoryIndex ?? 0,
              sortAscending: cur?.sortAscending ?? false,
            ));
          },
        );
      },
    );
  }

  Future<void> toggleWishlist(int productId, {required bool isCurrentlyFavorite}) async {
    if (isCurrentlyFavorite) {
      await removeItem(productId.toString());
    } else {
      await addToWishlist(productId);
    }
  }

  Future<void> removeItem(String productId) async {
    final result = await removeFromWishlistUseCase(productId: productId);

    result.fold(
      (failure) => emit(WishlistErrorState(message: failure.errMessage)),
      (_) async {
        final fetchResult = await getWishlistUseCase();
        fetchResult.fold(
          (failure) => emit(WishlistErrorState(message: failure.errMessage)),
          (updatedWishlist) {
            final cur = state is WishlistSuccessState ? (state as WishlistSuccessState) : null;
            emit(WishlistItemRemovedSuccessState(
              wishlist: updatedWishlist,
              selectedCategoryIndex: cur?.selectedCategoryIndex ?? 0,
              sortAscending: cur?.sortAscending ?? false,
            ));
          },
        );
      },
    );
  }

  Future<void> moveToBag(String productId) async {
    final idInt = int.tryParse(productId);
    if (idInt == null) return;

    final result = await addToCartUseCase(productId: idInt);
    result.fold(
      (failure) => emit(WishlistErrorState(message: failure.errMessage)),
      (_) {
        final cur = state is WishlistSuccessState ? (state as WishlistSuccessState) : null;
        if (cur != null) {
          emit(WishlistItemMovedToBagSuccessState(
            wishlist: cur.wishlist,
            selectedCategoryIndex: cur.selectedCategoryIndex,
            sortAscending: cur.sortAscending,
          ));
        } else {
          fetchWishlist(showLoading: false);
        }
      },
    );
  }

  Future<void> addAllToCart() async {
    if (state is! WishlistSuccessState) return;

    final current = state as WishlistSuccessState;
    final availableItems = current.displayedItems
        .where((i) => !i.stockStatus.toLowerCase().contains('out of stock'))
        .toList();

    if (availableItems.isEmpty) {
      emit(const WishlistInfoMessageState(message: 'No available items to add to cart'));
      return;
    }

    final result = await moveAllToBagUseCase();
    result.fold(
      (failure) => emit(WishlistErrorState(message: failure.errMessage)),
      (_) async {
        final fetchResult = await getWishlistUseCase();
        fetchResult.fold(
          (failure) => emit(WishlistErrorState(message: failure.errMessage)),
          (updatedWishlist) {
            emit(WishlistAllMovedToBagSuccessState(
              wishlist: updatedWishlist,
              selectedCategoryIndex: current.selectedCategoryIndex,
              sortAscending: current.sortAscending,
            ));
          },
        );
      },
    );
  }
}
