import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app/common/asset_image.dart';
import 'package:social_media_app/common/primary_filled_btn.dart';
import 'package:social_media_app/common/primary_text_btn.dart';
import 'package:social_media_app/constants/colors.dart';
import 'package:social_media_app/constants/dimens.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/constants/styles.dart';
import 'package:social_media_app/routes/route_management.dart';

class LoginView extends StatelessWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        body: SafeArea(
          child: SizedBox(
            width: Dimens.screenWidth,
            height: Dimens.screenHeight,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  NxAssetImage(
                    imgAsset: AssetValues.vector1,
                    maxHeight: Dimens.hundred * 2.4,
                  ),
                  _buildLoginFields(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLoginFields() => Padding(
        padding: Dimens.edgeInsets0_16,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              StringValues.login,
              style: AppStyles.style24Bold,
            ),
            Dimens.boxHeight16,
            TextFormField(
              decoration: const InputDecoration(
                icon: Icon(
                  CupertinoIcons.mail,
                  color: ColorValues.darkGrayColor,
                ),
                hintText: StringValues.email,
              ),
              keyboardType: TextInputType.emailAddress,
              maxLines: 1,
              style: AppStyles.style16Normal,
            ),
            Dimens.boxHeight16,
            TextFormField(
              obscureText: true,
              decoration: const InputDecoration(
                icon: Icon(
                  CupertinoIcons.lock,
                  color: ColorValues.darkGrayColor,
                ),
                hintText: StringValues.password,
              ),
              keyboardType: TextInputType.visiblePassword,
              maxLines: 1,
              style: AppStyles.style16Normal,
            ),
            Dimens.boxHeight32,
            NxTextButton(
              label: StringValues.forgotPassword,
              onTap: () {},
            ),
            Dimens.boxHeight32,
            NxFilledButton(
              onTap: () {
                RouteManagement.goToHomeView();
              },
              label: StringValues.login,
            ),
            Dimens.boxHeight32,
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  StringValues.doNotHaveAccount,
                  style: AppStyles.style16Normal,
                ),
                Dimens.boxWidth4,
                NxTextButton(
                  label: StringValues.register,
                  onTap: () => RouteManagement.goToRegisterView(),
                ),
              ],
            ),
            Dimens.boxHeight32,
          ],
        ),
      );
}
