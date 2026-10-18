import 'package:aura/core/databases/cache/cache_helper.dart';
import 'package:aura/core/network/api/api_consumer.dart';
import 'package:aura/core/network/api/dio_consumer.dart';
import 'package:aura/core/network/connection/network_info.dart';
import 'package:aura/features/cart/data/datasources/cart_local_data_source.dart';
import 'package:aura/features/cart/data/datasources/cart_remote_data_source.dart';
import 'package:aura/features/cart/data/repositories/cart_repository_impl.dart';
import 'package:aura/features/cart/domain/repositories/cart_repository.dart';
import 'package:aura/features/cart/domain/usecases/apply_voucher_usecase.dart';
import 'package:aura/features/cart/domain/usecases/get_cart_usecase.dart';
import 'package:aura/features/cart/domain/usecases/remove_cart_item_usecase.dart';
import 'package:aura/features/cart/domain/usecases/remove_voucher_usecase.dart';
import 'package:aura/features/cart/domain/usecases/update_cart_quantity_usecase.dart';
import 'package:aura/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:aura/features/home/data/datasources/home_local_data_source.dart';
import 'package:aura/features/home/data/datasources/home_remote_data_source.dart';
import 'package:aura/features/home/data/repositories/home_repository_impl.dart';
import 'package:aura/features/home/domain/repositories/home_repository.dart';
import 'package:aura/features/home/domain/usecases/get_home_feed_usecase.dart';
import 'package:aura/features/home/domain/usecases/toggle_favorite_usecase.dart';
import 'package:aura/features/home/presentation/cubit/home_cubit.dart';
import 'package:aura/features/profile/data/datasources/profile_local_data_source.dart';
import 'package:aura/features/profile/data/datasources/profile_remote_data_source.dart';
import 'package:aura/features/profile/data/repositories/profile_repository_impl.dart';
import 'package:aura/features/profile/domain/repositories/profile_repository.dart';
import 'package:aura/features/profile/domain/usecases/get_profile_usecase.dart';
import 'package:aura/features/profile/domain/usecases/sign_out_usecase.dart';
import 'package:aura/features/profile/domain/usecases/update_profile_usecase.dart';
import 'package:aura/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:aura/features/wishlist/data/datasources/wishlist_local_data_source.dart';
import 'package:aura/features/wishlist/data/datasources/wishlist_remote_data_source.dart';
import 'package:aura/features/wishlist/data/repositories/wishlist_repository_impl.dart';
import 'package:aura/features/wishlist/domain/repositories/wishlist_repository.dart';
import 'package:aura/features/wishlist/domain/usecases/get_wishlist_usecase.dart';
import 'package:aura/features/wishlist/domain/usecases/move_all_to_bag_usecase.dart';
import 'package:aura/features/wishlist/domain/usecases/remove_from_wishlist_usecase.dart';
import 'package:aura/features/wishlist/presentation/cubit/wishlist_cubit.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async {
  // Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
  sl.registerLazySingleton<ApiConsumer>(() => DioConsumer(dio: sl()));
  sl.registerLazySingleton(() => Dio());
  sl.registerLazySingleton(() => InternetConnectionChecker.createInstance());
  sl.registerLazySingleton(() => CacheHelper());

  // Home
  sl.registerFactory(
    () => HomeCubit(
      getHomeFeedUseCase: sl(),
      toggleFavoriteUseCase: sl(),
    ),
  );
  sl.registerLazySingleton(() => GetHomeFeedUseCase(sl()));
  sl.registerLazySingleton(() => ToggleFavoriteUseCase(sl()));
  sl.registerLazySingleton<HomeRepository>(
    () => HomeRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
    ),
  );
  sl.registerLazySingleton<HomeRemoteDataSource>(
    () => HomeRemoteDataSourceImpl(apiConsumer: sl()),
  );
  sl.registerLazySingleton<HomeLocalDataSource>(
    () => HomeLocalDataSourceImpl(cacheHelper: sl()),
  );

  // Cart
  sl.registerFactory(
    () => CartCubit(
      getCartUseCase: sl(),
      updateCartQuantityUseCase: sl(),
      removeCartItemUseCase: sl(),
      applyVoucherUseCase: sl(),
      removeVoucherUseCase: sl(),
    ),
  );
  sl.registerLazySingleton(() => GetCartUseCase(sl()));
  sl.registerLazySingleton(() => UpdateCartQuantityUseCase(sl()));
  sl.registerLazySingleton(() => RemoveCartItemUseCase(sl()));
  sl.registerLazySingleton(() => ApplyVoucherUseCase(sl()));
  sl.registerLazySingleton(() => RemoveVoucherUseCase(sl()));
  sl.registerLazySingleton<CartRepository>(
    () => CartRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
    ),
  );
  sl.registerLazySingleton<CartRemoteDataSource>(
    () => CartRemoteDataSourceImpl(apiConsumer: sl()),
  );
  sl.registerLazySingleton<CartLocalDataSource>(
    () => CartLocalDataSourceImpl(cacheHelper: sl()),
  );

  // Wishlist
  sl.registerFactory(
    () => WishlistCubit(
      getWishlistUseCase: sl(),
      removeFromWishlistUseCase: sl(),
      moveAllToBagUseCase: sl(),
    ),
  );
  sl.registerLazySingleton(() => GetWishlistUseCase(sl()));
  sl.registerLazySingleton(() => RemoveFromWishlistUseCase(sl()));
  sl.registerLazySingleton(() => MoveAllToBagUseCase(sl()));
  sl.registerLazySingleton<WishlistRepository>(
    () => WishlistRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
    ),
  );
  sl.registerLazySingleton<WishlistRemoteDataSource>(
    () => WishlistRemoteDataSourceImpl(apiConsumer: sl()),
  );
  sl.registerLazySingleton<WishlistLocalDataSource>(
    () => WishlistLocalDataSourceImpl(cacheHelper: sl()),
  );

  // Profile
  sl.registerFactory(
    () => ProfileCubit(
      getProfileUseCase: sl(),
      updateProfileUseCase: sl(),
      signOutUseCase: sl(),
    ),
  );
  sl.registerLazySingleton(() => GetProfileUseCase(sl()));
  sl.registerLazySingleton(() => UpdateProfileUseCase(sl()));
  sl.registerLazySingleton(() => SignOutUseCase(sl()));
  sl.registerLazySingleton<ProfileRepository>(
    () => ProfileRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
    ),
  );
  sl.registerLazySingleton<ProfileRemoteDataSource>(
    () => ProfileRemoteDataSourceImpl(apiConsumer: sl()),
  );
  sl.registerLazySingleton<ProfileLocalDataSource>(
    () => ProfileLocalDataSourceImpl(cacheHelper: sl()),
  );
}
