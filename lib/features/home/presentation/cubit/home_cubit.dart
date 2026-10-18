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

  Future<void> fetchHomeFeed() async {
    emit(const HomeLoadingState());

    final result = await getHomeFeedUseCase();

    result.fold(
      (failure) => emit(HomeErrorState(message: failure.errMessage)),
      (feed) => emit(HomeSuccessState(homeFeed: feed)),
    );
  }

  Future<void> toggleFavorite(String productId) async {
    final result = await toggleFavoriteUseCase(productId: productId);

    result.fold(
      (failure) => null,
      (isFavorite) {
        if (state is HomeSuccessState) {
          fetchHomeFeed();
        }
      },
    );
  }
}