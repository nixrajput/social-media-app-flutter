import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:social_media_app/apis/models/entities/media_file.dart';
import 'package:social_media_app/constants/assets.dart';
import 'package:social_media_app/constants/dimens.dart';
import 'package:social_media_app/global_widgets/circular_network_image.dart';

class AvatarWidget extends StatelessWidget {
  const AvatarWidget({
    Key? key,
    required this.avatar,
    this.size,
    this.fit,
  }) : super(key: key);

  final MediaFile? avatar;
  final double? size;
  final BoxFit? fit;

  @override
  Widget build(BuildContext context) {
    if (avatar != null && avatar!.url != null) {
      return NxCircleNetworkImage(
        imageUrl: avatar!.url!,
        radius: size ?? Dimens.eighty,
        fit: fit,
      );
    }
    return CircleAvatar(
      backgroundColor: Theme.of(context).textTheme.subtitle2!.color,
      radius: size,
      child: SvgPicture.asset(
        SvgAssets.maleAvatar,
        fit: fit ?? BoxFit.cover,
        semanticsLabel: 'User Avatar',
      ),
    );
  }
}
