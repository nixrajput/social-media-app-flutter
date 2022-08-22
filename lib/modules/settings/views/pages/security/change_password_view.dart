import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media_app/constants/colors.dart';
import 'package:social_media_app/constants/dimens.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/constants/styles.dart';
import 'package:social_media_app/global_widgets/custom_app_bar.dart';
import 'package:social_media_app/global_widgets/primary_filled_btn.dart';
import 'package:social_media_app/modules/settings/controllers/change_password_controller.dart';

class ChangePasswordView extends StatelessWidget {
  const ChangePasswordView({Key? key}) : super(key: key);

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
                NxAppBar(
                  title: StringValues.changePassword,
                  padding: Dimens.edgeInsets8_16,
                ),
                Dimens.boxHeight24,
                _buildBody(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBody() => GetBuilder<ChangePasswordController>(
        builder: (logic) {
          return Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: Dimens.edgeInsets0_16,
                child: FocusScope(
                  node: logic.focusNode,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        height: Dimens.fiftySix,
                        constraints:
                            BoxConstraints(maxWidth: Dimens.screenWidth),
                        child: TextFormField(
                          obscureText: logic.showPassword,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(Dimens.eight),
                            ),
                            hintStyle: AppStyles.style14Normal.copyWith(
                              color: ColorValues.grayColor,
                            ),
                            hintText: StringValues.currentPassword,
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
                          style: AppStyles.style14Normal.copyWith(
                            color: Theme.of(Get.context!)
                                .textTheme
                                .bodyText1!
                                .color,
                          ),
                          controller: logic.oldPasswordTextController,
                          onEditingComplete: logic.focusNode.nextFocus,
                        ),
                      ),
                      Dimens.boxHeight16,
                      Container(
                        height: Dimens.fiftySix,
                        constraints:
                            BoxConstraints(maxWidth: Dimens.screenWidth),
                        child: TextFormField(
                          obscureText: logic.showNewPassword,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(Dimens.eight),
                            ),
                            hintStyle: AppStyles.style14Normal.copyWith(
                              color: ColorValues.grayColor,
                            ),
                            hintText: StringValues.newPassword,
                            suffixIcon: InkWell(
                              onTap: logic.toggleViewNewPassword,
                              child: Icon(
                                logic.showNewPassword
                                    ? CupertinoIcons.eye
                                    : CupertinoIcons.eye_slash,
                              ),
                            ),
                          ),
                          keyboardType: TextInputType.visiblePassword,
                          maxLines: 1,
                          style: AppStyles.style14Normal.copyWith(
                            color: Theme.of(Get.context!)
                                .textTheme
                                .bodyText1!
                                .color,
                          ),
                          controller: logic.newPasswordTextController,
                          onEditingComplete: logic.focusNode.nextFocus,
                        ),
                      ),
                      Dimens.boxHeight16,
                      Container(
                        height: Dimens.fiftySix,
                        constraints:
                            BoxConstraints(maxWidth: Dimens.screenWidth),
                        child: TextFormField(
                          obscureText: logic.showNewPassword,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(Dimens.eight),
                            ),
                            hintStyle: AppStyles.style14Normal.copyWith(
                              color: ColorValues.grayColor,
                            ),
                            hintText: StringValues.confirmPassword,
                            suffixIcon: InkWell(
                              onTap: logic.toggleViewNewPassword,
                              child: Icon(
                                logic.showNewPassword
                                    ? CupertinoIcons.eye
                                    : CupertinoIcons.eye_slash,
                              ),
                            ),
                          ),
                          keyboardType: TextInputType.visiblePassword,
                          maxLines: 1,
                          style: AppStyles.style14Normal.copyWith(
                            color: Theme.of(Get.context!)
                                .textTheme
                                .bodyText1!
                                .color,
                          ),
                          controller: logic.confirmPasswordTextController,
                          onEditingComplete: logic.focusNode.unfocus,
                        ),
                      ),
                      Dimens.boxHeight40,
                      NxFilledButton(
                        onTap: logic.changePassword,
                        label: StringValues.changePassword.toUpperCase(),
                      ),
                      Dimens.boxHeight32,
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.check_circle,
                            size: Dimens.fourteen,
                          ),
                          Dimens.boxWidth8,
                          RichText(
                            text: TextSpan(
                              text: "At least 8 characters.",
                              style: AppStyles.style12Normal.copyWith(
                                color: Theme.of(Get.context!)
                                    .textTheme
                                    .bodyText1!
                                    .color,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Dimens.boxHeight8,
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.check_circle,
                            size: Dimens.fourteen,
                          ),
                          Dimens.boxWidth8,
                          RichText(
                            text: TextSpan(
                              text: "At least contains 1 uppercase character.",
                              style: AppStyles.style12Normal.copyWith(
                                color: Theme.of(Get.context!)
                                    .textTheme
                                    .bodyText1!
                                    .color,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Dimens.boxHeight8,
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.check_circle,
                            size: Dimens.fourteen,
                          ),
                          Dimens.boxWidth8,
                          RichText(
                            text: TextSpan(
                              text: "At least contains 1 numeric character.",
                              style: AppStyles.style12Normal.copyWith(
                                color: Theme.of(Get.context!)
                                    .textTheme
                                    .bodyText1!
                                    .color,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Dimens.boxHeight8,
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.check_circle,
                            size: Dimens.fourteen,
                          ),
                          Dimens.boxWidth8,
                          RichText(
                            text: TextSpan(
                              text:
                                  "At least contains 1 special character (~@#\$%^&*_-=+).",
                              style: AppStyles.style12Normal.copyWith(
                                color: Theme.of(Get.context!)
                                    .textTheme
                                    .bodyText1!
                                    .color,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Dimens.boxHeight16,
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      );
}
