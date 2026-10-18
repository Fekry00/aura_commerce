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
    if (await networkInfo.isConnected) {
      try {
        final remoteProfile = await remoteDataSource.getProfile();
        await localDataSource.cacheProfile(remoteProfile);
        return Right(remoteProfile);
      } catch (e) {
        try {
          final localProfile = await localDataSource.getLastProfile();
          return Right(localProfile);
        } catch (_) {
          return Left(ServerFailure(errMessage: e.toString()));
        }
      }
    } else {
      try {
        final localProfile = await localDataSource.getLastProfile();
        return Right(localProfile);
      } catch (e) {
        return Left(
          CacheFailure(errMessage: 'No internet connection: ${e.toString()}'),
        );
      }
    }
  }

  @override
  Future<Either<Failure, bool>> updateProfile({
    required String name,
    required String phone,
  }) async {
    try {
      final isUpdated = await localDataSource.updateProfileLocal(
        name: name,
        phone: phone,
      );
      if (await networkInfo.isConnected) {
        await remoteDataSource.updateProfile(name: name, phone: phone);
      }
      return Right(isUpdated);
    } catch (e) {
      return Left(CacheFailure(errMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> signOut() async {
    try {
      final isSignedOut = await localDataSource.signOutLocal();
      if (await networkInfo.isConnected) {
        await remoteDataSource.signOut();
      }
      return Right(isSignedOut);
    } catch (e) {
      return Left(CacheFailure(errMessage: e.toString()));
    }
  }
}
