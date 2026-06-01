/// Feature-level instructor summary.
class InstructorSummary {
  const InstructorSummary({
    required this.id,
    required this.displayName,
    this.bio,
  });

  final String id;
  final String displayName;
  final String? bio;
}
