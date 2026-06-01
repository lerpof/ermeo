import 'package:beneesse_api_client/beneesse_api_client.dart' as gen;
import 'package:dio/dio.dart';

import 'api_exception.dart';
import 'auth_interceptor.dart';

/// Hand-written facade over the generated OpenAPI Dio client.
class BeneesseApiClient {
  BeneesseApiClient({
    required String baseUrl,
    Duration connectTimeout = const Duration(seconds: 15),
    Duration receiveTimeout = const Duration(seconds: 30),
    AccessTokenReader? accessTokenReader,
    AccessTokenWriter? accessTokenWriter,
    RefreshTokensCallback? refreshTokens,
    Dio? dio,
  }) : _dio = dio ?? Dio() {
    _dio.options
      ..baseUrl = baseUrl
      ..connectTimeout = connectTimeout
      ..receiveTimeout = receiveTimeout
      ..headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      };

    if (accessTokenReader != null &&
        accessTokenWriter != null &&
        refreshTokens != null) {
      _dio.interceptors.add(
        AuthInterceptor(
          readAccessToken: accessTokenReader,
          writeTokens: accessTokenWriter,
          refreshTokens: refreshTokens,
          refreshDio: _dio,
        ),
      );
    }

    _generated = gen.BeneesseApiClient(_dio, basePath: baseUrl);
  }

  final Dio _dio;
  late final gen.BeneesseApiClient _generated;

  Dio get dio => _dio;

  gen.HealthApi get health => _generated.health;
  gen.AuthApi get auth => _generated.auth;
  gen.ExercisesApi get exercises => _generated.exercises;
  gen.WorkoutsApi get workouts => _generated.workouts;
  gen.SessionsApi get sessions => _generated.sessions;
  gen.InstructorsApi get instructors => _generated.instructors;
  gen.AssignmentsApi get assignments => _generated.assignments;
  gen.AthletesApi get athletes => _generated.athletes;

  /// Executes [call] and maps [DioException] to [ApiException].
  Future<T> run<T>(Future<T> Function() call) async {
    try {
      return await call();
    } on DioException catch (error) {
      throw mapDioException(error);
    }
  }
}
