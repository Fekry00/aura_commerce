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
  // دالة مساعدة لاستخراج الموديل بأمان دون Null Exception
  ErrorModel extractErrorModel(
    DioException error, [
    String defaultMsg = 'حدث خطأ في الاتصال',
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
        extractErrorModel(e, 'انتهت مهلة الاتصال بالخادم'),
      );

    case DioExceptionType.sendTimeout:
      throw SendTimeoutException(
        extractErrorModel(e, 'انتهت مهلة إرسال البيانات'),
      );

    case DioExceptionType.receiveTimeout:
      throw ReceiveTimeoutException(
        extractErrorModel(e, 'انتهت مهلة استقبال البيانات من الخادم'),
      );

    case DioExceptionType.badCertificate:
      throw BadCertificateException(
        extractErrorModel(e, 'شهادة الأمان غير صالحة'),
      );

    case DioExceptionType.connectionError:
      throw ConnectionErrorException(
        extractErrorModel(e, 'لا يوجد اتصال بالإنترنت أو الخادم غير متاح'),
      );

    case DioExceptionType.cancel:
      throw CancelException(extractErrorModel(e, 'تم إلغاء الطلب'));

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
      throw UnknownException(extractErrorModel(e, 'حدث خطأ غير معروف'));
  }
}
