import 'package:dio/dio.dart';

import 'package:beneesse_api_client/beneesse_api_client.dart' as gen;

/// Application-level API failure mapped from HTTP/Dio errors.
class ApiException implements Exception {
  const ApiException({
    required this.statusCode,
    required this.code,
    required this.message,
    this.details,
  });

  final int? statusCode;
  final String code;
  final String message;
  final Map<String, dynamic>? details;

  @override
  String toString() => 'ApiException($statusCode, $code: $message)';
}

/// Maps [DioException] (and nested API error bodies) to [ApiException].
ApiException mapDioException(DioException error) {
  final statusCode = error.response?.statusCode;
  final data = error.response?.data;

  if (data is Map<String, dynamic>) {
    try {
      final apiError = gen.ApiError.fromJson(data);
      return ApiException(
        statusCode: statusCode,
        code: apiError.code,
        message: apiError.message,
        details: apiError.details,
      );
    } on Object {
      // Fall through to generic mapping.
    }
  }

  if (error.type == DioExceptionType.connectionTimeout ||
      error.type == DioExceptionType.receiveTimeout ||
      error.type == DioExceptionType.sendTimeout) {
    return ApiException(
      statusCode: statusCode,
      code: 'timeout',
      message: 'Request timed out',
    );
  }

  if (error.type == DioExceptionType.connectionError) {
    return ApiException(
      statusCode: statusCode,
      code: 'connection_error',
      message: 'Unable to reach the server',
    );
  }

  return ApiException(
    statusCode: statusCode,
    code: 'http_error',
    message: error.message ?? 'Unexpected network error',
  );
}
