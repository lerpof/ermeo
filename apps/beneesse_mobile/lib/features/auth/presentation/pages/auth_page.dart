import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../bloc/auth_bloc.dart';
import '../../bloc/auth_state.dart';
import '../../data/auth_repository.dart';
import '../views/auth_view.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({required this.authRepository, super.key});

  final AuthRepository authRepository;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AuthBloc(authRepository: authRepository),
      child: BlocListener<AuthBloc, AuthState>(
        listenWhen: (previous, current) =>
            previous.status != current.status &&
            current.status == AuthStatus.success,
        listener: (context, state) {
          context.go('/');
        },
        child: const AuthView(),
      ),
    );
  }
}
