import 'package:aura/core/network/api/api_consumer.dart';
import 'package:aura/core/network/api/end_points.dart';
import 'package:aura/features/auth/data/models/auth_model.dart';

abstract class AuthRemoteDataSource {
  Future<AuthModel> signIn({
    required String email,
    required String password,
  });

  Future<AuthModel> signUp({
    required String name,
    required String email,
    required String phone,
    required String password,
  });

  /// Step 1: Send OTP to email for password reset.
  Future<bool> forgotPassword({required String email});

  /// Step 2 (optional): Resend OTP to email.
  Future<bool> resendOtp({required String email});

  /// Step 3: Verify OTP only — returns true if valid.
  Future<bool> verifyResetOtp({required String otp});

  /// Step 4: Set new password after OTP is verified.
  Future<bool> resetPassword({
    required String otp,
    required String newPassword,
  });

  /// Refresh Sanctum Bearer Token
  Future<AuthModel> refreshToken();

  /// Logout current authenticated session
  Future<bool> logout();

  /// Change Password for authenticated user
  Future<bool> changePassword({
    required String currentPassword,
    required String newPassword,
    required String newPasswordConfirmation,
  });
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  const AuthRemoteDataSourceImpl({required this.apiConsumer});

  final ApiConsumer apiConsumer;

  @override
  Future<AuthModel> signIn({
    required String email,
    required String password,
  }) async {
    final response = await apiConsumer.post(
      EndPoint.login,
      data: {
        'email': email,
        'password': password,
      },
    );
    return AuthModel.fromJson(response);
  }

  @override
  Future<AuthModel> signUp({
    required String name,
    required String email,
    required String phone,
    required String password,
  }) async {
    final response = await apiConsumer.post(
      EndPoint.register,
      data: {
        'name': name,
        'email': email,
        'phone': phone,
        'password': password,
        'password_confirmation': password,
      },
    );
    return AuthModel.fromJson(response);
  }

  @override
  Future<bool> forgotPassword({required String email}) async {
    final response = await apiConsumer.post(
      EndPoint.forgotPassword,
      data: {'email': email},
    );
    return response['success'] ?? true;
  }

  @override
  Future<bool> resendOtp({required String email}) async {
    final response = await apiConsumer.post(
      EndPoint.resendOtp,
      data: {'email': email},
    );
    return response['success'] ?? true;
  }

  @override
  Future<bool> verifyResetOtp({required String otp}) async {
    final response = await apiConsumer.post(
      EndPoint.verifyResetOtp,
      data: {'otp': otp},
    );
    return response['success'] ?? true;
  }

  @override
  Future<bool> resetPassword({
    required String otp,
    required String newPassword,
  }) async {
    final response = await apiConsumer.post(
      EndPoint.resetPassword,
      data: {
        'otp': otp,
        'new_password': newPassword,
        'new_password_confirmation': newPassword,
      },
    );
    return response['success'] ?? true;
  }

  @override
  Future<AuthModel> refreshToken() async {
    final response = await apiConsumer.post(EndPoint.refreshToken);
    return AuthModel.fromJson(response);
  }

  @override
  Future<bool> logout() async {
    final response = await apiConsumer.post(EndPoint.logout);
    return response['success'] ?? true;
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
    return response['success'] ?? true;
  }
}
