import 'package:flutter/material.dart';
import '../app_colors.dart';

void showAppSnackbar(
  BuildContext context,
  String message, {
  bool isError = false,
}) {
  final colors = Theme.of(context).extension<AppColors>()!;
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      backgroundColor: isError ? colors.danger : colors.surface,
      behavior: SnackBarBehavior.floating,
    ),
  );
}
