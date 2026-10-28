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
  const WishlistSuccessState({
    required this.wishlist,
    this.selectedCategoryIndex = 0,
    this.sortAscending = false,
  });

  final WishlistEntity wishlist;
  final int selectedCategoryIndex;
  final bool sortAscending;

  WishlistSuccessState copyWith({
    WishlistEntity? wishlist,
    int? selectedCategoryIndex,
    bool? sortAscending,
  }) {
    return WishlistSuccessState(
      wishlist: wishlist ?? this.wishlist,
      selectedCategoryIndex:
          selectedCategoryIndex ?? this.selectedCategoryIndex,
      sortAscending: sortAscending ?? this.sortAscending,
    );
  }
}

class WishlistErrorState extends WishlistState {
  const WishlistErrorState({required this.message});

  final String message;
}
