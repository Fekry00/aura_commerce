import 'package:aura/core/di/injection_container.dart' as di;
import 'package:aura/features/cart/domain/usecases/add_to_cart_usecase.dart';
import 'package:aura/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:aura/features/wishlist/domain/entities/wishlist_entity.dart';
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

  WishlistEntity? _currentWishlist;
  WishlistEntity? get currentWishlist => _currentWishlist;

  @override
  void emit(WishlistState state) {
    if (!isClosed) {
      if (state is WishlistSuccessState) {
        _currentWishlist = state.wishlist;
      }
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

    if (showLoading) {
      emit(const WishlistLoadingState());
    }

    final result = await getWishlistUseCase();

    result.fold(
      (failure) => emit(WishlistErrorState(message: failure.errMessage)),
      (wishlist) {
        _currentWishlist = wishlist;
        emit(WishlistSuccessState(
          wishlist: wishlist,
          selectedCategoryIndex: currentCategoryIndex,
          sortAscending: currentSortAscending,
        ));
      },
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
    emit(const WishlistLoadingState());
    final result = await addToWishlistUseCase(productId: productId);
    result.fold(
      (failure) => emit(WishlistErrorState(message: failure.errMessage)),
      (_) async {
        final fetchResult = await getWishlistUseCase();
        fetchResult.fold(
          (failure) => emit(WishlistErrorState(message: failure.errMessage)),
          (updatedWishlist) {
            _currentWishlist = updatedWishlist;
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
    emit(const WishlistLoadingState());
    final result = await removeFromWishlistUseCase(productId: productId);

    result.fold(
      (failure) => emit(WishlistErrorState(message: failure.errMessage)),
      (_) async {
        final fetchResult = await getWishlistUseCase();
        fetchResult.fold(
          (failure) => emit(WishlistErrorState(message: failure.errMessage)),
          (updatedWishlist) {
            _currentWishlist = updatedWishlist;
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

    emit(const WishlistLoadingState());

    // 1. Add item to cart
    final result = await addToCartUseCase(productId: idInt);

    await result.fold(
      (failure) async => emit(WishlistErrorState(message: failure.errMessage)),
      (_) async {
        // 2. Remove item from wishlist
        await removeFromWishlistUseCase(productId: productId);

        // 3. Sync and refresh cart immediately
        try {
          di.sl<CartCubit>().fetchCart();
        } catch (_) {}

        // 4. Fetch updated wishlist and notify UI
        final fetchResult = await getWishlistUseCase();
        fetchResult.fold(
          (failure) => emit(WishlistErrorState(message: failure.errMessage)),
          (updatedWishlist) {
            _currentWishlist = updatedWishlist;
            final cur = state is WishlistSuccessState ? (state as WishlistSuccessState) : null;
            emit(WishlistItemMovedToBagSuccessState(
              wishlist: updatedWishlist,
              selectedCategoryIndex: cur?.selectedCategoryIndex ?? 0,
              sortAscending: cur?.sortAscending ?? false,
            ));
          },
        );
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

    emit(const WishlistLoadingState());

    final result = await moveAllToBagUseCase();

    await result.fold(
      (failure) async {
        // Resilient fallback: iteratively add each available item to cart and remove from wishlist
        bool anyAdded = false;
        for (final item in availableItems) {
          final idInt = int.tryParse(item.id);
          if (idInt != null) {
            final addRes = await addToCartUseCase(productId: idInt);
            if (addRes.isRight()) {
              await removeFromWishlistUseCase(productId: item.id);
              anyAdded = true;
            }
          }
        }

        if (anyAdded) {
          try {
            di.sl<CartCubit>().fetchCart();
          } catch (_) {}

          final fetchResult = await getWishlistUseCase();
          fetchResult.fold(
            (fail) => emit(WishlistErrorState(message: fail.errMessage)),
            (updatedWishlist) {
              _currentWishlist = updatedWishlist;
              emit(WishlistAllMovedToBagSuccessState(
                wishlist: updatedWishlist,
                selectedCategoryIndex: current.selectedCategoryIndex,
                sortAscending: current.sortAscending,
              ));
            },
          );
        } else {
          emit(WishlistErrorState(message: failure.errMessage));
        }
      },
      (_) async {
        try {
          di.sl<CartCubit>().fetchCart();
        } catch (_) {}

        final fetchResult = await getWishlistUseCase();
        fetchResult.fold(
          (failure) => emit(WishlistErrorState(message: failure.errMessage)),
          (updatedWishlist) {
            _currentWishlist = updatedWishlist;
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
