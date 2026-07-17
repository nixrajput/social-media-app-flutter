import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/design/app_colors.dart';
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
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Spacer(flex: 3),
              const Center(child: _BrandMark()),
              const Spacer(flex: 4),
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
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }
}

// Placeholder brand mark: an open-ring motif (spec section 4) + wordmark.
// Stands in until the brand name/logo is locked; swap for the final asset then.
class _BrandMark extends StatelessWidget {
  const _BrandMark();

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColors>()!;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CustomPaint(
          size: const Size(64, 64),
          painter: _RingPainter(colors.accent),
        ),
        const SizedBox(height: 16),
        Text(
          'rippl',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            color: colors.textPrimary,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.5,
          ),
        ),
      ],
    );
  }
}

class _RingPainter extends CustomPainter {
  const _RingPainter(this.color);
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 7
      ..strokeCap = StrokeCap.round;
    final rect = Offset(
          paint.strokeWidth / 2,
          paint.strokeWidth / 2,
        ) &
        Size(
          size.width - paint.strokeWidth,
          size.height - paint.strokeWidth,
        );
    // Open ring: sweep ~300deg, leaving a gap at the top-right (the "open circle").
    canvas.drawArc(rect, -math.pi / 3, math.pi * 5 / 3, false, paint);
  }

  @override
  bool shouldRepaint(_RingPainter old) => old.color != color;
}
