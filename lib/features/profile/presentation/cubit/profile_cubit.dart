import 'package:aura/features/profile/domain/usecases/get_profile_usecase.dart';
import 'package:aura/features/profile/domain/usecases/sign_out_usecase.dart';
import 'package:aura/features/profile/domain/usecases/update_profile_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit({
    required this.getProfileUseCase,
    required this.updateProfileUseCase,
    required this.signOutUseCase,
  }) : super(const ProfileInitialState());

  final GetProfileUseCase getProfileUseCase;
  final UpdateProfileUseCase updateProfileUseCase;
  final SignOutUseCase signOutUseCase;

  Future<void> fetchProfile() async {
    emit(const ProfileLoadingState());

    final result = await getProfileUseCase();

    result.fold(
      (failure) => emit(ProfileErrorState(message: failure.errMessage)),
      (profile) => emit(ProfileSuccessState(profile: profile)),
    );
  }

  Future<void> updateProfile({
    required String name,
    required String phone,
  }) async {
    final result = await updateProfileUseCase(name: name, phone: phone);

    result.fold(
      (failure) => null,
      (isUpdated) {
        if (state is ProfileSuccessState) {
          fetchProfile();
        }
      },
    );
  }

  Future<void> signOut() async {
    final result = await signOutUseCase();

    result.fold(
      (failure) => null,
      (isSignedOut) {
        emit(const ProfileInitialState());
      },
    );
  }
}
