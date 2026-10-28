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
  }) : super(const WishlistInitialState());

  final GetWishlistUseCase getWishlistUseCase;
  final AddToWishlistUseCase addToWishlistUseCase;
  final RemoveFromWishlistUseCase removeFromWishlistUseCase;
  final MoveAllToBagUseCase moveAllToBagUseCase;

  @override
  void emit(WishlistState state) {
    if (!isClosed) {
      super.emit(state);
    }
  }

  Future<void> fetchWishlist() async {
    final currentCategoryIndex = (state is WishlistSuccessState)
        ? (state as WishlistSuccessState).selectedCategoryIndex
        : 0;
    final currentSortAscending = (state is WishlistSuccessState)
        ? (state as WishlistSuccessState).sortAscending
        : false;

    emit(const WishlistLoadingState());

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
      (isAdded) => fetchWishlist(),
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
      (isRemoved) {
        fetchWishlist();
      },
    );
  }

  Future<bool> moveAllToBag() async {
    final result = await moveAllToBagUseCase();

    return result.fold(
      (failure) {
        emit(WishlistErrorState(message: failure.errMessage));
        return false;
      },
      (isMoved) {
        fetchWishlist();
        return isMoved;
      },
    );
  }
}
