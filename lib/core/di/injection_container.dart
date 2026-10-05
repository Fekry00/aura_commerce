import 'package:aura/core/network/api/api_consumer.dart';
import 'package:aura/core/network/api/dio_consumer.dart';
import 'package:aura/core/network/connection/network_info.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async {
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  sl.registerLazySingleton<ApiConsumer>(() => DioConsumer(dio: sl()));

  sl.registerLazySingleton(() => Dio());

  sl.registerLazySingleton(() => InternetConnectionChecker.createInstance());
}
