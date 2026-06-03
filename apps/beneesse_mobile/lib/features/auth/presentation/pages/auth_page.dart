import 'package:auto_route/auto_route.dart';
import 'package:beneesse_mobile/core/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/auth_bloc.dart';
import '../../bloc/auth_state.dart';
import '../../data/auth_repository.dart';
import '../views/auth_view.dart';

@RoutePage()
class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AuthBloc(authRepository: context.read<AuthRepository>()),
      child: BlocListener<AuthBloc, AuthState>(
        listenWhen: (previous, current) =>
            previous.status != current.status &&
            current.status == AuthStatus.success,
        listener: (context, state) =>
            context.router.replace(const ExercisesRoute()),
        child: const AuthView(),
      ),
    );
  }
}
