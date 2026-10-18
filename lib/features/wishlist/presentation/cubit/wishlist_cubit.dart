import 'package:aura/features/wishlist/domain/usecases/get_wishlist_usecase.dart';
import 'package:aura/features/wishlist/domain/usecases/move_all_to_bag_usecase.dart';
import 'package:aura/features/wishlist/domain/usecases/remove_from_wishlist_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'wishlist_state.dart';

class WishlistCubit extends Cubit<WishlistState> {
  WishlistCubit({
    required this.getWishlistUseCase,
    required this.removeFromWishlistUseCase,
    required this.moveAllToBagUseCase,
  }) : super(const WishlistInitialState());

  final GetWishlistUseCase getWishlistUseCase;
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

  Future<void> removeItem(String productId) async {
    final result = await removeFromWishlistUseCase(productId: productId);

    result.fold(
      (failure) => null,
      (isRemoved) {
        if (state is WishlistSuccessState) {
          fetchWishlist();
        }
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
