// coverage:ignore-file
import 'package:dio/dio.dart';

import '../models/health.dart';

class HealthApi {
  HealthApi(this._dio);

  final Dio _dio;

  Future<Response<HealthResponse>> getHealth() async {
    final response = await _dio.get<Map<String, dynamic>>('/health');
    return Response(
      data: HealthResponse.fromJson(response.data!),
      headers: response.headers,
      requestOptions: response.requestOptions,
      statusCode: response.statusCode,
      statusMessage: response.statusMessage,
      isRedirect: response.isRedirect,
      redirects: response.redirects,
      extra: response.extra,
    );
  }
}
