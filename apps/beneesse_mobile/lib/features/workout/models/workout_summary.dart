/// Feature-level workout summary (decoupled from API DTOs).
class WorkoutSummary {
  const WorkoutSummary({
    required this.id,
    required this.name,
    this.description,
  });

  final String id;
  final String name;
  final String? description;
}
