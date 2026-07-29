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
    final statusCode = response?.statusCode;
    final data = response?.data;
    final message = _extractMessage(data);

    switch (statusCode) {
      case 400:
        return message ?? 'Bad request';

      case 401:
        return message ?? 'Unauthorized';

      case 403:
        return message ?? 'Forbidden';

      case 404:
        return message ?? 'Resource not found';

      case 409:
        return message ?? 'Conflict';

      case 422:
        return message ?? 'Validation failed';

      case 500:
        return message ?? 'Internal server error';

      case 502:
        return message ?? 'Bad gateway';

      case 503:
        return message ?? 'Service unavailable';

      case 504:
        return message ?? 'Gateway timeout';

      default:
        return message ?? response?.statusMessage ?? 'Something went wrong';
    }
  }

  static String? _extractMessage(dynamic data) {
    if (data is Map<String, dynamic>) {
      return data['message']?.toString() ?? data['error']?.toString();
    }
    if (data is Map) {
      return data['message']?.toString() ?? data['error']?.toString();
    }
    return null;
  }
}
