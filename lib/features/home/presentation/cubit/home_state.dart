import 'package:aura/features/home/domain/entities/home_feed_entity.dart';
import 'package:aura/features/home/domain/entities/sub_entities/product_highlight_entity.dart';

abstract class HomeState {
  const HomeState();
}

class HomeInitialState extends HomeState {
  const HomeInitialState();
}

class HomeLoadingState extends HomeState {
  const HomeLoadingState();
}

class HomeSuccessState extends HomeState {
  const HomeSuccessState({
    required this.homeFeed,
    this.selectedCategoryId,
    this.selectedCategoryName,
    this.selectedTab = 0,
    this.remainingDropDuration =
        const Duration(hours: 8, minutes: 24, seconds: 11),
  });

  final HomeFeedEntity homeFeed;
  final int? selectedCategoryId;
  final String? selectedCategoryName;
  final int selectedTab;
  final Duration remainingDropDuration;

  String get formattedDropHours =>
      remainingDropDuration.inHours.toString().padLeft(2, '0');

  String get formattedDropMinutes =>
      remainingDropDuration.inMinutes.remainder(60).toString().padLeft(2, '0');

  String get formattedDropSeconds =>
      remainingDropDuration.inSeconds.remainder(60).toString().padLeft(2, '0');

  List<ProductHighlightEntity> get filteredProducts {
    var filtered = homeFeed.highlights;
    if (selectedCategoryId != null) {
      filtered =
          filtered.where((p) => p.categoryId == selectedCategoryId).toList();
    }
    if (selectedTab == 1) {
      filtered = filtered.where((p) => p.isPopular).toList();
    }
    return filtered;
  }

  String get emptyProductsMessage {
    if (selectedCategoryId != null) {
      return 'No products found in ${selectedCategoryName ?? 'this category'}.';
    }
    if (selectedTab == 1) {
      return 'No popular products found right now.';
    }
    return 'No products available right now.';
  }

  HomeSuccessState copyWith({
    HomeFeedEntity? homeFeed,
    int? selectedCategoryId,
    bool clearCategory = false,
    String? selectedCategoryName,
    int? selectedTab,
    Duration? remainingDropDuration,
  }) {
    return HomeSuccessState(
      homeFeed: homeFeed ?? this.homeFeed,
      selectedCategoryId: clearCategory
          ? null
          : (selectedCategoryId ?? this.selectedCategoryId),
      selectedCategoryName: clearCategory
          ? null
          : (selectedCategoryName ?? this.selectedCategoryName),
      selectedTab: selectedTab ?? this.selectedTab,
      remainingDropDuration:
          remainingDropDuration ?? this.remainingDropDuration,
    );
  }
}

class HomeErrorState extends HomeState {
  const HomeErrorState({required this.message});

  final String message;
}
