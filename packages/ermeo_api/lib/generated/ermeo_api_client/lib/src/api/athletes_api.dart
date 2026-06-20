// coverage:ignore-file
import 'package:dio/dio.dart';

import '../models/session.dart';

class AthletesApi {
  AthletesApi(this._dio);

  final Dio _dio;

  Future<Response<SessionListResponse>> listAthleteSessions(
    String athleteId,
  ) async {
    final response = await _dio.get<Map<String, dynamic>>(
      '/athletes/$athleteId/sessions',
    );
    return Response(
      data: SessionListResponse.fromJson(response.data!),
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
