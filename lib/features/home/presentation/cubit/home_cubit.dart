import 'package:aura/features/home/domain/entities/home_feed_entity.dart';
import 'package:aura/features/home/domain/entities/sub_entities/category_entity.dart';
import 'package:aura/features/home/domain/entities/sub_entities/product_highlight_entity.dart';
import 'package:aura/features/home/domain/usecases/get_home_feed_usecase.dart';
import 'package:aura/features/home/domain/usecases/toggle_favorite_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit({
    required this.getHomeFeedUseCase,
    required this.toggleFavoriteUseCase,
  }) : super(const HomeInitialState());

  final GetHomeFeedUseCase getHomeFeedUseCase;
  final ToggleFavoriteUseCase toggleFavoriteUseCase;

  @override
  void emit(HomeState state) {
    if (!isClosed) {
      super.emit(state);
    }
  }

  Future<void> fetchHomeFeed() async {
    final currentCategoryId = (state is HomeSuccessState)
        ? (state as HomeSuccessState).selectedCategoryId
        : null;
    final currentCategoryName = (state is HomeSuccessState)
        ? (state as HomeSuccessState).selectedCategoryName
        : null;
    final currentTab = (state is HomeSuccessState)
        ? (state as HomeSuccessState).selectedTab
        : 0;

    emit(const HomeLoadingState());

    final result = await getHomeFeedUseCase();

    result.fold(
      (failure) => emit(HomeErrorState(message: failure.errMessage)),
      (feed) => emit(HomeSuccessState(
        homeFeed: feed,
        selectedCategoryId: currentCategoryId,
        selectedCategoryName: currentCategoryName,
        selectedTab: currentTab,
      )),
    );
  }

  void selectCategory(CategoryEntity? category) {
    if (state is HomeSuccessState) {
      final current = state as HomeSuccessState;
      if (category == null) {
        emit(current.copyWith(clearCategory: true));
      } else {
        emit(current.copyWith(
          selectedCategoryId: category.id,
          selectedCategoryName: category.name,
        ));
      }
    }
  }

  void clearCategorySelection() {
    if (state is HomeSuccessState) {
      emit((state as HomeSuccessState).copyWith(clearCategory: true));
    }
  }

  void selectTab(int index) {
    if (state is HomeSuccessState) {
      final current = state as HomeSuccessState;
      if (current.selectedTab != index) {
        emit(current.copyWith(selectedTab: index));
      }
    }
  }

  Future<void> toggleFavorite(String productId, {bool? currentIsFavorite}) async {
    final currentState = state;
    if (currentState is HomeSuccessState) {
      final feed = currentState.homeFeed;
      final existingIndex = feed.highlights.indexWhere((p) => p.id == productId);
      final isCurrentlyFav = currentIsFavorite ??
          (existingIndex != -1 ? feed.highlights[existingIndex].isFavorite : false);

      if (existingIndex != -1) {
        final oldItem = feed.highlights[existingIndex];
        final updatedHighlights = List<ProductHighlightEntity>.from(feed.highlights);
        updatedHighlights[existingIndex] = ProductHighlightEntity(
          id: oldItem.id,
          title: oldItem.title,
          price: oldItem.price,
          imageUrl: oldItem.imageUrl,
          rating: oldItem.rating,
          badge: oldItem.badge,
          isFavorite: !isCurrentlyFav,
          isPopular: oldItem.isPopular,
          categoryId: oldItem.categoryId,
          categoryName: oldItem.categoryName,
        );

        emit(HomeSuccessState(
          homeFeed: HomeFeedEntity(
            deliveryLocation: feed.deliveryLocation,
            banners: feed.banners,
            categories: feed.categories,
            highlights: updatedHighlights,
            curatedDrop: feed.curatedDrop,
            archiveStory: feed.archiveStory,
          ),
          selectedCategoryId: currentState.selectedCategoryId,
          selectedCategoryName: currentState.selectedCategoryName,
          selectedTab: currentState.selectedTab,
        ));
      }

      await toggleFavoriteUseCase(
        productId: productId,
        isCurrentlyFavorite: isCurrentlyFav,
      );
    } else {
      await toggleFavoriteUseCase(
        productId: productId,
        isCurrentlyFavorite: currentIsFavorite ?? false,
      );
    }
  }
}