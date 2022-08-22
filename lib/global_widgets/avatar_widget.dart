import 'package:flutter/material.dart';
import 'package:social_media_app/apis/models/entities/user_avatar.dart';
import 'package:social_media_app/constants/assets.dart';
import 'package:social_media_app/constants/dimens.dart';
import 'package:social_media_app/global_widgets/circular_asset_image.dart';
import 'package:social_media_app/global_widgets/circular_network_image.dart';

class AvatarWidget extends StatelessWidget {
  const AvatarWidget({
    Key? key,
    required this.avatar,
    this.size,
    this.fit,
  }) : super(key: key);

  final UserAvatar? avatar;
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
    return NxCircleAssetImage(
      imgAsset: AssetValues.avatar,
      radius: size ?? Dimens.eighty,
      fit: fit,
    );
  }
}
