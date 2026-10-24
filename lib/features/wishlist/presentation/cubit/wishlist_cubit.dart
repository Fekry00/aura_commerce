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

  Future<void> fetchWishlist() async {
    emit(const WishlistLoadingState());

    final result = await getWishlistUseCase();

    result.fold(
      (failure) => emit(WishlistErrorState(message: failure.errMessage)),
      (wishlist) => emit(WishlistSuccessState(wishlist: wishlist)),
    );
  }

  Future<void> addToWishlist(int productId) async {
    final result = await addToWishlistUseCase(productId: productId);
    result.fold(
      (failure) => null,
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
      (failure) => null,
      (isRemoved) {
        fetchWishlist();
      },
    );
  }

  Future<void> moveAllToBag() async {
    final result = await moveAllToBagUseCase();

    result.fold(
      (failure) => null,
      (isMoved) {
        if (state is WishlistSuccessState) {
          fetchWishlist();
        }
      },
    );
  }
}
