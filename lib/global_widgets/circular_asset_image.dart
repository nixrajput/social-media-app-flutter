import 'package:flutter/material.dart';
import 'package:social_media_app/constants/dimens.dart';

class NxCircleAssetImage extends StatelessWidget {
  const NxCircleAssetImage({
    Key? key,
    required this.imgAsset,
    this.radius,
    this.fit,
    this.bgColor,
  }) : super(key: key);

  final String imgAsset;
  final double? radius;
  final BoxFit? fit;
  final Color? bgColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: radius != null ? radius! * 2 : Dimens.fourtyEight * 2,
      height: radius != null ? radius! * 2 : Dimens.fourtyEight * 2,
      constraints: BoxConstraints(
        maxWidth: radius != null ? radius! * 2 : Dimens.fourtyEight * 2,
        maxHeight: radius != null ? radius! * 2 : Dimens.fourtyEight * 2,
      ),
      decoration: BoxDecoration(
        color: bgColor ?? Theme.of(context).dividerColor,
        borderRadius: BorderRadius.circular(
          radius != null ? radius! * 2 : Dimens.fourtyEight * 2,
        ),
        border: Border.all(
          color: Theme.of(context).dividerColor,
        ),
      ),
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
