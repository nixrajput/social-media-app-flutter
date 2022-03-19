import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media_app/common/asset_image.dart';
import 'package:social_media_app/common/primary_filled_btn.dart';
import 'package:social_media_app/common/primary_text_btn.dart';
import 'package:social_media_app/constants/colors.dart';
import 'package:social_media_app/constants/dimens.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/constants/styles.dart';
import 'package:social_media_app/modules/auth/controllers/auth_controller.dart';
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildImageHeader(),
                Dimens.boxHeight16,
                _buildLoginFields(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildImageHeader() => Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          NxAssetImage(
            imgAsset: AssetValues.vector1,
            maxHeight: Dimens.hundred * 2.4,
          ),
          Padding(
            padding: Dimens.edgeInsets0_16,
            child: Text(
              StringValues.login,
              style: AppStyles.style24Bold,
            ),
          ),
        ],
      );

  Widget _buildLoginFields() => GetBuilder<AuthController>(
        builder: (logic) => Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: Dimens.edgeInsets0_16,
              child: FocusScope(
                node: logic.focusNode,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (logic.isLoading)
                      const Center(
                        child: CupertinoActivityIndicator(),
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
                      controller: logic.emailTextController,
                      onEditingComplete: logic.focusNode.nextFocus,
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
                      controller: logic.passwordTextController,
                      onEditingComplete: logic.focusNode.unfocus,
                    ),
                    Dimens.boxHeight32,
                    NxTextButton(
                      label: StringValues.forgotPassword,
                      onTap: () {},
                    ),
                    Dimens.boxHeight32,
                    NxFilledButton(
                      onTap: () => logic.login(),
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
              ),
            ),
          ),
        ),
      );
}
