// coverage:ignore-file
import 'package:dio/dio.dart';

import '../models/exercise.dart';

class ExercisesApi {
  ExercisesApi(this._dio);

  final Dio _dio;

  Future<Response<ExerciseListResponse>> listExercises({
    int? limit,
    int? offset,
    String? bodyPart,
    String? equipment,
    String? target,
    String? q,
  }) async {
    final response = await _dio.get<Map<String, dynamic>>(
      '/exercises',
      queryParameters: {
        if (limit != null) 'limit': limit,
        if (offset != null) 'offset': offset,
        if (bodyPart != null) 'bodyPart': bodyPart,
        if (equipment != null) 'equipment': equipment,
        if (target != null) 'target': target,
        if (q != null) 'q': q,
      },
    );
    return Response(
      data: ExerciseListResponse.fromJson(response.data!),
      headers: response.headers,
      requestOptions: response.requestOptions,
      statusCode: response.statusCode,
      statusMessage: response.statusMessage,
      isRedirect: response.isRedirect,
      redirects: response.redirects,
      extra: response.extra,
    );
  }

  Future<Response<Exercise>> getExercise(String exerciseId) async {
    final response = await _dio.get<Map<String, dynamic>>(
      '/exercises/$exerciseId',
    );
    return Response(
      data: Exercise.fromJson(response.data!),
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
