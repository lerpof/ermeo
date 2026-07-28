import 'package:auto_route/auto_route.dart';
import 'package:ermeo_l10n/ermeo_l10n.dart';
import 'package:ermeo_ui/ermeo_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ermeo_mobile/core/router/app_router.dart';
import 'package:ermeo_mobile/features/auth/bloc/role_selection/role_selection_bloc.dart';
import 'package:ermeo_mobile/features/auth/data/auth_repository.dart';
import 'package:ermeo_mobile/features/auth/models/auth_role.dart';

@RoutePage()
class RoleSelectionPage extends StatelessWidget {
  const RoleSelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RoleSelectionBloc(
        authRepository: context.read<AuthRepository>(),
      ),
      child: const _RoleSelectionView(),
    );
  }
}

class _RoleSelectionView extends StatelessWidget {
  const _RoleSelectionView();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return BlocConsumer<RoleSelectionBloc, RoleSelectionState>(
      listenWhen: (previous, current) =>
          previous.navigateToHome != current.navigateToHome,
      listener: (context, state) {
        if (state.navigateToHome) {
          context.router.replaceAll([const HomeRoute()]);
        }
      },
      builder: (context, state) {
        final failureText = _failureText(l10n, state.failure);

        return Scaffold(
          appBar: ErAppBar(title: l10n.authRoleSelectionTitle),
          body: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  l10n.authRoleSelectionSubtitle,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: 24),
                _RoleOptionTile(
                  label: l10n.authRoleSelectionAthlete,
                  selected: state.role == AuthRole.athlete,
                  enabled: !state.isSubmitting,
                  onTap: () => context.read<RoleSelectionBloc>().add(
                        const RoleSelectionRoleChanged(AuthRole.athlete),
                      ),
                ),
                _RoleOptionTile(
                  label: l10n.authRoleSelectionInstructor,
                  selected: state.role == AuthRole.instructor,
                  enabled: !state.isSubmitting,
                  onTap: () => context.read<RoleSelectionBloc>().add(
                        const RoleSelectionRoleChanged(AuthRole.instructor),
                      ),
                ),
                if (failureText != null) ...[
                  const SizedBox(height: 12),
                  Text(
                    failureText,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).colorScheme.error,
                    ),
                  ),
                ],
                const Spacer(),
                ErButton(
                  label: l10n.authRoleSelectionContinueButton,
                  isLoading: state.isSubmitting,
                  onPressed: state.isSubmitting
                      ? null
                      : () => context.read<RoleSelectionBloc>().add(
                            const RoleSelectionSubmitted(),
                          ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  String? _failureText(ErLocalizations l10n, RoleSelectionFailure? failure) {
    return switch (failure) {
      null => null,
      RoleSelectionValidationFailure(:final error) => switch (error) {
        RoleSelectionValidationError.roleRequired =>
          l10n.authValidationRoleRequired,
      },
      RoleSelectionApiFailure(:final message) => message,
    };
  }
}

class _RoleOptionTile extends StatelessWidget {
  const _RoleOptionTile({
    required this.label,
    required this.selected,
    required this.enabled,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final bool enabled;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(label),
      selected: selected,
      enabled: enabled,
      trailing: selected ? const Icon(Icons.check) : null,
      onTap: enabled ? onTap : null,
    );
  }
}
