// coverage:ignore-file
class SetLogInput {
  SetLogInput({
    required this.clientSetId,
    required this.exerciseId,
    required this.setIndex,
    this.reps,
    this.weightKg,
    this.completed = false,
  });

  final String clientSetId;
  final String exerciseId;
  final int setIndex;
  final int? reps;
  final double? weightKg;
  final bool completed;

  Map<String, dynamic> toJson() => {
        'clientSetId': clientSetId,
        'exerciseId': exerciseId,
        'setIndex': setIndex,
        if (reps != null) 'reps': reps,
        if (weightKg != null) 'weightKg': weightKg,
        'completed': completed,
      };
}

class SetLog extends SetLogInput {
  SetLog({
    required this.id,
    required super.clientSetId,
    required super.exerciseId,
    required super.setIndex,
    super.reps,
    super.weightKg,
    super.completed = false,
  });

  factory SetLog.fromJson(Map<String, dynamic> json) => SetLog(
        id: json['id'] as String,
        clientSetId: json['clientSetId'] as String,
        exerciseId: json['exerciseId'] as String,
        setIndex: json['setIndex'] as int,
        reps: json['reps'] as int?,
        weightKg: (json['weightKg'] as num?)?.toDouble(),
        completed: json['completed'] as bool? ?? false,
      );

  final String id;
}

class SessionCreateRequest {
  SessionCreateRequest({required this.workoutId, required this.clientId});

  final String workoutId;
  final String clientId;

  Map<String, dynamic> toJson() => {
        'workoutId': workoutId,
        'clientId': clientId,
      };
}

class SessionSetsPatchRequest {
  SessionSetsPatchRequest({required this.sets});

  final List<SetLogInput> sets;

  Map<String, dynamic> toJson() => {
        'sets': sets.map((s) => s.toJson()).toList(),
      };
}

class WorkoutSession {
  WorkoutSession({
    required this.id,
    required this.workoutId,
    required this.userId,
    required this.clientId,
    required this.status,
    required this.sets,
    required this.startedAt,
    this.completedAt,
  });

  factory WorkoutSession.fromJson(Map<String, dynamic> json) => WorkoutSession(
        id: json['id'] as String,
        workoutId: json['workoutId'] as String,
        userId: json['userId'] as String,
        clientId: json['clientId'] as String,
        status: json['status'] as String,
        sets: (json['sets'] as List<dynamic>)
            .map((e) => SetLog.fromJson(e as Map<String, dynamic>))
            .toList(),
        startedAt: DateTime.parse(json['startedAt'] as String),
        completedAt: json['completedAt'] != null
            ? DateTime.parse(json['completedAt'] as String)
            : null,
      );

  final String id;
  final String workoutId;
  final String userId;
  final String clientId;
  final String status;
  final List<SetLog> sets;
  final DateTime startedAt;
  final DateTime? completedAt;
}

class SessionListResponse {
  SessionListResponse({required this.items});

  factory SessionListResponse.fromJson(Map<String, dynamic> json) =>
      SessionListResponse(
        items: (json['items'] as List<dynamic>)
            .map((e) => WorkoutSession.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  final List<WorkoutSession> items;
}
