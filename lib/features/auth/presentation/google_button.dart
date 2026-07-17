import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/design/components/app_button.dart';
import '../../../core/design/components/app_snackbar.dart';
import '../../../core/errors/api_error.dart';
import 'auth_controller.dart';

class GoogleButton extends ConsumerStatefulWidget {
  const GoogleButton({super.key});
  @override
  ConsumerState<GoogleButton> createState() => _GoogleButtonState();
}

class _GoogleButtonState extends ConsumerState<GoogleButton> {
  bool _busy = false;

  Future<void> _signIn() async {
    setState(() => _busy = true);
    try {
      await ref.read(authControllerProvider.notifier).loginWithGoogle();
      // Router redirect drives navigation on authenticated/profileSetup state.
    } on ApiError catch (e) {
      if (mounted) showAppSnackbar(context, e.message, isError: true);
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppButton(
      label: 'Continue with Google',
      variant: AppButtonVariant.secondary,
      loading: _busy,
      onPressed: _signIn,
    );
  }
}
