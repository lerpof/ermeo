// coverage:ignore-file
import 'package:dio/dio.dart';

import '../models/assignment.dart';

class AssignmentsApi {
  AssignmentsApi(this._dio);

  final Dio _dio;

  Future<Response<InstructorAssignment>> createAssignment(
    AssignmentCreateRequest body,
  ) async {
    final response = await _dio.post<Map<String, dynamic>>(
      '/assignments',
      data: body.toJson(),
    );
    return Response(
      data: InstructorAssignment.fromJson(response.data!),
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
