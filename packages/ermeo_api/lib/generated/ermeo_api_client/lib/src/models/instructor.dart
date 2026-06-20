// coverage:ignore-file
class InstructorSummary {
  InstructorSummary({
    required this.id,
    required this.displayName,
    this.bio,
  });

  factory InstructorSummary.fromJson(Map<String, dynamic> json) =>
      InstructorSummary(
        id: json['id'] as String,
        displayName: json['displayName'] as String,
        bio: json['bio'] as String?,
      );

  final String id;
  final String displayName;
  final String? bio;
}

class InstructorListResponse {
  InstructorListResponse({required this.items});

  factory InstructorListResponse.fromJson(Map<String, dynamic> json) =>
      InstructorListResponse(
        items: (json['items'] as List<dynamic>)
            .map(
              (e) => InstructorSummary.fromJson(e as Map<String, dynamic>),
            )
            .toList(),
      );

  final List<InstructorSummary> items;
}
