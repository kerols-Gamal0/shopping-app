import 'package:dio/dio.dart';

abstract final class HandleDioExceptionsService {
  static Never handle(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        throw 'Connection timeout';

      case DioExceptionType.sendTimeout:
        throw 'Send timeout';

      case DioExceptionType.receiveTimeout:
        throw 'Receive timeout';

      case DioExceptionType.badCertificate:
        throw 'Bad SSL certificate';

      case DioExceptionType.cancel:
        throw 'Request cancelled';

      case DioExceptionType.connectionError:
        throw 'No internet connection';

      case DioExceptionType.unknown:
        throw e.message ?? 'Unknown error';

      case DioExceptionType.transformTimeout:
        throw 'Request processing timed out';
        
      case DioExceptionType.badResponse:
        throw _handleStatusCode(e.response);
    }
  }

  static String _handleStatusCode(Response? response) {
    switch (response?.statusCode) {
      case 400:
        return 'Bad request';

      case 401:
        return 'Unauthorized';

      case 403:
        return 'Forbidden';

      case 404:
        return 'Resource not found';

      case 409:
        return 'Conflict';

      case 422:
        return 'Validation failed';

      case 500:
        return 'Internal server error';

      case 502:
        return 'Bad gateway';

      case 503:
        return 'Service unavailable';

      case 504:
        return 'Gateway timeout';

      default:
        return response?.statusMessage ?? 'Something went wrong';
    }
  }
}
