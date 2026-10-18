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
    if (await networkInfo.isConnected) {
      try {
        final remoteAuth = await remoteDataSource.signIn(
          email: email,
          password: password,
        );
        if (rememberDevice) {
          await localDataSource.cacheAuth(remoteAuth);
        }
        return Right(remoteAuth);
      } catch (e) {
        try {
          final localAuth = await localDataSource.getLastAuth();
          if (localAuth != null) {
            return Right(localAuth);
          }
          return Left(ServerFailure(errMessage: e.toString()));
        } catch (_) {
          return Left(ServerFailure(errMessage: e.toString()));
        }
      }
    } else {
      try {
        final localAuth = await localDataSource.getLastAuth();
        if (localAuth != null) {
          return Right(localAuth);
        }
        return const Left(
          CacheFailure(errMessage: 'No internet connection and no cached session.'),
        );
      } catch (e) {
        return Left(
          CacheFailure(errMessage: 'No internet connection: ${e.toString()}'),
        );
      }
    }
  }

  @override
  Future<Either<Failure, AuthEntity>> signUp({
    required String name,
    required String email,
    required String phone,
    required String password,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteAuth = await remoteDataSource.signUp(
          name: name,
          email: email,
          phone: phone,
          password: password,
        );
        await localDataSource.cacheAuth(remoteAuth);
        return Right(remoteAuth);
      } catch (e) {
        try {
          final localAuth = await localDataSource.getLastAuth();
          if (localAuth != null) {
            return Right(localAuth);
          }
          return Left(ServerFailure(errMessage: e.toString()));
        } catch (_) {
          return Left(ServerFailure(errMessage: e.toString()));
        }
      }
    } else {
      try {
        final localAuth = await localDataSource.getLastAuth();
        if (localAuth != null) {
          return Right(localAuth);
        }
        return const Left(
          CacheFailure(errMessage: 'No internet connection and no cached session.'),
        );
      } catch (e) {
        return Left(
          CacheFailure(errMessage: 'No internet connection: ${e.toString()}'),
        );
      }
    }
  }

  @override
  Future<Either<Failure, bool>> verifyResetPassword({
    required String otp,
    required String newPassword,
  }) async {
    try {
      if (await networkInfo.isConnected) {
        final isSuccess = await remoteDataSource.verifyResetPassword(
          otp: otp,
          newPassword: newPassword,
        );
        return Right(isSuccess);
      }
      return const Right(true);
    } catch (e) {
      return Left(ServerFailure(errMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> sendResetOtp({required String email}) async {
    try {
      if (await networkInfo.isConnected) {
        final isSent = await remoteDataSource.sendResetOtp(email: email);
        return Right(isSent);
      }
      return const Right(true);
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
    try {
      await localDataSource.clearAuth();
      return const Right(true);
    } catch (e) {
      return Left(CacheFailure(errMessage: e.toString()));
    }
  }
}
