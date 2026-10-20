import 'package:aura/core/network/api/api_consumer.dart';
import 'package:aura/core/network/api/end_points.dart';
import 'package:aura/features/profile/data/models/profile_model.dart';
import 'package:dio/dio.dart';

abstract class ProfileRemoteDataSource {
  Future<ProfileModel> getProfile();

  Future<ProfileModel> updateProfile({
    required String name,
    required String email,
  });

  Future<ProfileModel> updateAvatar({
    required String imagePath,
  });

  Future<ProfileModel> deleteAvatar();

  Future<String> sendPhoneOtp({
    required String phone,
  });

  Future<ProfileModel> verifyPhoneOtp({
    required String phone,
    required String otp,
  });

  Future<bool> changePassword({
    required String currentPassword,
    required String newPassword,
    required String newPasswordConfirmation,
  });

  Future<bool> deleteAccount({
    required String password,
  });

  Future<bool> signOut();
}

class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  const ProfileRemoteDataSourceImpl({required this.apiConsumer});

  final ApiConsumer apiConsumer;

  @override
  Future<ProfileModel> getProfile() async {
    final response = await apiConsumer.get(EndPoint.profile);
    return ProfileModel.fromJson(response);
  }

  @override
  Future<ProfileModel> updateProfile({
    required String name,
    required String email,
  }) async {
    final response = await apiConsumer.put(
      EndPoint.updateProfile,
      data: {
        ApiKey.name: name,
        ApiKey.email: email,
      },
    );
    return ProfileModel.fromJson(response);
  }

  @override
  Future<ProfileModel> updateAvatar({
    required String imagePath,
  }) async {
    final response = await apiConsumer.post(
      EndPoint.updateAvatar,
      data: {
        ApiKey.profileImage: await MultipartFile.fromFile(imagePath),
      },
      isFormData: true,
    );
    return ProfileModel.fromJson(response);
  }

  @override
  Future<ProfileModel> deleteAvatar() async {
    final response = await apiConsumer.delete(EndPoint.deleteAvatar);
    return ProfileModel.fromJson(response);
  }

  @override
  Future<String> sendPhoneOtp({
    required String phone,
  }) async {
    final response = await apiConsumer.post(
      EndPoint.sendPhoneOtp,
      data: {
        ApiKey.phone: phone,
      },
    );
    return response[ApiKey.message] as String? ?? 'OTP sent successfully';
  }

  @override
  Future<ProfileModel> verifyPhoneOtp({
    required String phone,
    required String otp,
  }) async {
    final response = await apiConsumer.post(
      EndPoint.verifyPhoneOtp,
      data: {
        ApiKey.phone: phone,
        ApiKey.otp: otp,
      },
    );
    return ProfileModel.fromJson(response);
  }

  @override
  Future<bool> changePassword({
    required String currentPassword,
    required String newPassword,
    required String newPasswordConfirmation,
  }) async {
    final response = await apiConsumer.post(
      EndPoint.changePassword,
      data: {
        ApiKey.currentPassword: currentPassword,
        ApiKey.password: newPassword,
        ApiKey.passwordConfirmation: newPasswordConfirmation,
      },
    );
    return response[ApiKey.success] ?? true;
  }

  @override
  Future<bool> deleteAccount({
    required String password,
  }) async {
    final response = await apiConsumer.delete(
      EndPoint.deleteAccount,
      data: {
        ApiKey.password: password,
      },
    );
    return response[ApiKey.success] ?? true;
  }

  @override
  Future<bool> signOut() async {
    final response = await apiConsumer.post(EndPoint.logout);
    return response[ApiKey.success] ?? true;
  }
}
