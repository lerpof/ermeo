// coverage:ignore-file
class Exercise {
  Exercise({
    required this.id,
    required this.name,
    required this.bodyPart,
    required this.equipment,
    required this.target,
    this.gifUrl,
    this.secondaryMuscles = const [],
    this.instructions = const [],
  });

  factory Exercise.fromJson(Map<String, dynamic> json) => Exercise(
        id: json['id'] as String,
        name: json['name'] as String,
        bodyPart: json['bodyPart'] as String,
        equipment: json['equipment'] as String,
        target: json['target'] as String,
        gifUrl: json['gifUrl'] as String?,
        secondaryMuscles: (json['secondaryMuscles'] as List<dynamic>?)
                ?.map((e) => e as String)
                .toList() ??
            const [],
        instructions: (json['instructions'] as List<dynamic>?)
                ?.map((e) => e as String)
                .toList() ??
            const [],
      );

  final String id;
  final String name;
  final String bodyPart;
  final String equipment;
  final String target;
  final String? gifUrl;
  final List<String> secondaryMuscles;
  final List<String> instructions;
}

class ExerciseListResponse {
  ExerciseListResponse({
    required this.items,
    required this.total,
    required this.limit,
    required this.offset,
  });

  factory ExerciseListResponse.fromJson(Map<String, dynamic> json) =>
      ExerciseListResponse(
        items: (json['items'] as List<dynamic>)
            .map((e) => Exercise.fromJson(e as Map<String, dynamic>))
            .toList(),
        total: json['total'] as int,
        limit: json['limit'] as int,
        offset: json['offset'] as int,
      );

  final List<Exercise> items;
  final int total;
  final int limit;
  final int offset;
}
