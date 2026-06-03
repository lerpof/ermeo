import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/exercises_bloc.dart';
import '../../bloc/exercises_event.dart';
import '../../data/exercise_repository.dart';
import '../views/exercises_view.dart';

@RoutePage()
class ExercisesPage extends StatelessWidget {
  const ExercisesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ExercisesBloc(exerciseRepository: context.read<ExerciseRepository>())
        ..add(const ExercisesLoadRequested()),
      child: const ExercisesView(),
    );
  }
}
