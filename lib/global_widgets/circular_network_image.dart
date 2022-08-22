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
  }) : super(key: key);

  final String imageUrl;
  final double? radius;
  final BoxFit? fit;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: ColorValues.grayColor,
      radius: radius ?? Dimens.fourtyEight,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(radius ?? Dimens.fourtyEight),
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
