import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:social_media_app/constants/colors.dart';
import 'package:social_media_app/constants/dimens.dart';

class NxFileImage extends StatelessWidget {
  const NxFileImage({
    Key? key,
    required this.file,
    this.width,
    this.height,
    this.maxWidth,
    this.maxHeight,
    this.scale,
  }) : super(key: key);

  final File file;
  final double? width;
  final double? height;
  final double? maxWidth;
  final double? maxHeight;
  final double? scale;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? double.infinity,
      height: height,
      constraints: BoxConstraints(
        maxWidth: maxWidth ?? Dimens.screenWidth,
        maxHeight: maxHeight ?? Dimens.screenHeight,
      ),
      child: Image.file(
        file,
        fit: BoxFit.cover,
        errorBuilder: (ctx, url, err) => const Icon(
          CupertinoIcons.info,
          color: ColorValues.errorColor,
        ),
        width: width,
        height: height,
        scale: scale ?? 1.0,
      ),
    );
  }
}
