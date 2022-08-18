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
  }) : super(key: key);

  final String imageUrl;
  final double? radius;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: ColorValues.grayColor,
      radius: radius ?? Dimens.fourtyEight,
      foregroundImage: CachedNetworkImageProvider(
        imageUrl,
        errorListener: () => const Icon(
          CupertinoIcons.info,
          color: ColorValues.errorColor,
        ),
      ),
      onForegroundImageError: (obj, stc) => const Icon(
        CupertinoIcons.info,
        color: ColorValues.errorColor,
      ),
    );
  }
}
