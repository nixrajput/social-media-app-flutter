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
        child: SizedBox(
          width: Dimens.screenWidth,
          height: Dimens.screenHeight,
          child: Stack(
            fit: StackFit.expand,
            children: [
              CustomPaint(
                size: Size(Dimens.screenWidth, Dimens.screenHeight),
                painter: WelcomeShapePainter(),
              ),
              Positioned.fill(
                child: Padding(
                  padding: Dimens.edgeInsetsHorizDefault,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Dimens.boxHeight48,
                      Expanded(
                        flex: 0,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "${StringValues.welcome} ${StringValues.to}"
                                  .toTitleCase(),
                              textAlign: TextAlign.center,
                              style: AppStyles.style20Normal,
                            ),
                            Dimens.boxHeight8,
                            AppUtility.buildAppLogo(
                              context,
                              fontSize: Dimens.fourty,
                              isCentered: true,
                            ),
                          ],
                        ),
                      ),
                      Dimens.boxHeight32,
                      const Expanded(
                        child: NxAssetImage(
                          imgAsset: AssetValues.welcome,
                          fit: BoxFit.contain,
                          scale: 1.0,
                        ),
                      ),
                      Dimens.boxHeight48,
                      Expanded(
                        flex: 0,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
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
                          ],
                        ),
                      ),
                      Dimens.boxHeight48,
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
