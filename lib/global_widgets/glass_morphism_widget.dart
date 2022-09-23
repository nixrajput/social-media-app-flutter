import 'dart:ui';

import 'package:flutter/material.dart';

class NxGlassContainer extends StatelessWidget {
  final double blur;
  final Widget child;
  final double opacity;

  const NxGlassContainer({
    Key? key,
    required this.blur,
    required this.child,
    required this.opacity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white.withOpacity(opacity),
              borderRadius: const BorderRadius.all(Radius.circular(16.0)),
              border: Border.all(
                width: 1.5,
                color: Colors.white.withOpacity(0.2),
              )),
          child: child,
        ),
      ),
    );
  }
}
