import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:ermeo_l10n/ermeo_l10n.dart';
import 'package:ermeo_ui/ermeo_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:ermeo_mobile/core/router/app_router.dart';
import 'package:ermeo_mobile/core/session/session_service.dart';
import 'package:ermeo_mobile/features/auth/bloc/login/login_bloc.dart';
import 'package:ermeo_mobile/features/auth/data/auth_repository.dart';

@RoutePage()
class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(
        authRepository: context.read<AuthRepository>(),
        sessionService: context.read<AppSessionService>(),
      ),
      child: const _LoginView(),
    );
  }
}

class _LoginView extends StatelessWidget {
  const _LoginView();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return BlocConsumer<LoginBloc, LoginState>(
      listenWhen: (previous, current) =>
          previous.navigateToHome != current.navigateToHome ||
          previous.navigateToRoleSelection != current.navigateToRoleSelection,
      listener: (context, state) {
        if (state.navigateToRoleSelection) {
          context.router.replaceAll([const RoleSelectionRoute()]);
          return;
        }
        if (state.navigateToHome) {
          context.router.replaceAll([const HomeRoute()]);
        }
      },
      builder: (context, state) {
        final failureText = _failureText(l10n, state.failure);

        return Scaffold(
          appBar: ErAppBar(title: l10n.authLoginTitle),
          body: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ErTextField(
                  label: l10n.authLoginEmailLabel,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  enabled: !state.isSubmitting,
                  errorText: state.failure is LoginValidationFailure &&
                          (state.failure! as LoginValidationFailure).error ==
                              LoginValidationError.emailRequired
                      ? failureText
                      : null,
                  onChanged: (value) => context.read<LoginBloc>().add(
                        LoginEmailChanged(value),
                      ),
                ),
                const SizedBox(height: 16),
                ErTextField(
                  label: l10n.authLoginPasswordLabel,
                  obscureText: true,
                  textInputAction: TextInputAction.done,
                  enabled: !state.isSubmitting,
                  errorText: state.failure is LoginValidationFailure &&
                          (state.failure! as LoginValidationFailure).error ==
                              LoginValidationError.passwordRequired
                      ? failureText
                      : null,
                  onChanged: (value) => context.read<LoginBloc>().add(
                        LoginPasswordChanged(value),
                      ),
                  onSubmitted: (_) => context.read<LoginBloc>().add(
                        const LoginSubmitted(),
                      ),
                ),
                if (state.failure is LoginApiFailure) ...[
                  const SizedBox(height: 12),
                  Text(
                    failureText ?? '',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).colorScheme.error,
                    ),
                  ),
                ],
                const SizedBox(height: 24),
                ErButton(
                  label: l10n.authLoginSubmitButton,
                  isLoading: state.isSubmitting,
                  onPressed: state.isSubmitting
                      ? null
                      : () => context.read<LoginBloc>().add(
                            const LoginSubmitted(),
                          ),
                ),
                const SizedBox(height: 16),
                ErButton(
                  label: l10n.authLoginGoogleButton,
                  icon: FontAwesomeIcons.google.data,
                  variant: ErButtonVariant.secondary,
                  onPressed: state.isSubmitting
                      ? null
                      : () => context.read<LoginBloc>().add(
                            const LoginGooglePressed(),
                          ),
                ),
                if (Platform.isIOS) ...[
                  const SizedBox(height: 12),
                  ErButton(
                    label: l10n.authLoginAppleButton,
                    icon: Icons.apple,
                    variant: ErButtonVariant.secondary,
                    onPressed: state.isSubmitting
                        ? null
                        : () => context.read<LoginBloc>().add(
                              const LoginApplePressed(),
                            ),
                  ),
                ],
                const SizedBox(height: 16),
                ErButton(
                  label: l10n.authLoginGoToRegister,
                  variant: ErButtonVariant.ghost,
                  onPressed: state.isSubmitting
                      ? null
                      : () => context.router.push(const RegisterRoute()),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  String? _failureText(ErLocalizations l10n, LoginFailure? failure) {
    return switch (failure) {
      null => null,
      LoginValidationFailure(:final error) => switch (error) {
        LoginValidationError.emailRequired => l10n.authValidationEmailRequired,
        LoginValidationError.passwordRequired =>
          l10n.authValidationPasswordRequired,
      },
      LoginApiFailure(:final message) => message,
    };
  }
}
