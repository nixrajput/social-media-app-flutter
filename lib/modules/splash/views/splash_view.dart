import 'package:flutter/material.dart';
import 'package:social_media_app/common/asset_image.dart';
import 'package:social_media_app/constants/dimens.dart';
import 'package:social_media_app/constants/strings.dart';

class SplashView extends StatelessWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: Dimens.screenWidth,
          height: Dimens.screenHeight,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              NxAssetImage(
                imgAsset: AssetValues.appLogo,
                width: Dimens.hundred * 1.6,
                height: Dimens.hundred * 1.6,
              ),
              Dimens.boxHeight32,
              const CircularProgressIndicator(),
            ],
          ),
        ),
      ),
    );
  }
}
