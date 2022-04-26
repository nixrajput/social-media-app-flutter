import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:social_media_app/common/asset_image.dart';
import 'package:social_media_app/common/primary_filled_btn.dart';
import 'package:social_media_app/common/primary_text_btn.dart';
import 'package:social_media_app/constants/colors.dart';
import 'package:social_media_app/constants/dimens.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/constants/styles.dart';
import 'package:social_media_app/modules/auth/controllers/password_controller.dart';
import 'package:social_media_app/routes/route_management.dart';

class ResetPasswordView extends StatelessWidget {
  const ResetPasswordView({Key? key}) : super(key: key);

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
                _buildResetPasswordFields(),
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
              StringValues.resetPassword,
              style: AppStyles.style24Bold,
            ),
          ),
        ],
      );

  Widget _buildResetPasswordFields() => GetBuilder<PasswordController>(
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
                    TextFormField(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintStyle: TextStyle(
                          color: ColorValues.grayColor,
                        ),
                        hintText: StringValues.otp,
                      ),
                      keyboardType: TextInputType.number,
                      maxLines: 1,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(6),
                      ],
                      style: AppStyles.style16Normal.copyWith(
                        color:
                            Theme.of(Get.context!).textTheme.bodyText1!.color,
                      ),
                      controller: logic.otpTextController,
                      onEditingComplete: logic.focusNode.nextFocus,
                    ),
                    Dimens.boxHeight24,
                    TextFormField(
                      obscureText: logic.showPassword,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        hintStyle: const TextStyle(
                          color: ColorValues.grayColor,
                        ),
                        hintText: StringValues.newPassword,
                        suffixIcon: InkWell(
                          onTap: logic.toggleViewPassword,
                          child: Icon(
                            logic.showPassword
                                ? CupertinoIcons.eye
                                : CupertinoIcons.eye_slash,
                          ),
                        ),
                      ),
                      keyboardType: TextInputType.visiblePassword,
                      maxLines: 1,
                      style: AppStyles.style16Normal.copyWith(
                        color:
                            Theme.of(Get.context!).textTheme.bodyText1!.color,
                      ),
                      controller: logic.passwordTextController,
                      onEditingComplete: logic.focusNode.nextFocus,
                    ),
                    Dimens.boxHeight24,
                    TextFormField(
                      obscureText: logic.showPassword,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        hintStyle: const TextStyle(
                          color: ColorValues.grayColor,
                        ),
                        hintText: StringValues.confirmPassword,
                        suffixIcon: InkWell(
                          onTap: logic.toggleViewPassword,
                          child: Icon(
                            logic.showPassword
                                ? CupertinoIcons.eye
                                : CupertinoIcons.eye_slash,
                          ),
                        ),
                      ),
                      keyboardType: TextInputType.visiblePassword,
                      maxLines: 1,
                      style: AppStyles.style16Normal.copyWith(
                        color:
                            Theme.of(Get.context!).textTheme.bodyText1!.color,
                      ),
                      controller: logic.confirmPasswordTextController,
                      onEditingComplete: logic.focusNode.unfocus,
                    ),
                    Dimens.boxHeight32,
                    NxFilledButton(
                      onTap: () => logic.resetPassword(),
                      label: StringValues.resetPassword,
                      fontSize: Dimens.sixTeen,
                      width: double.infinity,
                    ),
                    Dimens.boxHeight32,
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          StringValues.doNotHaveOtp,
                          style: AppStyles.style16Normal,
                        ),
                        Dimens.boxWidth4,
                        const NxTextButton(
                          label: StringValues.getOtp,
                          onTap: RouteManagement.goToForgotPasswordView,
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
