// coverage:ignore-file
import 'package:dio/dio.dart';

import '../models/auth.dart';

class AuthApi {
  AuthApi(this._dio);

  final Dio _dio;

  Future<Response<AuthTokens>> registerUser(RegisterRequest body) async {
    final response = await _dio.post<Map<String, dynamic>>(
      '/auth/register',
      data: body.toJson(),
    );
    return _tokensResponse(response);
  }

  Future<Response<AuthTokens>> loginUser(LoginRequest body) async {
    final response = await _dio.post<Map<String, dynamic>>(
      '/auth/login',
      data: body.toJson(),
    );
    return _tokensResponse(response);
  }

  Future<Response<AuthTokens>> refreshAuth(RefreshRequest body) async {
    final response = await _dio.post<Map<String, dynamic>>(
      '/auth/refresh',
      data: body.toJson(),
    );
    return _tokensResponse(response);
  }

  Response<AuthTokens> _tokensResponse(Response<Map<String, dynamic>> response) {
    return Response(
      data: AuthTokens.fromJson(response.data!),
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
