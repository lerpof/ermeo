// coverage:ignore-file
class ExerciseRef {
  ExerciseRef({
    required this.exerciseId,
    required this.name,
    required this.order,
    this.targetSets,
    this.targetReps,
  });

  factory ExerciseRef.fromJson(Map<String, dynamic> json) => ExerciseRef(
        exerciseId: json['exerciseId'] as String,
        name: json['name'] as String,
        order: json['order'] as int,
        targetSets: json['targetSets'] as int?,
        targetReps: json['targetReps'] as int?,
      );

  final String exerciseId;
  final String name;
  final int order;
  final int? targetSets;
  final int? targetReps;

  Map<String, dynamic> toJson() => {
        'exerciseId': exerciseId,
        'name': name,
        'order': order,
        if (targetSets != null) 'targetSets': targetSets,
        if (targetReps != null) 'targetReps': targetReps,
      };
}

class WorkoutCreateRequest {
  WorkoutCreateRequest({
    required this.name,
    required this.exercises,
    this.description,
  });

  final String name;
  final String? description;
  final List<ExerciseRef> exercises;

  Map<String, dynamic> toJson() => {
        'name': name,
        if (description != null) 'description': description,
        'exercises': exercises.map((e) => e.toJson()).toList(),
      };
}

class Workout {
  Workout({
    required this.id,
    required this.name,
    required this.exercises,
    required this.createdAt,
    required this.updatedAt,
    this.description,
  });

  factory Workout.fromJson(Map<String, dynamic> json) => Workout(
        id: json['id'] as String,
        name: json['name'] as String,
        description: json['description'] as String?,
        exercises: (json['exercises'] as List<dynamic>)
            .map((e) => ExerciseRef.fromJson(e as Map<String, dynamic>))
            .toList(),
        createdAt: DateTime.parse(json['createdAt'] as String),
        updatedAt: DateTime.parse(json['updatedAt'] as String),
      );

  final String id;
  final String name;
  final String? description;
  final List<ExerciseRef> exercises;
  final DateTime createdAt;
  final DateTime updatedAt;
}

class WorkoutListResponse {
  WorkoutListResponse({required this.items});

  factory WorkoutListResponse.fromJson(Map<String, dynamic> json) =>
      WorkoutListResponse(
        items: (json['items'] as List<dynamic>)
            .map((e) => Workout.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  final List<Workout> items;
}
