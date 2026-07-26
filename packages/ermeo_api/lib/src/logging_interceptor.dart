import 'dart:convert';

import 'package:dio/dio.dart';

import 'api_logger.dart';

/// Logs HTTP traffic via [ApiLogger], including request/response bodies.
///
/// Sensitive headers and body fields are redacted.
class LoggingInterceptor extends Interceptor {
  factory LoggingInterceptor({required ApiLogger logger}) {
    return LoggingInterceptor._(logger);
  }

  LoggingInterceptor._(this._logger);

  final ApiLogger _logger;

  static const _redactedHeaders = {
    'authorization',
    'cookie',
    'set-cookie',
    'x-api-key',
  };

  static const _redactedBodyKeys = {
    'password',
    'accesstoken',
    'refreshtoken',
    'token',
    'idtoken',
    'secret',
    'apikey',
    'authorization',
  };

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final path = _pathOf(options.uri);
    final headers = _sanitizeHeaders(options.headers);
    final body = _formatBody(options.data);
    _logger.d('→ ${options.method} $path headers=$headers body=$body');
    handler.next(options);
  }

  @override
  void onResponse(
    Response<dynamic> response,
    ResponseInterceptorHandler handler,
  ) {
    final options = response.requestOptions;
    final path = _pathOf(options.uri);
    final body = _formatBody(response.data);
    _logger.d(
      '← ${response.statusCode} ${options.method} $path body=$body',
    );
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final options = err.requestOptions;
    final path = _pathOf(options.uri);
    final status = err.response?.statusCode;
    final statusPart = status != null ? '$status ' : '';
    final body = _formatBody(err.response?.data);
    _logger.e(
      '✕ $statusPart${options.method} $path body=$body: ${err.message}',
      error: err,
      stackTrace: err.stackTrace,
    );
    handler.next(err);
  }

  String _pathOf(Uri uri) {
    return uri.hasQuery ? '${uri.path}?${uri.query}' : uri.path;
  }

  Map<String, Object?> _sanitizeHeaders(Map<String, dynamic> headers) {
    return {
      for (final entry in headers.entries)
        entry.key: _redactedHeaders.contains(entry.key.toLowerCase())
            ? '***'
            : entry.value,
    };
  }

  String _formatBody(Object? data) {
    if (data == null) {
      return 'null';
    }
    if (data is FormData) {
      return '<FormData fields=${data.fields.length} files=${data.files.length}>';
    }
    try {
      final sanitized = _sanitizeValue(data);
      return jsonEncode(sanitized);
    } on Object {
      return data.toString();
    }
  }

  Object? _sanitizeValue(Object? value) {
    if (value is Map) {
      return {
        for (final entry in value.entries)
          entry.key.toString(): _redactedBodyKeys.contains(
                entry.key.toString().toLowerCase().replaceAll('_', ''),
              )
              ? '***'
              : _sanitizeValue(entry.value),
      };
    }
    if (value is List) {
      return [for (final item in value) _sanitizeValue(item)];
    }
    return value;
  }
}
