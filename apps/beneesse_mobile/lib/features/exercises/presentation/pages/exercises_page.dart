import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/exercises_bloc.dart';
import '../../bloc/exercises_event.dart';
import '../../data/exercise_repository.dart';
import '../views/exercises_view.dart';

class ExercisesPage extends StatelessWidget {
  const ExercisesPage({required this.exerciseRepository, super.key});

  final ExerciseRepository exerciseRepository;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ExercisesBloc(exerciseRepository: exerciseRepository)
        ..add(const ExercisesLoadRequested()),
      child: const ExercisesView(),
    );
  }
}
