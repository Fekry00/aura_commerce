import 'package:aura/core/errors/exceptions.dart';
import 'package:aura/core/errors/failure.dart';
import 'package:aura/core/network/connection/network_info.dart';
import 'package:aura/features/auth/data/datasources/auth_local_data_source.dart';
import 'package:aura/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:aura/features/auth/domain/entities/auth_entity.dart';
import 'package:aura/features/auth/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';

class AuthRepositoryImpl implements AuthRepository {
  const AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  final AuthRemoteDataSource remoteDataSource;
  final AuthLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  @override
  Future<Either<Failure, AuthEntity>> signIn({
    required String email,
    required String password,
    bool rememberDevice = true,
  }) async {
    if (!await networkInfo.isConnected) {
      return const Left(
        NetworkFailure(
          errMessage:
              'No internet connection. Please check your network and try again.',
        ),
      );
    }
    try {
      final remoteAuth = await remoteDataSource.signIn(
        email: email,
        password: password,
      );
      if (rememberDevice) {
        await localDataSource.cacheAuth(remoteAuth);
      }
      return Right(remoteAuth);
    } on ServerException catch (e) {
      return Left(ServerFailure(errMessage: e.errorModel.errorMessage));
    } catch (e) {
      return Left(ServerFailure(errMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, AuthEntity>> signUp({
    required String name,
    required String email,
    required String phone,
    required String password,
  }) async {
    try {
      final remoteAuth = await remoteDataSource.signUp(
        name: name,
        email: email,
        phone: phone,
        password: password,
      );
      // Do not auto-cache on sign up so user authenticates explicitly from SignInView
      return Right(remoteAuth);
    } on ServerException catch (e) {
      return Left(ServerFailure(errMessage: e.errorModel.errorMessage));
    } catch (e) {
      return Left(ServerFailure(errMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> forgotPassword({required String email}) async {
    try {
      final isSent = await remoteDataSource.forgotPassword(email: email);
      return Right(isSent);
    } on ServerException catch (e) {
      return Left(ServerFailure(errMessage: e.errorModel.errorMessage));
    } catch (e) {
      return Left(ServerFailure(errMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> resendOtp({required String email}) async {
    try {
      final isSent = await remoteDataSource.resendOtp(email: email);
      return Right(isSent);
    } on ServerException catch (e) {
      return Left(ServerFailure(errMessage: e.errorModel.errorMessage));
    } catch (e) {
      return Left(ServerFailure(errMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> verifyResetOtp({
    required String otp,
    String? email,
  }) async {
    try {
      final isValid = await remoteDataSource.verifyResetOtp(
        otp: otp,
        email: email,
      );
      return Right(isValid);
    } on ServerException catch (e) {
      return Left(ServerFailure(errMessage: e.errorModel.errorMessage));
    } catch (e) {
      return Left(ServerFailure(errMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> resetPassword({
    required String otp,
    required String newPassword,
    String? email,
  }) async {
    try {
      final isSuccess = await remoteDataSource.resetPassword(
        otp: otp,
        newPassword: newPassword,
        email: email,
      );
      return Right(isSuccess);
    } on ServerException catch (e) {
      return Left(ServerFailure(errMessage: e.errorModel.errorMessage));
    } catch (e) {
      return Left(ServerFailure(errMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, AuthEntity?>> getSavedAuthSession() async {
    try {
      final savedAuth = await localDataSource.getLastAuth();
      return Right(savedAuth);
    } catch (e) {
      return Left(CacheFailure(errMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> signOut() async {
    return logout();
  }

  @override
  Future<Either<Failure, AuthEntity>> refreshToken() async {
    try {
      final remoteAuth = await remoteDataSource.refreshToken();
      await localDataSource.cacheAuth(remoteAuth);
      return Right(remoteAuth);
    } on ServerException catch (e) {
      return Left(ServerFailure(errMessage: e.errorModel.errorMessage));
    } catch (e) {
      return Left(ServerFailure(errMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> logout() async {
    try {
      try {
        await remoteDataSource.logout();
      } catch (_) {
        // Even if remote logout fails or user is offline, proceed to clear local data
      }
      await localDataSource.clearAuth();
      return const Right(true);
    } catch (e) {
      await localDataSource.clearAuth();
      return Left(CacheFailure(errMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> changePassword({
    required String currentPassword,
    required String newPassword,
    required String newPasswordConfirmation,
  }) async {
    try {
      final isChanged = await remoteDataSource.changePassword(
        currentPassword: currentPassword,
        newPassword: newPassword,
        newPasswordConfirmation: newPasswordConfirmation,
      );
      return Right(isChanged);
    } on ServerException catch (e) {
      return Left(ServerFailure(errMessage: e.errorModel.errorMessage));
    } catch (e) {
      return Left(ServerFailure(errMessage: e.toString()));
    }
  }
}
