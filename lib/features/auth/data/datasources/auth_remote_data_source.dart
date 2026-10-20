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

  Future<bool> verifyResetPassword({
    required String otp,
    required String newPassword,
  });

  Future<bool> sendResetOtp({
    required String email,
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
  Future<bool> verifyResetPassword({
    required String otp,
    required String newPassword,
  }) async {
    final response = await apiConsumer.post(
      EndPoint.resetPassword,
      data: {
        'otp': otp,
        'new_password': newPassword,
      },
    );
    return response['success'] ?? true;
  }

  @override
  Future<bool> sendResetOtp({required String email}) async {
    final response = await apiConsumer.post(
      EndPoint.sendOtp,
      data: {'email': email},
    );
    return response['success'] ?? true;
  }
}
