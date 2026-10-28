import 'package:aura/core/errors/error_model.dart';
import 'package:dio/dio.dart';

class ServerException implements Exception {
  final ErrorModel errorModel;
  ServerException(this.errorModel);
}

class CacheException implements Exception {
  final String errorMessage;
  CacheException({required this.errorMessage});
}

class BadCertificateException extends ServerException {
  BadCertificateException(super.errorModel);
}

class ConnectionTimeoutException extends ServerException {
  ConnectionTimeoutException(super.errorModel);
}

class BadResponseException extends ServerException {
  BadResponseException(super.errorModel);
}

class ReceiveTimeoutException extends ServerException {
  ReceiveTimeoutException(super.errorModel);
}

class ConnectionErrorException extends ServerException {
  ConnectionErrorException(super.errorModel);
}

class SendTimeoutException extends ServerException {
  SendTimeoutException(super.errorModel);
}

class UnauthorizedException extends ServerException {
  UnauthorizedException(super.errorModel);
}

class ForbiddenException extends ServerException {
  ForbiddenException(super.errorModel);
}

class NotFoundException extends ServerException {
  NotFoundException(super.errorModel);
}

class ConflictException extends ServerException {
  ConflictException(super.errorModel);
}

class CancelException extends ServerException {
  CancelException(super.errorModel);
}

class UnknownException extends ServerException {
  UnknownException(super.errorModel);
}

Never handleDioException(DioException e) {
  // Helper to safely extract ErrorModel without Null Exceptions
  ErrorModel extractErrorModel(
    DioException error, [
    String defaultMsg = 'Connection error occurred',
  ]) {
    final data = error.response?.data;
    final statusCode = error.response?.statusCode ?? 500;

    if (data is Map<String, dynamic>) {
      return ErrorModel.fromJson(data);
    } else if (data is String && data.isNotEmpty) {
      return ErrorModel(status: statusCode, errorMessage: data);
    }
    return ErrorModel(
      status: statusCode,
      errorMessage: error.message ?? defaultMsg,
    );
  }

  switch (e.type) {
    case DioExceptionType.connectionTimeout:
      throw ConnectionTimeoutException(
        extractErrorModel(e, 'Connection timeout with the server'),
      );

    case DioExceptionType.sendTimeout:
      throw SendTimeoutException(
        extractErrorModel(e, 'Send timeout with the server'),
      );

    case DioExceptionType.receiveTimeout:
      throw ReceiveTimeoutException(
        extractErrorModel(e, 'Receive timeout with the server'),
      );

    case DioExceptionType.badCertificate:
      throw BadCertificateException(
        extractErrorModel(e, 'Bad SSL security certificate'),
      );

    case DioExceptionType.connectionError:
      throw ConnectionErrorException(
        extractErrorModel(e, 'No internet connection or server unavailable'),
      );

    case DioExceptionType.cancel:
      throw CancelException(extractErrorModel(e, 'Request was cancelled'));

    case DioExceptionType.badResponse:
      final model = extractErrorModel(e);
      switch (e.response?.statusCode) {
        case 400:
          throw BadResponseException(model);
        case 401:
          throw UnauthorizedException(model);
        case 403:
          throw ForbiddenException(model);
        case 404:
          throw NotFoundException(model);
        case 409:
          throw ConflictException(model);
        default:
          throw BadResponseException(model);
      }

    default:
      throw UnknownException(extractErrorModel(e, 'An unexpected error occurred'));
  }
}
