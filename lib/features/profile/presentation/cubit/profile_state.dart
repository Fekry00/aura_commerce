import 'package:aura/features/profile/domain/entities/profile_entity.dart';

abstract class ProfileState {
  const ProfileState();
}

class ProfileInitialState extends ProfileState {
  const ProfileInitialState();
}

class ProfileLoadingState extends ProfileState {
  const ProfileLoadingState();
}

class ProfileSuccessState extends ProfileState {
  const ProfileSuccessState({required this.profile});

  final ProfileEntity profile;
}

class ProfileErrorState extends ProfileState {
  const ProfileErrorState({required this.message});

  final String message;
}
