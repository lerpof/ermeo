// coverage:ignore-file
import 'package:dio/dio.dart';

import '../models/session.dart';

class SessionsApi {
  SessionsApi(this._dio);

  final Dio _dio;

  Future<Response<WorkoutSession>> createSession(
    SessionCreateRequest body,
  ) async {
    final response = await _dio.post<Map<String, dynamic>>(
      '/sessions',
      data: body.toJson(),
    );
    return _sessionResponse(response);
  }

  Future<Response<WorkoutSession>> patchSessionSets(
    String sessionId,
    SessionSetsPatchRequest body,
  ) async {
    final response = await _dio.patch<Map<String, dynamic>>(
      '/sessions/$sessionId/sets',
      data: body.toJson(),
    );
    return _sessionResponse(response);
  }

  Future<Response<WorkoutSession>> completeSession(String sessionId) async {
    final response = await _dio.post<Map<String, dynamic>>(
      '/sessions/$sessionId/complete',
    );
    return _sessionResponse(response);
  }

  Response<WorkoutSession> _sessionResponse(
    Response<Map<String, dynamic>> response,
  ) {
    return Response(
      data: WorkoutSession.fromJson(response.data!),
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
