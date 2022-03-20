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

class RegisterView extends StatelessWidget {
  const RegisterView({Key? key}) : super(key: key);

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
                _buildRegistrationFields(),
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
            maxHeight: Dimens.hundred * 2.0,
          ),
          Padding(
            padding: Dimens.edgeInsets0_16,
            child: Text(
              StringValues.register,
              style: AppStyles.style24Bold,
            ),
          ),
        ],
      );

  Widget _buildRegistrationFields() => GetBuilder<AuthController>(
        builder: (logic) => Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: Dimens.edgeInsets0_16,
              child: FocusScope(
                node: logic.focusNode,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      decoration: const InputDecoration(
                        icon: Icon(
                          CupertinoIcons.person,
                          color: ColorValues.darkGrayColor,
                        ),
                        hintText: StringValues.firstName,
                      ),
                      keyboardType: TextInputType.name,
                      maxLines: 1,
                      style: AppStyles.style16Normal,
                      controller: logic.fNameTextController,
                      onEditingComplete: logic.focusNode.nextFocus,
                    ),
                    Dimens.boxHeight16,
                    TextFormField(
                      decoration: const InputDecoration(
                        icon: Icon(
                          CupertinoIcons.person,
                          color: ColorValues.darkGrayColor,
                        ),
                        hintText: StringValues.lastName,
                      ),
                      keyboardType: TextInputType.name,
                      maxLines: 1,
                      style: AppStyles.style16Normal,
                      controller: logic.lNameTextController,
                      onEditingComplete: logic.focusNode.nextFocus,
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
                      decoration: const InputDecoration(
                        icon: Icon(
                          CupertinoIcons.info,
                          color: ColorValues.darkGrayColor,
                        ),
                        hintText: StringValues.username,
                      ),
                      keyboardType: TextInputType.text,
                      maxLines: 1,
                      style: AppStyles.style16Normal,
                      controller: logic.unameTextController,
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
                        hintText: StringValues.confirmPassword,
                      ),
                      keyboardType: TextInputType.visiblePassword,
                      maxLines: 1,
                      style: AppStyles.style16Normal,
                      controller: logic.confirmPasswordTextController,
                      onEditingComplete: logic.focusNode.unfocus,
                    ),
                    Dimens.boxHeight32,
                    NxFilledButton(
                      onTap: () => logic.register(),
                      label: StringValues.register,
                    ),
                    Dimens.boxHeight32,
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          StringValues.alreadyHaveAccount,
                          style: AppStyles.style16Normal,
                        ),
                        Dimens.boxWidth4,
                        NxTextButton(
                          label: StringValues.login,
                          onTap: () => RouteManagement.goToLoginView(),
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
