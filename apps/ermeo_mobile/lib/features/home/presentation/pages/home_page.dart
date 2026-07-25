import 'package:auto_route/auto_route.dart';
import 'package:ermeo_l10n/ermeo_l10n.dart';
import 'package:ermeo_ui/ermeo_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ermeo_mobile/core/router/app_router.dart';
import 'package:ermeo_mobile/features/auth/data/auth_repository.dart';
import 'package:ermeo_mobile/features/home/bloc/home_bloc.dart';

@RoutePage()
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc(
        authRepository: context.read<AuthRepository>(),
      ),
      child: const _HomeView(),
    );
  }
}

class _HomeView extends StatelessWidget {
  const _HomeView();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return BlocConsumer<HomeBloc, HomeState>(
      listenWhen: (previous, current) =>
          previous.navigateToLogin != current.navigateToLogin ||
          previous.failureMessage != current.failureMessage,
      listener: (context, state) {
        if (state.navigateToLogin) {
          context.router.replaceAll([
            const AuthShellRoute(children: [LoginRoute()]),
          ]);
        }
        final failureMessage = state.failureMessage;
        if (failureMessage != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(failureMessage)),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: ErAppBar(title: l10n.homeTitle),
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(l10n.homeWelcomeMessage),
                  const SizedBox(height: 24),
                  ErButton(
                    label: l10n.homeLogoutButton,
                    isLoading: state.isLoggingOut,
                    onPressed: state.isLoggingOut
                        ? null
                        : () => context.read<HomeBloc>().add(
                              const HomeLogoutRequested(),
                            ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
