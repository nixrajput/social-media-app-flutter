import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/design/components/app_button.dart';
import '../../../core/design/components/app_snackbar.dart';
import '../../../core/design/components/app_text_field.dart';
import '../../../core/errors/api_error.dart';
import '../../../core/router/routes.dart';
import '../../../data/repositories/auth_repository_impl.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});
  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  final _email = TextEditingController();
  bool _busy = false;

  @override
  void dispose() {
    _email.dispose();
    super.dispose();
  }

  Future<void> _sendOtp() async {
    setState(() => _busy = true);
    try {
      await ref
          .read(authRepositoryProvider)
          .sendRegisterOtp(_email.text.trim());
      if (mounted) {
        unawaited(context.push(Routes.otp, extra: _email.text.trim()));
      }
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
              controller: _email,
              label: 'Email',
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 16),
            AppButton(label: 'Send code', loading: _busy, onPressed: _sendOtp),
          ],
        ),
      ),
    );
  }
}
