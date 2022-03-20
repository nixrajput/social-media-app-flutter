import 'package:flutter/material.dart';
import 'package:social_media_app/constants/dimens.dart';

class NxSliverAppBar extends StatelessWidget {
  const NxSliverAppBar({
    Key? key,
    required this.leading,
    this.bgColor,
    required this.title,
    this.actions,
    this.isFloating,
    this.isPinned,
    this.centerTitle,
  }) : super(key: key);

  final Widget? leading;
  final Widget title;
  final bool? centerTitle;
  final Widget? actions;
  final Color? bgColor;
  final bool? isFloating;
  final bool? isPinned;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      floating: isFloating ?? true,
      pinned: isPinned ?? false,
      backgroundColor: bgColor ?? Colors.transparent,
      flexibleSpace: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: Dimens.edgeInsets8,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                leading!,
                title,
                actions!,
              ],
            ),
          ),
          Divider(
            height: Dimens.zero,
            thickness: 0.3,
          ),
        ],
      ),
    );
  }
}
