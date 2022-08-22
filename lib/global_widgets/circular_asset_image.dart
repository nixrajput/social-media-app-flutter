import 'package:flutter/material.dart';
import 'package:social_media_app/constants/colors.dart';
import 'package:social_media_app/constants/dimens.dart';

class NxCircleAssetImage extends StatelessWidget {
  const NxCircleAssetImage({
    Key? key,
    required this.imgAsset,
    this.radius,
    this.fit,
  }) : super(key: key);

  final String imgAsset;
  final double? radius;
  final BoxFit? fit;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: ColorValues.grayColor,
      radius: radius ?? Dimens.fourtyEight,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(radius ?? Dimens.fourtyEight),
        child: Image.asset(
          imgAsset,
          fit: fit ?? BoxFit.cover,
        ),
      ),
    );
  }
}
