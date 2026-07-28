import 'package:auto_route/auto_route.dart';
import 'package:ermeo_l10n/ermeo_l10n.dart';
import 'package:ermeo_ui/ermeo_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ermeo_mobile/core/router/app_router.dart';
import 'package:ermeo_mobile/features/auth/bloc/register/register_bloc.dart';
import 'package:ermeo_mobile/features/auth/data/auth_repository.dart';

@RoutePage()
class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterBloc(
        authRepository: context.read<AuthRepository>(),
      ),
      child: const _RegisterView(),
    );
  }
}

class _RegisterView extends StatelessWidget {
  const _RegisterView();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return BlocConsumer<RegisterBloc, RegisterState>(
      listenWhen: (previous, current) =>
          previous.navigateToRoleSelection != current.navigateToRoleSelection,
      listener: (context, state) {
        if (state.navigateToRoleSelection) {
          context.router.replaceAll([const RoleSelectionRoute()]);
        }
      },
      builder: (context, state) {
        final failureText = _failureText(l10n, state.failure);

        return Scaffold(
          appBar: ErAppBar(
            title: l10n.authRegisterTitle,
            showBackButton: true,
            onBack: () => context.router.pop(),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ErTextField(
                  label: l10n.authRegisterDisplayNameLabel,
                  textInputAction: TextInputAction.next,
                  enabled: !state.isSubmitting,
                  errorText: _isValidation(
                    state.failure,
                    RegisterValidationError.displayNameRequired,
                  )
                      ? failureText
                      : null,
                  onChanged: (value) => context.read<RegisterBloc>().add(
                        RegisterDisplayNameChanged(value),
                      ),
                ),
                const SizedBox(height: 16),
                ErTextField(
                  label: l10n.authRegisterEmailLabel,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  enabled: !state.isSubmitting,
                  errorText: _isValidation(
                    state.failure,
                    RegisterValidationError.emailRequired,
                  )
                      ? failureText
                      : null,
                  onChanged: (value) => context.read<RegisterBloc>().add(
                        RegisterEmailChanged(value),
                      ),
                ),
                const SizedBox(height: 16),
                ErTextField(
                  label: l10n.authRegisterPasswordLabel,
                  obscureText: true,
                  textInputAction: TextInputAction.done,
                  enabled: !state.isSubmitting,
                  errorText: _isValidation(
                            state.failure,
                            RegisterValidationError.passwordRequired,
                          ) ||
                          _isValidation(
                            state.failure,
                            RegisterValidationError.passwordTooShort,
                          )
                      ? failureText
                      : null,
                  onChanged: (value) => context.read<RegisterBloc>().add(
                        RegisterPasswordChanged(value),
                      ),
                ),
                if (state.failure is RegisterApiFailure) ...[
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
                  label: l10n.authRegisterSubmitButton,
                  isLoading: state.isSubmitting,
                  onPressed: state.isSubmitting
                      ? null
                      : () => context.read<RegisterBloc>().add(
                            const RegisterSubmitted(),
                          ),
                ),
                const SizedBox(height: 16),
                ErButton(
                  label: l10n.authRegisterGoToLogin,
                  variant: ErButtonVariant.ghost,
                  onPressed: state.isSubmitting
                      ? null
                      : () => context.router.replace(const LoginRoute()),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  bool _isValidation(
    RegisterFailure? failure,
    RegisterValidationError error,
  ) {
    return failure is RegisterValidationFailure && failure.error == error;
  }

  String? _failureText(ErLocalizations l10n, RegisterFailure? failure) {
    return switch (failure) {
      null => null,
      RegisterValidationFailure(:final error) => switch (error) {
        RegisterValidationError.emailRequired =>
          l10n.authValidationEmailRequired,
        RegisterValidationError.passwordRequired =>
          l10n.authValidationPasswordRequired,
        RegisterValidationError.passwordTooShort =>
          l10n.authValidationPasswordTooShort,
        RegisterValidationError.displayNameRequired =>
          l10n.authValidationDisplayNameRequired,
      },
      RegisterApiFailure(:final message) => message,
    };
  }
}
