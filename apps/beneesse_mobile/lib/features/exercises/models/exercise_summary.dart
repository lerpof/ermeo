/// Feature-level exercise summary (decoupled from API DTOs).
class ExerciseSummary {
  const ExerciseSummary({
    required this.id,
    required this.name,
    required this.bodyPart,
    required this.equipment,
    required this.target,
  });

  final String id;
  final String name;
  final String bodyPart;
  final String equipment;
  final String target;
}
