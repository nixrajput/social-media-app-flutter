import 'package:flutter/material.dart';

class PlaceholderTab extends StatelessWidget {
  const PlaceholderTab({required this.title, super.key});
  final String title;
  @override
  Widget build(BuildContext context) =>
      Center(child: Text(title, style: Theme.of(context).textTheme.titleLarge));
}
