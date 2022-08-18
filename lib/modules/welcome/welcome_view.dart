import 'package:flutter/material.dart';
import 'package:social_media_app/constants/assets.dart';
import 'package:social_media_app/constants/dimens.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/constants/styles.dart';
import 'package:social_media_app/extensions/string_extensions.dart';
import 'package:social_media_app/global_widgets/asset_image.dart';
import 'package:social_media_app/global_widgets/primary_filled_btn.dart';
import 'package:social_media_app/global_widgets/primary_outlined_btn.dart';
import 'package:social_media_app/modules/welcome/widgets/welcome_shape_painter.dart';
import 'package:social_media_app/routes/route_management.dart';

class WelcomeView extends StatelessWidget {
  const WelcomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            CustomPaint(
              size: Size(Dimens.screenWidth, Dimens.screenHeight),
              painter: WelcomeShapePainter(),
            ),
            SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: Dimens.edgeInsets16,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Dimens.boxHeight60,
                    Text(
                      "${StringValues.welcome} ${StringValues.to}"
                          .toTitleCase(),
                      textAlign: TextAlign.center,
                      style: AppStyles.style20Normal,
                    ),
                    Dimens.boxHeight8,
                    Text(
                      StringValues.appName,
                      textAlign: TextAlign.center,
                      style: AppStyles.style40Bold.copyWith(
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    Dimens.boxHeight48,
                    NxAssetImage(
                      imgAsset: AssetValues.welcome,
                      fit: BoxFit.cover,
                      width: Dimens.screenWidth,
                    ),
                    Dimens.boxHeight48,
                    const NxFilledButton(
                      label: StringValues.login,
                      onTap: RouteManagement.goToLoginView,
                    ),
                    Dimens.boxHeight20,
                    const NxOutlinedButton(
                      label: StringValues.register,
                      onTap: RouteManagement.goToRegisterView,
                    ),
                    Dimens.boxHeight60,
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
