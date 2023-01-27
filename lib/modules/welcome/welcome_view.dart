import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
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
      body: SizedBox(
        width: Dimens.screenWidth,
        height: Dimens.screenHeight,
        child: Stack(
          children: [
            _buildAnimation(),
            _buildBackgroundBlur(),
            _buildBody(context)
          ],
        ),
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
          sigmaX: Dimens.twelve,
          sigmaY: Dimens.twelve,
        ),
        child: const SizedBox(),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: Dimens.edgeInsetsHorizDefault,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Dimens.heightedBox(Dimens.screenWidth * Dimens.pointTwo),
            Expanded(
              child: SizedBox(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      StringValues.hiThere.toTitleCase(),
                      style: AppStyles.style40Bold,
                    ).animate().slide(
                          duration: 500.ms,
                          delay: 800.ms,
                        ),
                    Dimens.boxHeight4,
                    Text(
                      "${StringValues.welcome} ${StringValues.to}"
                          .toTitleCase(),
                      style: AppStyles.style40Bold,
                    ).animate().slide(
                          duration: 500.ms,
                          delay: 300.ms,
                        ),
                    Dimens.boxHeight16,
                    Text(
                      StringValues.appName.toUpperCase(),
                      style: AppStyles.style24Bold.copyWith(
                        fontFamily: AppStyles.mugeFontFamily,
                        fontSize: Dimens.fiftySix,
                        fontWeight: FontWeight.w900,
                        letterSpacing: Dimens.four,
                      ),
                    ).animate().shake(
                          duration: 500.ms,
                          delay: 1300.ms,
                        ),
                    Dimens.boxHeight16,
                    Text(
                      StringValues.appDescription,
                      style: AppStyles.style20Bold,
                    ),
                    Dimens.boxHeight8,
                    Text(
                      StringValues.welcomeDescription,
                      style: AppStyles.style16Normal,
                    ),
                  ],
                ),
              ),
            ),
            Dimens.boxHeight12,
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
            Dimens.boxHeight12,
          ],
        ),
      ),
    );
  }
}
