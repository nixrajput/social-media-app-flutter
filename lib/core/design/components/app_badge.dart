import 'package:flutter/material.dart';

enum VerificationBadge { blue, gold, grey }

class AppBadge extends StatelessWidget {
  const AppBadge({required this.kind, this.size = 16, super.key});

  final VerificationBadge kind;
  final double size;

  @override
  Widget build(BuildContext context) {
    final color = switch (kind) {
      VerificationBadge.blue => const Color(0xFF1D9BF0),
      VerificationBadge.gold => const Color(0xFFF5B301),
      VerificationBadge.grey => const Color(0xFF8899A6),
    };
    return Icon(Icons.verified, size: size, color: color);
  }
}
