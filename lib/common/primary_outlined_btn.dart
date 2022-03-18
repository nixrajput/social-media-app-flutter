import 'package:flutter/material.dart';

class NxOutlinedButton extends StatelessWidget {
  final Color? bgColor;
  final double? borderRadius;
  final String label;
  final Color? labelColor;
  final Widget? prefix;
  final Widget? suffix;
  final VoidCallback onTap;
  final EdgeInsets? padding;
  final double? width;
  final double? height;

  const NxOutlinedButton({
    Key? key,
    this.bgColor,
    this.borderRadius,
    required this.label,
    this.prefix,
    this.suffix,
    this.labelColor,
    required this.onTap,
    this.padding,
    this.width,
    this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? width,
      height: height ?? height,
      child: OutlinedButton(
        onPressed: onTap,
        style: OutlinedButton.styleFrom(
          elevation: 0.0,
          primary: Theme.of(context).scaffoldBackgroundColor,
          padding: padding ?? const EdgeInsets.all(16.0),
          side: BorderSide(color: Theme.of(context).colorScheme.secondary),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(borderRadius ?? 8.0),
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (prefix != null) Container(child: prefix),
            if (prefix != null) const SizedBox(width: 5.0),
            Text(
              label.toUpperCase(),
              style: TextStyle(
                color: labelColor ?? Theme.of(context).colorScheme.secondary,
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            if (suffix != null) const SizedBox(width: 5.0),
            if (suffix != null) Container(child: suffix),
          ],
        ),
      ),
    );
  }
}
