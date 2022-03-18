import 'package:flutter/material.dart';

class NxElevatedCard extends StatelessWidget {
  final Widget child;
  final double? borderRadius;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final double? elevation;
  final double? width;
  final double? height;

  const NxElevatedCard({
    Key? key,
    required this.child,
    this.borderRadius,
    this.padding,
    this.margin,
    this.elevation,
    this.width,
    this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? double.infinity,
      height: height ?? height,
      margin: margin ?? const EdgeInsets.all(0.0),
      padding: padding ?? const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Theme.of(context).bottomAppBarColor,
        borderRadius: BorderRadius.all(Radius.circular(borderRadius ?? 8.0)),
        boxShadow: [
          BoxShadow(
            offset: Offset(0.0, elevation ?? 4.0),
            color: Theme.of(context).shadowColor,
            blurRadius: 16.0,
          )
        ],
      ),
      child: child,
    );
  }
}
