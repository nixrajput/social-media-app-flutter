import 'package:flutter/material.dart';

class NxColoredBox extends StatelessWidget {
  const NxColoredBox({
    Key? key,
    this.color,
    this.width,
    this.height,
    this.child,
  }) : super(key: key);

  final Widget? child;
  final Color? color;
  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    final bgColor = Theme.of(context).dividerColor;

    return Container(
      width: width,
      height: height,
      color: color ?? bgColor,
      child: child,
    );
  }
}
