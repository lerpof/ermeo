// coverage:ignore-file
import 'package:dio/dio.dart';

import '../models/workout.dart';

class WorkoutsApi {
  WorkoutsApi(this._dio);

  final Dio _dio;

  Future<Response<WorkoutListResponse>> listWorkouts() async {
    final response = await _dio.get<Map<String, dynamic>>('/workouts');
    return Response(
      data: WorkoutListResponse.fromJson(response.data!),
      headers: response.headers,
      requestOptions: response.requestOptions,
      statusCode: response.statusCode,
      statusMessage: response.statusMessage,
      isRedirect: response.isRedirect,
      redirects: response.redirects,
      extra: response.extra,
    );
  }

  Future<Response<Workout>> createWorkout(WorkoutCreateRequest body) async {
    final response = await _dio.post<Map<String, dynamic>>(
      '/workouts',
      data: body.toJson(),
    );
    return _workoutResponse(response);
  }

  Future<Response<Workout>> getWorkout(String workoutId) async {
    final response = await _dio.get<Map<String, dynamic>>(
      '/workouts/$workoutId',
    );
    return _workoutResponse(response);
  }

  Response<Workout> _workoutResponse(Response<Map<String, dynamic>> response) {
    return Response(
      data: Workout.fromJson(response.data!),
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
