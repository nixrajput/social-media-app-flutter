import 'package:flutter/material.dart';

class UnFocusWidget extends StatelessWidget {
  const UnFocusWidget({super.key, required this.child, this.opaque});

  final Widget child;
  final bool? opaque;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior:
          opaque == true ? HitTestBehavior.opaque : HitTestBehavior.translucent,
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: child,
    );
  }
}
