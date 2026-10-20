import 'package:aura/features/profile/domain/entities/profile_entity.dart';

abstract class ProfileState {
  const ProfileState({this.profile});
  final ProfileEntity? profile;
}

class ProfileInitialState extends ProfileState {
  const ProfileInitialState() : super();
}

class ProfileLoadingState extends ProfileState {
  const ProfileLoadingState({super.profile});
}

class ProfileSuccessState extends ProfileState {
  const ProfileSuccessState({required ProfileEntity profile})
      : super(profile: profile);
}

class ProfileErrorState extends ProfileState {
  const ProfileErrorState({required this.message, super.profile});
  final String message;
}

// Update Credentials
class ProfileUpdatingState extends ProfileState {
  const ProfileUpdatingState({super.profile});
}

class ProfileUpdateSuccessState extends ProfileState {
  const ProfileUpdateSuccessState({
    required ProfileEntity profile,
    required this.message,
  }) : super(profile: profile);
  final String message;
}

class ProfileUpdateErrorState extends ProfileState {
  const ProfileUpdateErrorState({required this.message, super.profile});
  final String message;
}

// Avatar
class ProfileAvatarLoadingState extends ProfileState {
  const ProfileAvatarLoadingState({super.profile});
}

class ProfileAvatarSuccessState extends ProfileState {
  const ProfileAvatarSuccessState({
    required ProfileEntity profile,
    required this.message,
  }) : super(profile: profile);
  final String message;
}

class ProfileAvatarErrorState extends ProfileState {
  const ProfileAvatarErrorState({required this.message, super.profile});
  final String message;
}

// Phone OTP
class ProfilePhoneOtpSendingState extends ProfileState {
  const ProfilePhoneOtpSendingState({super.profile});
}

class ProfilePhoneOtpSentState extends ProfileState {
  const ProfilePhoneOtpSentState({
    required this.message,
    super.profile,
  });
  final String message;
}

class ProfilePhoneVerifyingState extends ProfileState {
  const ProfilePhoneVerifyingState({super.profile});
}

class ProfilePhoneVerifiedState extends ProfileState {
  const ProfilePhoneVerifiedState({
    required ProfileEntity profile,
    required this.message,
  }) : super(profile: profile);
  final String message;
}

class ProfilePhoneErrorState extends ProfileState {
  const ProfilePhoneErrorState({required this.message, super.profile});
  final String message;
}

// Password
class ProfilePasswordChangingState extends ProfileState {
  const ProfilePasswordChangingState({super.profile});
}

class ProfilePasswordChangedState extends ProfileState {
  const ProfilePasswordChangedState({
    required this.message,
    super.profile,
  });
  final String message;
}

class ProfilePasswordErrorState extends ProfileState {
  const ProfilePasswordErrorState({required this.message, super.profile});
  final String message;
}

// Delete Account
class ProfileAccountDeletingState extends ProfileState {
  const ProfileAccountDeletingState({super.profile});
}

class ProfileAccountDeletedState extends ProfileState {
  const ProfileAccountDeletedState();
}

class ProfileAccountDeleteErrorState extends ProfileState {
  const ProfileAccountDeleteErrorState({
    required this.message,
    super.profile,
  });
  final String message;
}

// Sign Out
class ProfileSignedOutState extends ProfileState {
  const ProfileSignedOutState();
}
