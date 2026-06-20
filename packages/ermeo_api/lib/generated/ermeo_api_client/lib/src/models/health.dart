// coverage:ignore-file
class HealthResponse {
  HealthResponse({required this.status});

  factory HealthResponse.fromJson(Map<String, dynamic> json) =>
      HealthResponse(status: json['status'] as String);

  final String status;

  Map<String, dynamic> toJson() => {'status': status};
}
