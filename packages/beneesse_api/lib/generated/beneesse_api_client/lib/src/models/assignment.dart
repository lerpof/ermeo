// coverage:ignore-file
class AssignmentCreateRequest {
  AssignmentCreateRequest({
    required this.instructorId,
    required this.athleteId,
  });

  final String instructorId;
  final String athleteId;

  Map<String, dynamic> toJson() => {
        'instructorId': instructorId,
        'athleteId': athleteId,
      };
}

class InstructorAssignment {
  InstructorAssignment({
    required this.id,
    required this.instructorId,
    required this.athleteId,
    required this.createdAt,
  });

  factory InstructorAssignment.fromJson(Map<String, dynamic> json) =>
      InstructorAssignment(
        id: json['id'] as String,
        instructorId: json['instructorId'] as String,
        athleteId: json['athleteId'] as String,
        createdAt: DateTime.parse(json['createdAt'] as String),
      );

  final String id;
  final String instructorId;
  final String athleteId;
  final DateTime createdAt;
}
