import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/design/components/app_button.dart';
import '../../../core/design/components/app_snackbar.dart';
import '../../../core/design/components/app_text_field.dart';
import '../../../core/errors/api_error.dart';
import 'auth_controller.dart';

class TwoFactorScreen extends ConsumerStatefulWidget {
  const TwoFactorScreen({super.key});
  @override
  ConsumerState<TwoFactorScreen> createState() => _TwoFactorScreenState();
}

class _TwoFactorScreenState extends ConsumerState<TwoFactorScreen> {
  final _totp = TextEditingController();
  bool _busy = false;

  @override
  void dispose() {
    _totp.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    setState(() => _busy = true);
    try {
      await ref
          .read(authControllerProvider.notifier)
          .submit2fa(_totp.text.trim());
    } on ApiError catch (e) {
      if (mounted) showAppSnackbar(context, e.message, isError: true);
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Two-factor code')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AppTextField(
              controller: _totp,
              label: 'Authenticator code',
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            AppButton(label: 'Verify', loading: _busy, onPressed: _submit),
          ],
        ),
      ),
    );
  }
}
