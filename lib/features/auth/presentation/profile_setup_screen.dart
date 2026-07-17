import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/design/components/app_button.dart';
import '../../../core/design/components/app_snackbar.dart';
import '../../../core/design/components/app_text_field.dart';
import '../../../core/errors/api_error.dart';
import 'auth_controller.dart';

class ProfileSetupScreen extends ConsumerStatefulWidget {
  const ProfileSetupScreen({super.key});
  @override
  ConsumerState<ProfileSetupScreen> createState() => _ProfileSetupScreenState();
}

class _ProfileSetupScreenState extends ConsumerState<ProfileSetupScreen> {
  final _displayName = TextEditingController();
  final _bio = TextEditingController();
  bool _busy = false;

  @override
  void dispose() {
    _displayName.dispose();
    _bio.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    setState(() => _busy = true);
    try {
      await ref
          .read(authControllerProvider.notifier)
          .completeProfile(
            displayName: _displayName.text.trim(),
            bio: _bio.text.trim().isEmpty ? null : _bio.text.trim(),
          );
      // Router redirect moves to home once state becomes authenticated.
    } on ApiError catch (e) {
      if (mounted) showAppSnackbar(context, e.message, isError: true);
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Set up your profile'),
        actions: [
          TextButton(
            onPressed: ref
                .read(authControllerProvider.notifier)
                .skipProfileSetup,
            child: const Text('Skip'),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AppTextField(controller: _displayName, label: 'Display name'),
            const SizedBox(height: 12),
            AppTextField(controller: _bio, label: 'Bio (optional)'),
            const SizedBox(height: 16),
            AppButton(label: 'Continue', loading: _busy, onPressed: _save),
          ],
        ),
      ),
    );
  }
}
