import 'package:flutter/material.dart';
import 'package:social_media_app/constants/dimens.dart';

class NxSliverAppBar extends StatelessWidget {
  const NxSliverAppBar({
    Key? key,
    required this.leading,
    this.bgColor,
    this.title,
    this.actions,
    this.isFloating,
    this.isPinned,
    this.centerTitle,
    this.height,
  }) : super(key: key);

  final Widget leading;
  final Widget? title;
  final bool? centerTitle;
  final Widget? actions;
  final Color? bgColor;
  final bool? isFloating;
  final bool? isPinned;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      floating: isFloating ?? true,
      pinned: isPinned ?? false,
      toolbarHeight: height ?? Dimens.fourty,
      elevation: Dimens.zero,
      backgroundColor: bgColor ?? Theme.of(context).scaffoldBackgroundColor,
      flexibleSpace: Padding(
        padding: Dimens.edgeInsets8_16,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            leading,
            if (title != null) title!,
            if (actions != null) actions!,
          ],
        ),
      ),
    );
  }
}
