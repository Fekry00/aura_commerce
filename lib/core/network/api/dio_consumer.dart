import 'package:aura/core/errors/exceptions.dart';
import 'package:aura/core/network/api/api_consumer.dart';
import 'package:aura/core/network/api/api_interceptors.dart';
import 'package:aura/core/network/api/end_points.dart';
import 'package:dio/dio.dart';

class DioConsumer extends ApiConsumer {
  final Dio dio;

  DioConsumer({required this.dio}) {
    dio.options.baseUrl = EndPoint.baseUrl;
    dio.options.connectTimeout = const Duration(seconds: 20);
    dio.options.receiveTimeout = const Duration(seconds: 20);
    dio.interceptors.add(ApiInterceptor());
    dio.interceptors.add(
      LogInterceptor(
        request: true,
        requestHeader: true,
        requestBody: true,
        responseHeader: false,
        responseBody: true,
        error: true,
      ),
    );
  }

  @override
  Future<dynamic> get(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await dio.get(
        path,
        data: data,
        queryParameters: queryParameters,
      );
      return response.data;
    } on DioException catch (e) {
      handleDioException(e);
    }
  }

  @override
  Future<dynamic> post(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    bool isFormData = false,
  }) async {
    try {
      final response = await dio.post(
        path,
        data: isFormData ? FormData.fromMap(data) : data,
        queryParameters: queryParameters,
      );
      return response.data;
    } on DioException catch (e) {
      handleDioException(e);
    }
  }

  @override
  Future<dynamic> patch(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    bool isFormData = false,
  }) async {
    try {
      final response = await dio.patch(
        path,
        data: isFormData ? FormData.fromMap(data) : data,
        queryParameters: queryParameters,
      );
      return response.data;
    } on DioException catch (e) {
      handleDioException(e);
    }
  }

  @override
  Future<dynamic> delete(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    bool isFormData = false,
  }) async {
    try {
      final response = await dio.delete(
        path,
        data: isFormData && data is Map<String, dynamic>
            ? FormData.fromMap(data)
            : data,
        queryParameters: queryParameters,
      );
      return response.data;
    } on DioException catch (e) {
      handleDioException(e);
    }
  }
}
