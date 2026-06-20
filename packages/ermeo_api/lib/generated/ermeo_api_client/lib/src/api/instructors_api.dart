// coverage:ignore-file
import 'package:dio/dio.dart';

import '../models/instructor.dart';

class InstructorsApi {
  InstructorsApi(this._dio);

  final Dio _dio;

  Future<Response<InstructorListResponse>> listInstructors() async {
    final response = await _dio.get<Map<String, dynamic>>('/instructors');
    return Response(
      data: InstructorListResponse.fromJson(response.data!),
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
