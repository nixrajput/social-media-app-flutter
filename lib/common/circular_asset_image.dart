import 'package:flutter/material.dart';
import 'package:social_media_app/constants/colors.dart';
import 'package:social_media_app/constants/dimens.dart';

class NxCircleAssetImage extends StatelessWidget {
  const NxCircleAssetImage({
    Key? key,
    required this.imgAsset,
    this.radius,
  }) : super(key: key);

  final String imgAsset;
  final double? radius;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: ColorValues.grayColor,
      radius: radius ?? Dimens.fourtyEight,
      foregroundImage: AssetImage(
        imgAsset,
      ),
    );
  }
}
