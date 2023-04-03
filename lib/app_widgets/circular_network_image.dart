import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app/constants/colors.dart';
import 'package:social_media_app/constants/dimens.dart';

class NxCircleNetworkImage extends StatelessWidget {
  const NxCircleNetworkImage({
    Key? key,
    required this.imageUrl,
    this.radius,
    this.fit,
    this.bgColor,
    this.borderColor,
    this.borderWidth,
  }) : super(key: key);

  final String imageUrl;
  final double? radius;
  final BoxFit? fit;
  final Color? bgColor;
  final Color? borderColor;
  final double? borderWidth;

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
          color: borderColor ?? Theme.of(context).dividerColor,
          width: borderWidth ?? Dimens.one,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(
          radius != null ? radius! * 2 : Dimens.fourtyEight * 2,
        ),
        child: CachedNetworkImage(
          imageUrl: imageUrl,
          fit: fit ?? BoxFit.cover,
          progressIndicatorBuilder: (ctx, _, progress) =>
              CircularProgressIndicator(
            value: progress.progress,
          ),
          errorWidget: (ctx, _, child) => const Icon(
            CupertinoIcons.info,
            color: ColorValues.errorColor,
          ),
        ),
      ),
    );
  }
}
