import 'package:ermeo_api_client/ermeo_api_client.dart' as gen;
import 'package:dio/dio.dart';

import 'api_exception.dart';
import 'api_logger.dart';
import 'auth_interceptor.dart';
import 'logging_interceptor.dart';
import 'session_service.dart';

/// Hand-written facade over the generated OpenAPI Dio client.
class ErmeoApiClient {
  ErmeoApiClient({
    required String baseUrl,
    Duration connectTimeout = const Duration(seconds: 15),
    Duration receiveTimeout = const Duration(seconds: 30),
    SessionService? sessionService,
    ApiLogger? logger,
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

    if (sessionService != null) {
      _dio.interceptors.add(
        AuthInterceptor(
          sessionService: sessionService,
          baseUrl: baseUrl,
          connectTimeout: connectTimeout,
          receiveTimeout: receiveTimeout,
          retryDio: _dio,
        ),
      );
    }

    if (logger != null) {
      _dio.interceptors.add(LoggingInterceptor(logger: logger));
    }

    _generated = gen.ErmeoApiClient(_dio, basePath: baseUrl);
  }

  final Dio _dio;
  late final gen.ErmeoApiClient _generated;

  Dio get dio => _dio;

  gen.HealthApi get health => _generated.health;
  gen.AuthApi get auth => _generated.auth;
  gen.UsersApi get users => _generated.users;
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
