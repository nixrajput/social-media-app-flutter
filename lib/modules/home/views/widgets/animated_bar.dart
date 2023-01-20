import 'package:flutter/material.dart';
import 'package:social_media_app/constants/colors.dart';
import 'package:social_media_app/constants/dimens.dart';

class AnimatedBar extends StatelessWidget {
  const AnimatedBar({
    Key? key,
    required this.isActive,
  }) : super(key: key);

  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      margin: Dimens.edgeInsetsOnlyBottom2,
      duration: const Duration(milliseconds: 500),
      height: Dimens.four,
      width: isActive ? Dimens.twenty : Dimens.zero,
      decoration: const BoxDecoration(
        color: ColorValues.primaryColor,
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    );
  }
}
