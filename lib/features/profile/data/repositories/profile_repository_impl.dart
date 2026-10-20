import 'package:aura/core/errors/exceptions.dart';
import 'package:aura/core/errors/failure.dart';
import 'package:aura/core/network/connection/network_info.dart';
import 'package:aura/features/profile/data/datasources/profile_local_data_source.dart';
import 'package:aura/features/profile/data/datasources/profile_remote_data_source.dart';
import 'package:aura/features/profile/domain/entities/profile_entity.dart';
import 'package:aura/features/profile/domain/repositories/profile_repository.dart';
import 'package:dartz/dartz.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  const ProfileRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  final ProfileRemoteDataSource remoteDataSource;
  final ProfileLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  @override
  Future<Either<Failure, ProfileEntity>> getProfile() async {
    try {
      final remoteProfile = await remoteDataSource.getProfile();
      await localDataSource.cacheProfile(remoteProfile);
      return Right(remoteProfile);
    } on ServerException catch (e) {
      try {
        final localProfile = await localDataSource.getLastProfile();
        return Right(localProfile);
      } catch (_) {
        return Left(ServerFailure(errMessage: e.errorModel.errorMessage));
      }
    } catch (e) {
      try {
        final localProfile = await localDataSource.getLastProfile();
        return Right(localProfile);
      } catch (_) {
        return Left(ServerFailure(errMessage: e.toString()));
      }
    }
  }

  @override
  Future<Either<Failure, ProfileEntity>> updateProfile({
    required String name,
    required String email,
  }) async {
    try {
      final updatedProfile = await remoteDataSource.updateProfile(
        name: name,
        email: email,
      );
      await localDataSource.cacheProfile(updatedProfile);
      return Right(updatedProfile);
    } on ServerException catch (e) {
      return Left(ServerFailure(errMessage: e.errorModel.errorMessage));
    } catch (e) {
      return Left(ServerFailure(errMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, ProfileEntity>> updateAvatar({
    required String imagePath,
  }) async {
    try {
      final updatedProfile = await remoteDataSource.updateAvatar(
        imagePath: imagePath,
      );
      await localDataSource.cacheProfile(updatedProfile);
      return Right(updatedProfile);
    } on ServerException catch (e) {
      return Left(ServerFailure(errMessage: e.errorModel.errorMessage));
    } catch (e) {
      return Left(ServerFailure(errMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, ProfileEntity>> deleteAvatar() async {
    try {
      final updatedProfile = await remoteDataSource.deleteAvatar();
      await localDataSource.cacheProfile(updatedProfile);
      return Right(updatedProfile);
    } on ServerException catch (e) {
      return Left(ServerFailure(errMessage: e.errorModel.errorMessage));
    } catch (e) {
      return Left(ServerFailure(errMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> sendPhoneOtp({
    required String phone,
  }) async {
    try {
      final message = await remoteDataSource.sendPhoneOtp(phone: phone);
      return Right(message);
    } on ServerException catch (e) {
      return Left(ServerFailure(errMessage: e.errorModel.errorMessage));
    } catch (e) {
      return Left(ServerFailure(errMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, ProfileEntity>> verifyPhoneOtp({
    required String phone,
    required String otp,
  }) async {
    try {
      final updatedProfile = await remoteDataSource.verifyPhoneOtp(
        phone: phone,
        otp: otp,
      );
      await localDataSource.cacheProfile(updatedProfile);
      return Right(updatedProfile);
    } on ServerException catch (e) {
      return Left(ServerFailure(errMessage: e.errorModel.errorMessage));
    } catch (e) {
      return Left(ServerFailure(errMessage: e.toString()));
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

  @override
  Future<Either<Failure, bool>> deleteAccount({
    required String password,
  }) async {
    try {
      final isDeleted = await remoteDataSource.deleteAccount(
        password: password,
      );
      if (isDeleted) {
        await localDataSource.signOutLocal();
      }
      return Right(isDeleted);
    } on ServerException catch (e) {
      return Left(ServerFailure(errMessage: e.errorModel.errorMessage));
    } catch (e) {
      return Left(ServerFailure(errMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> signOut() async {
    try {
      if (await networkInfo.isConnected) {
        await remoteDataSource.signOut();
      }
      final isSignedOut = await localDataSource.signOutLocal();
      return Right(isSignedOut);
    } on ServerException catch (e) {
      await localDataSource.signOutLocal();
      return Left(ServerFailure(errMessage: e.errorModel.errorMessage));
    } catch (e) {
      await localDataSource.signOutLocal();
      return Left(ServerFailure(errMessage: e.toString()));
    }
  }
}
