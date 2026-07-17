import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/design/components/app_button.dart';
import '../../../core/router/routes.dart';
import 'google_button.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Spacer(),
              Text(
                'Your circle, private by default',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 32),
              AppButton(
                label: 'Create account',
                onPressed: () => context.push(Routes.register),
              ),
              const SizedBox(height: 12),
              AppButton(
                label: 'Log in',
                variant: AppButtonVariant.secondary,
                onPressed: () => context.push(Routes.login),
              ),
              const SizedBox(height: 12),
              const GoogleButton(),
            ],
          ),
        ),
      ),
    );
  }
}
