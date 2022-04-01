import 'package:flutter/material.dart';
import 'package:social_media_app/common/asset_image.dart';
import 'package:social_media_app/constants/dimens.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/constants/styles.dart';

class ErrorView extends StatelessWidget {
  const ErrorView({Key? key}) : super(key: key);

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
                imgAsset: AssetValues.error,
                width: Dimens.hundred * 2,
                height: Dimens.hundred * 2,
              ),
              Dimens.boxHeight8,
              Text(
                StringValues.errorOccurred,
                style: AppStyles.style16Normal.copyWith(
                  color: Theme.of(context).textTheme.subtitle1!.color,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
