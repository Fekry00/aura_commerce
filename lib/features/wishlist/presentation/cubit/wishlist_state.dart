import 'package:aura/features/wishlist/domain/entities/wishlist_entity.dart';

abstract class WishlistState {
  const WishlistState();
}

class WishlistInitialState extends WishlistState {
  const WishlistInitialState();
}

class WishlistLoadingState extends WishlistState {
  const WishlistLoadingState();
}

class WishlistSuccessState extends WishlistState {
  const WishlistSuccessState({required this.wishlist});

  final WishlistEntity wishlist;
}

class WishlistErrorState extends WishlistState {
  const WishlistErrorState({required this.message});

  final String message;
}
