import 'package:aura/features/wishlist/domain/entities/wishlist_entity.dart';
import 'package:aura/features/wishlist/presentation/models/wishlist_summary_data.dart';
import 'package:aura/features/wishlist/presentation/widgets/wishlist_item_data.dart';

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
    this.userFeedback,
  });

  final WishlistEntity wishlist;
  final int selectedCategoryIndex;
  final bool sortAscending;
  final String? userFeedback;

  List<WishlistItemData> get allItems =>
      wishlist.items.map(WishlistItemData.fromEntity).toList();

  List<String> get categoryChips {
    final items = allItems;
    final rawCategories = items
        .map((e) => e.category.trim())
        .where((c) => c.isNotEmpty)
        .toSet()
        .toList();

    return [
      'All (${items.length})',
      ...rawCategories,
    ];
  }

  List<WishlistItemData> get displayedItems {
    final items = allItems;
    final chips = categoryChips;
    int effectiveCategoryIndex = selectedCategoryIndex;
    if (effectiveCategoryIndex >= chips.length) {
      effectiveCategoryIndex = 0;
    }

    List<WishlistItemData> displayed = List.from(items);
    if (effectiveCategoryIndex > 0 && effectiveCategoryIndex < chips.length) {
      final selectedCat = chips[effectiveCategoryIndex];
      displayed = items
          .where((item) => item.category.trim() == selectedCat)
          .toList();
    }

    if (sortAscending) {
      displayed.sort((a, b) => a.price.compareTo(b.price));
    } else {
      displayed.sort((a, b) => b.price.compareTo(a.price));
    }

    return displayed;
  }

  WishlistSummaryData get summary =>
      WishlistSummaryData.fromItems(displayedItems);

  String get sortLabel =>
      sortAscending ? 'Price: Low to High' : 'Price: High to Low';

  WishlistSuccessState copyWith({
    WishlistEntity? wishlist,
    int? selectedCategoryIndex,
    bool? sortAscending,
    String? userFeedback,
  }) {
    return WishlistSuccessState(
      wishlist: wishlist ?? this.wishlist,
      selectedCategoryIndex:
          selectedCategoryIndex ?? this.selectedCategoryIndex,
      sortAscending: sortAscending ?? this.sortAscending,
      userFeedback: userFeedback,
    );
  }
}

class WishlistItemAddedSuccessState extends WishlistSuccessState {
  const WishlistItemAddedSuccessState({
    required super.wishlist,
    super.selectedCategoryIndex,
    super.sortAscending,
    this.message = 'Saved to Wishlist',
  }) : super(userFeedback: message);

  final String message;
}

class WishlistItemRemovedSuccessState extends WishlistSuccessState {
  const WishlistItemRemovedSuccessState({
    required super.wishlist,
    super.selectedCategoryIndex,
    super.sortAscending,
    this.message = 'Removed from Wishlist',
  }) : super(userFeedback: message);

  final String message;
}

class WishlistItemMovedToBagSuccessState extends WishlistSuccessState {
  const WishlistItemMovedToBagSuccessState({
    required super.wishlist,
    super.selectedCategoryIndex,
    super.sortAscending,
    this.message = 'Added to Bag',
  }) : super(userFeedback: message);

  final String message;
}

class WishlistAllMovedToBagSuccessState extends WishlistSuccessState {
  const WishlistAllMovedToBagSuccessState({
    required super.wishlist,
    super.selectedCategoryIndex,
    super.sortAscending,
    this.message = 'Added all available items to Cart',
  }) : super(userFeedback: message);

  final String message;
}

class WishlistInfoMessageState extends WishlistState {
  const WishlistInfoMessageState({required this.message});

  final String message;
}

class WishlistErrorState extends WishlistState {
  const WishlistErrorState({required this.message});

  final String message;
}
