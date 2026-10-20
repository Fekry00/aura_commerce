import 'package:aura/features/profile/domain/entities/profile_entity.dart';
import 'package:aura/features/profile/domain/usecases/change_password_usecase.dart';
import 'package:aura/features/profile/domain/usecases/delete_account_usecase.dart';
import 'package:aura/features/profile/domain/usecases/delete_avatar_usecase.dart';
import 'package:aura/features/profile/domain/usecases/get_profile_usecase.dart';
import 'package:aura/features/profile/domain/usecases/send_phone_otp_usecase.dart';
import 'package:aura/features/profile/domain/usecases/sign_out_usecase.dart';
import 'package:aura/features/profile/domain/usecases/update_avatar_usecase.dart';
import 'package:aura/features/profile/domain/usecases/update_profile_usecase.dart';
import 'package:aura/features/profile/domain/usecases/verify_phone_otp_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit({
    required this.getProfileUseCase,
    required this.updateProfileUseCase,
    required this.updateAvatarUseCase,
    required this.deleteAvatarUseCase,
    required this.sendPhoneOtpUseCase,
    required this.verifyPhoneOtpUseCase,
    required this.changePasswordUseCase,
    required this.deleteAccountUseCase,
    required this.signOutUseCase,
  }) : super(const ProfileInitialState());

  final GetProfileUseCase getProfileUseCase;
  final UpdateProfileUseCase updateProfileUseCase;
  final UpdateAvatarUseCase updateAvatarUseCase;
  final DeleteAvatarUseCase deleteAvatarUseCase;
  final SendPhoneOtpUseCase sendPhoneOtpUseCase;
  final VerifyPhoneOtpUseCase verifyPhoneOtpUseCase;
  final ChangePasswordUseCase changePasswordUseCase;
  final DeleteAccountUseCase deleteAccountUseCase;
  final SignOutUseCase signOutUseCase;

  ProfileEntity? get currentProfile => state.profile;

  Future<void> fetchProfile() async {
    emit(ProfileLoadingState(profile: currentProfile));

    final result = await getProfileUseCase();

    result.fold(
      (failure) => emit(ProfileErrorState(
        message: failure.errMessage,
        profile: currentProfile,
      )),
      (profile) => emit(ProfileSuccessState(profile: profile)),
    );
  }

  Future<void> updateProfile({
    required String name,
    required String email,
  }) async {
    emit(ProfileUpdatingState(profile: currentProfile));

    final result = await updateProfileUseCase(name: name, email: email);

    result.fold(
      (failure) => emit(ProfileUpdateErrorState(
        message: failure.errMessage,
        profile: currentProfile,
      )),
      (profile) => emit(ProfileUpdateSuccessState(
        profile: profile,
        message: 'تم تحديث البيانات بنجاح',
      )),
    );
  }

  Future<void> updateAvatar({required String imagePath}) async {
    emit(ProfileAvatarLoadingState(profile: currentProfile));

    final result = await updateAvatarUseCase(imagePath: imagePath);

    result.fold(
      (failure) => emit(ProfileAvatarErrorState(
        message: failure.errMessage,
        profile: currentProfile,
      )),
      (profile) => emit(ProfileAvatarSuccessState(
        profile: profile,
        message: 'تم تحديث الصورة الشخصية بنجاح',
      )),
    );
  }

  Future<void> deleteAvatar() async {
    emit(ProfileAvatarLoadingState(profile: currentProfile));

    final result = await deleteAvatarUseCase();

    result.fold(
      (failure) => emit(ProfileAvatarErrorState(
        message: failure.errMessage,
        profile: currentProfile,
      )),
      (profile) => emit(ProfileAvatarSuccessState(
        profile: profile,
        message: 'تم حذف الصورة الشخصية بنجاح',
      )),
    );
  }

  Future<void> sendPhoneOtp({required String phone}) async {
    emit(ProfilePhoneOtpSendingState(profile: currentProfile));

    final result = await sendPhoneOtpUseCase(phone: phone);

    result.fold(
      (failure) => emit(ProfilePhoneErrorState(
        message: failure.errMessage,
        profile: currentProfile,
      )),
      (message) => emit(ProfilePhoneOtpSentState(
        message: message,
        profile: currentProfile,
      )),
    );
  }

  Future<void> verifyPhoneOtp({
    required String phone,
    required String otp,
  }) async {
    emit(ProfilePhoneVerifyingState(profile: currentProfile));

    final result = await verifyPhoneOtpUseCase(phone: phone, otp: otp);

    result.fold(
      (failure) => emit(ProfilePhoneErrorState(
        message: failure.errMessage,
        profile: currentProfile,
      )),
      (profile) => emit(ProfilePhoneVerifiedState(
        profile: profile,
        message: 'تم تغيير رقم الهاتف بنجاح',
      )),
    );
  }

  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
    required String newPasswordConfirmation,
  }) async {
    emit(ProfilePasswordChangingState(profile: currentProfile));

    final result = await changePasswordUseCase(
      currentPassword: currentPassword,
      newPassword: newPassword,
      newPasswordConfirmation: newPasswordConfirmation,
    );

    result.fold(
      (failure) => emit(ProfilePasswordErrorState(
        message: failure.errMessage,
        profile: currentProfile,
      )),
      (success) => emit(ProfilePasswordChangedState(
        message: 'تم تغيير كلمة المرور بنجاح',
        profile: currentProfile,
      )),
    );
  }

  Future<void> deleteAccount({required String password}) async {
    emit(ProfileAccountDeletingState(profile: currentProfile));

    final result = await deleteAccountUseCase(password: password);

    result.fold(
      (failure) => emit(ProfileAccountDeleteErrorState(
        message: failure.errMessage,
        profile: currentProfile,
      )),
      (success) => emit(const ProfileAccountDeletedState()),
    );
  }

  Future<void> signOut() async {
    emit(ProfileLoadingState(profile: currentProfile));

    final result = await signOutUseCase();

    result.fold(
      (failure) => emit(const ProfileSignedOutState()),
      (isSignedOut) => emit(const ProfileSignedOutState()),
    );
  }
}
