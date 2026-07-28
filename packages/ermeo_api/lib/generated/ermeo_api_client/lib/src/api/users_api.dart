// coverage:ignore-file
import 'package:dio/dio.dart';

import '../models/auth.dart';

class UsersApi {
  UsersApi(this._dio);

  final Dio _dio;

  Future<Response<UserProfile>> getCurrentUser() async {
    final response = await _dio.get<Map<String, dynamic>>('/users/me');
    return _profileResponse(response);
  }

  Future<Response<UserProfile>> updateCurrentUser(UpdateUserRequest body) async {
    final response = await _dio.patch<Map<String, dynamic>>(
      '/users/me',
      data: body.toJson(),
    );
    return _profileResponse(response);
  }

  Response<UserProfile> _profileResponse(
    Response<Map<String, dynamic>> response,
  ) {
    return Response(
      data: UserProfile.fromJson(response.data!),
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
