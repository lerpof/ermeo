import 'package:beneesse_ui/beneesse_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/exercises_bloc.dart';
import '../../bloc/exercises_state.dart';

class ExercisesView extends StatelessWidget {
  const ExercisesView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExercisesBloc, ExercisesState>(
      builder: (context, state) {
        final spacing = context.beSpacing;

        return Scaffold(
          appBar: BeAppBar(title: state.appBarTitle),
          body: _buildBody(context, state, spacing),
        );
      },
    );
  }

  Widget _buildBody(
    BuildContext context,
    ExercisesState state,
    BeSpacingTokens spacing,
  ) {
    if (state.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state.status == ExercisesStatus.failure &&
        state.errorMessage != null) {
      return Center(
        child: Padding(
          padding: EdgeInsets.all(spacing.pagePadding),
          child: BeText(
            state.errorMessage!,
            color: BeTextColor.error,
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    if (state.status == ExercisesStatus.loaded) {
      return ListView.separated(
        padding: EdgeInsets.all(spacing.pagePadding),
        itemCount: state.items.length,
        separatorBuilder: (_, _) => SizedBox(height: spacing.componentGap),
        itemBuilder: (context, index) {
          final item = state.items[index];
          return BeCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BeText(item.title, variant: BeTextVariant.titleMedium),
                SizedBox(height: spacing.stackGap),
                BeText(
                  item.subtitle,
                  variant: BeTextVariant.bodySmall,
                  color: BeTextColor.secondary,
                ),
              ],
            ),
          );
        },
      );
    }

    return const SizedBox.shrink();
  }
}
