import 'package:beneesse_api/beneesse_api.dart';
import 'package:beneesse_ui/beneesse_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/auth_bloc.dart';
import '../../bloc/auth_event.dart';
import '../../bloc/auth_state.dart';
import '../../models/auth_mode.dart';

class AuthView extends StatelessWidget {
  const AuthView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        final spacing = context.beSpacing;

        return Scaffold(
          appBar: BeAppBar(title: state.appBarTitle),
          body: SingleChildScrollView(
            padding: EdgeInsets.all(spacing.pagePadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: BeButton(
                        label: state.loginTabLabel,
                        variant: state.mode == AuthMode.login
                            ? BeButtonVariant.primary
                            : BeButtonVariant.ghost,
                        onPressed: state.mode == AuthMode.login
                            ? null
                            : () => context.read<AuthBloc>().add(
                                  const AuthModeToggled(AuthMode.login),
                                ),
                      ),
                    ),
                    SizedBox(width: spacing.inlineGap),
                    Expanded(
                      child: BeButton(
                        label: state.signupTabLabel,
                        variant: state.mode == AuthMode.signup
                            ? BeButtonVariant.primary
                            : BeButtonVariant.ghost,
                        onPressed: state.mode == AuthMode.signup
                            ? null
                            : () => context.read<AuthBloc>().add(
                                  const AuthModeToggled(AuthMode.signup),
                                ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spacing.sectionGap),
                BeTextField(
                  label: state.emailLabel,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  onChanged: (value) => context.read<AuthBloc>().add(
                        AuthEmailChanged(value),
                      ),
                ),
                SizedBox(height: spacing.componentGap),
                BeTextField(
                  label: state.passwordLabel,
                  obscureText: true,
                  textInputAction: state.isSignup
                      ? TextInputAction.next
                      : TextInputAction.done,
                  onChanged: (value) => context.read<AuthBloc>().add(
                        AuthPasswordChanged(value),
                      ),
                ),
                if (state.isSignup) ...[
                  SizedBox(height: spacing.componentGap),
                  BeTextField(
                    label: state.displayNameLabel,
                    textInputAction: TextInputAction.next,
                    onChanged: (value) => context.read<AuthBloc>().add(
                          AuthDisplayNameChanged(value),
                        ),
                  ),
                  SizedBox(height: spacing.componentGap),
                  Row(
                    children: [
                      Expanded(
                        child: BeButton(
                          label: state.athleteRoleLabel,
                          variant: state.role == UserRole.athlete
                              ? BeButtonVariant.primary
                              : BeButtonVariant.outline,
                          onPressed: state.role == UserRole.athlete
                              ? null
                              : () => context.read<AuthBloc>().add(
                                    const AuthRoleChanged(UserRole.athlete),
                                  ),
                        ),
                      ),
                      SizedBox(width: spacing.inlineGap),
                      Expanded(
                        child: BeButton(
                          label: state.instructorRoleLabel,
                          variant: state.role == UserRole.instructor
                              ? BeButtonVariant.primary
                              : BeButtonVariant.outline,
                          onPressed: state.role == UserRole.instructor
                              ? null
                              : () => context.read<AuthBloc>().add(
                                    const AuthRoleChanged(UserRole.instructor),
                                  ),
                        ),
                      ),
                    ],
                  ),
                ],
                if (state.errorMessage != null) ...[
                  SizedBox(height: spacing.componentGap),
                  BeText(
                    state.errorMessage!,
                    color: BeTextColor.error,
                  ),
                ],
                SizedBox(height: spacing.sectionGap),
                BeButton(
                  label: state.submitButtonLabel,
                  isLoading: state.isLoading,
                  onPressed: state.isLoading
                      ? null
                      : () => context.read<AuthBloc>().add(
                            const AuthSubmitted(),
                          ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
