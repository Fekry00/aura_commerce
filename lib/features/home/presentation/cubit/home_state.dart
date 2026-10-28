import 'package:aura/features/home/domain/entities/home_feed_entity.dart';

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
  });

  final HomeFeedEntity homeFeed;
  final int? selectedCategoryId;
  final String? selectedCategoryName;
  final int selectedTab;

  HomeSuccessState copyWith({
    HomeFeedEntity? homeFeed,
    int? selectedCategoryId,
    bool clearCategory = false,
    String? selectedCategoryName,
    int? selectedTab,
  }) {
    return HomeSuccessState(
      homeFeed: homeFeed ?? this.homeFeed,
      selectedCategoryId:
          clearCategory ? null : (selectedCategoryId ?? this.selectedCategoryId),
      selectedCategoryName:
          clearCategory ? null : (selectedCategoryName ?? this.selectedCategoryName),
      selectedTab: selectedTab ?? this.selectedTab,
    );
  }
}

class HomeErrorState extends HomeState {
  const HomeErrorState({required this.message});

  final String message;
}
