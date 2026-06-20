import 'package:auto_route/auto_route.dart';
import 'package:ermeo_l10n/ermeo_l10n.dart';
import 'package:ermeo_ui/ermeo_ui.dart';
import 'package:flutter/material.dart';

import 'package:ermeo_mobile/core/router/app_router.dart';

@RoutePage()
class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

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
            ),
            const SizedBox(height: 16),
            ErTextField(
              label: l10n.authLoginPasswordLabel,
              obscureText: true,
              textInputAction: TextInputAction.done,
            ),
            const SizedBox(height: 24),
            ErButton(
              label: l10n.authLoginSubmitButton,
              onPressed: null,
            ),
            const SizedBox(height: 16),
            ErButton(
              label: l10n.authLoginGoToRegister,
              variant: ErButtonVariant.ghost,
              onPressed: () => context.router.push(const RegisterRoute()),
            ),
          ],
        ),
      ),
    );
  }
}
