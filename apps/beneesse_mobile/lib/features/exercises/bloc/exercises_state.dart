enum ExercisesStatus {
  initial,
  loading,
  loaded,
  failure,
}

class ExerciseListItem {
  const ExerciseListItem({
    required this.title,
    required this.subtitle,
  });

  final String title;
  final String subtitle;
}

class ExercisesState {
  const ExercisesState({
    this.status = ExercisesStatus.initial,
    this.items = const [],
    this.errorMessage,
    this.appBarTitle = 'Exercises',
  });

  final ExercisesStatus status;
  final List<ExerciseListItem> items;
  final String? errorMessage;
  final String appBarTitle;

  bool get isLoading => status == ExercisesStatus.loading;

  ExercisesState copyWith({
    ExercisesStatus? status,
    List<ExerciseListItem>? items,
    String? errorMessage,
    bool clearError = false,
    String? appBarTitle,
  }) {
    return ExercisesState(
      status: status ?? this.status,
      items: items ?? this.items,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
      appBarTitle: appBarTitle ?? this.appBarTitle,
    );
  }
}
