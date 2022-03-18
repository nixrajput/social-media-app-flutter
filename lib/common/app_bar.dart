import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NxAppBar extends StatelessWidget {
  final Widget leading;
  final Widget? action;
  final Color? bgColor;
  final EdgeInsets? padding;

  const NxAppBar({
    Key? key,
    this.action,
    required this.leading,
    this.bgColor,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      color: bgColor ?? bgColor,
      padding: padding ?? const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          leading,
          if (action != null) SizedBox(child: action),
        ],
      ),
    );
  }
}
