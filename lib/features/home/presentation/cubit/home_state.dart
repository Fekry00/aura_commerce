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
  const HomeSuccessState({required this.homeFeed});

  final HomeFeedEntity homeFeed;
}

class HomeErrorState extends HomeState {
  const HomeErrorState({required this.message});

  final String message;
}
