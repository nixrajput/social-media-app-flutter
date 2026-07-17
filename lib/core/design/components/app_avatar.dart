import 'package:flutter/material.dart';
import '../app_colors.dart';

class AppAvatar extends StatelessWidget {
  const AppAvatar({this.url, this.radius = 20, super.key});

  final String? url;
  final double radius;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColors>()!;
    return CircleAvatar(
      radius: radius,
      backgroundColor: colors.surfaceMuted,
      backgroundImage: (url != null && url!.isNotEmpty)
          ? NetworkImage(url!)
          : null,
      child: (url == null || url!.isEmpty)
          ? Icon(Icons.person, size: radius, color: colors.textSecondary)
          : null,
    );
  }
}
