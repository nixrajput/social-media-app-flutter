import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:social_media_app/constants/assets.dart';
import 'package:social_media_app/constants/dimens.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/constants/styles.dart';
import 'package:social_media_app/extensions/string_extensions.dart';
import 'package:social_media_app/global_widgets/primary_filled_btn.dart';
import 'package:social_media_app/global_widgets/primary_outlined_btn.dart';
import 'package:social_media_app/routes/route_management.dart';

class WelcomeView extends StatelessWidget {
  const WelcomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _buildAnimation(),
          _buildBackgroundBlur(),
          _buildBody(context)
        ],
      ),
    );
  }

  RiveAnimation _buildAnimation() {
    return const RiveAnimation.asset(
      RiveAssets.cube,
      alignment: Alignment.center,
    );
  }

  Positioned _buildBackgroundBlur() {
    return Positioned.fill(
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: Dimens.six,
          sigmaY: Dimens.six,
        ),
        child: const SizedBox(),
      ),
    );
  }

  Positioned _buildBody(BuildContext context) {
    return Positioned.fill(
      child: SafeArea(
        child: Padding(
          padding: Dimens.edgeInsetsHorizDefault,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              Dimens.boxHeight24,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "${StringValues.welcome} ${StringValues.to}"
                          .toTitleCase(),
                      textAlign: TextAlign.center,
                      style: AppStyles.style13Bold.copyWith(
                        fontSize: Dimens.fiftySix,
                        fontFamily: 'Muge',
                        letterSpacing: Dimens.four,
                      ),
                    ),
                    Text(
                      StringValues.appName.toUpperCase(),
                      style: AppStyles.style24Bold.copyWith(
                        fontFamily: "Muge",
                        fontSize: Dimens.fiftySix,
                        letterSpacing: Dimens.four,
                      ),
                    ),
                  ],
                ),
              ),
              Dimens.boxHeight24,
              const Spacer(),
              Dimens.boxHeight24,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    NxFilledButton(
                      label: StringValues.login.toUpperCase(),
                      onTap: RouteManagement.goToLoginView,
                      height: Dimens.fiftySix,
                    ),
                    Dimens.boxHeight12,
                    NxOutlinedButton(
                      label: StringValues.register.toUpperCase(),
                      onTap: RouteManagement.goToRegisterView,
                      height: Dimens.fiftySix,
                    ),
                  ],
                ),
              ),
              Dimens.boxHeight24,
            ],
          ),
        ),
      ),
    );
  }
}
