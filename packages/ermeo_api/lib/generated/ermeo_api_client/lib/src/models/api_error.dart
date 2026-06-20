// coverage:ignore-file
class ApiError {
  ApiError({required this.code, required this.message, this.details});

  factory ApiError.fromJson(Map<String, dynamic> json) => ApiError(
        code: json['code'] as String,
        message: json['message'] as String,
        details: json['details'] as Map<String, dynamic>?,
      );

  final String code;
  final String message;
  final Map<String, dynamic>? details;

  Map<String, dynamic> toJson() => {
        'code': code,
        'message': message,
        if (details != null) 'details': details,
      };
}
