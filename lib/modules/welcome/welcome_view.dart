import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:social_media_app/constants/assets.dart';
import 'package:social_media_app/constants/colors.dart';
import 'package:social_media_app/constants/dimens.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/constants/styles.dart';
import 'package:social_media_app/global_widgets/app_filled_btn.dart';
import 'package:social_media_app/global_widgets/asset_image.dart';
import 'package:social_media_app/global_widgets/bottom_oval_clipper.dart';
import 'package:social_media_app/routes/route_management.dart';

class WelcomeView extends StatelessWidget {
  const WelcomeView({Key? key}) : super(key: key);

  Widget _buildBodyPart1(BuildContext context) {
    return ClipPath(
      clipper: BottomOvalClipper(),
      child: Container(
        width: Dimens.screenWidth,
        height: (Dimens.screenHeight * 0.6) - Dimens.twelve,
        child: NxAssetImage(
          imgAsset: AssetValues.group,
          width: Dimens.screenWidth,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildBodyPart2(BuildContext context) {
    return SizedBox(
      width: Dimens.screenWidth,
      height: (Dimens.screenHeight * 0.4) - Dimens.twelve,
      child: Padding(
        padding: Dimens.edgeInsetsHorizDefault,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                Dimens.boxHeight12,
                Text(
                  StringValues.connectWithTheWorld,
                  style: AppStyles.style40Bold.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
                Dimens.boxHeight8,
                Text(
                  StringValues.getStartedDesc,
                  style: AppStyles.p,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            Dimens.boxHeight12,
            NxFilledButton(
              width: Dimens.screenWidth,
              label: StringValues.getStarted,
              onTap: RouteManagement.goToLoginView,
              margin: Dimens.edgeInsetsOnlyBottom12,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
          statusBarColor: ColorValues.transparent,
        ),
        child: SizedBox(
          width: Dimens.screenWidth,
          height: Dimens.screenHeight,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildBodyPart1(context),
              _buildBodyPart2(context),
            ],
          ),
        ),
      ),
    );
  }
}
