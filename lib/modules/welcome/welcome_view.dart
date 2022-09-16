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
import 'package:social_media_app/utils/utility.dart';

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
                padding: Dimens.edgeInsets0_16,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Dimens.boxHeight48,
                    Text(
                      "${StringValues.welcome} ${StringValues.to}"
                          .toTitleCase(),
                      textAlign: TextAlign.center,
                      style: AppStyles.style20Normal,
                    ),
                    Dimens.boxHeight8,
                    Center(
                      child: AppUtility.buildAppLogo(fontSize: Dimens.fourty),
                    ),
                    Dimens.boxHeight24,
                    ConstrainedBox(
                      constraints: BoxConstraints(
                        maxWidth: Dimens.screenWidth,
                        maxHeight: Dimens.screenHeight,
                      ),
                      child: NxAssetImage(
                        imgAsset: AssetValues.welcome,
                        height: Dimens.screenWidth,
                        fit: BoxFit.contain,
                      ),
                    ),
                    Dimens.boxHeight24,
                    NxFilledButton(
                      label: StringValues.login.toUpperCase(),
                      onTap: RouteManagement.goToLoginView,
                    ),
                    Dimens.boxHeight16,
                    NxOutlinedButton(
                      label: StringValues.register.toUpperCase(),
                      onTap: RouteManagement.goToRegisterView,
                      height: Dimens.fiftySix,
                    ),
                    Dimens.boxHeight48,
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
