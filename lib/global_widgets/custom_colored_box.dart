import 'package:flutter/material.dart';

class NxColoredBox extends StatelessWidget {
  const NxColoredBox({
    super.key,
    this.color,
    this.width,
    this.height,
  });

  final Color? color;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    final bgColor = Theme.of(context).iconTheme.color;

    return Container(
      width: width,
      height: height,
      color: color ?? bgColor,
    );
  }
}
