import 'package:flutter/material.dart';
import 'package:social_media_app/constants/dimens.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/app_widgets/custom_app_bar.dart';

class TwoFAView extends StatelessWidget {
  const TwoFAView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: Dimens.screenWidth,
          height: Dimens.screenHeight,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              NxAppBar(
                title: StringValues.twoFaAuth,
                padding: Dimens.edgeInsetsDefault,
              ),
              //_buildBody(),
            ],
          ),
        ),
      ),
    );
  }
}
