import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/design/components/app_button.dart';
import '../../../core/design/components/app_snackbar.dart';
import '../../../core/design/components/app_text_field.dart';
import '../../../core/errors/api_error.dart';
import 'auth_controller.dart';

class OtpVerifyScreen extends ConsumerStatefulWidget {
  const OtpVerifyScreen({required this.email, super.key});
  final String email;
  @override
  ConsumerState<OtpVerifyScreen> createState() => _OtpVerifyScreenState();
}

class _OtpVerifyScreenState extends ConsumerState<OtpVerifyScreen> {
  final _otp = TextEditingController();
  final _username = TextEditingController();
  final _password = TextEditingController();
  bool _busy = false;

  @override
  void dispose() {
    _otp.dispose();
    _username.dispose();
    _password.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    setState(() => _busy = true);
    try {
      await ref
          .read(authControllerProvider.notifier)
          .register(
            email: widget.email,
            otp: _otp.text.trim(),
            username: _username.text.trim(),
            password: _password.text,
          );
      // Router redirect takes over on authenticated state.
    } on ApiError catch (e) {
      if (mounted) showAppSnackbar(context, e.message, isError: true);
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AppTextField(
              controller: _otp,
              label: '6-digit code',
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 12),
            AppTextField(controller: _username, label: 'Username'),
            const SizedBox(height: 12),
            AppTextField(
              controller: _password,
              label: 'Password',
              obscure: true,
            ),
            const SizedBox(height: 16),
            AppButton(
              label: 'Create account',
              loading: _busy,
              onPressed: _submit,
            ),
          ],
        ),
      ),
    );
  }
}
