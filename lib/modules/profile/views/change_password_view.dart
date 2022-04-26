import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media_app/common/custom_app_bar.dart';
import 'package:social_media_app/common/primary_filled_btn.dart';
import 'package:social_media_app/constants/colors.dart';
import 'package:social_media_app/constants/dimens.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/constants/styles.dart';
import 'package:social_media_app/modules/profile/controllers/change_password_controller.dart';

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
            child: GetBuilder<ChangePasswordController>(
              builder: (logic) => Stack(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const NxAppBar(
                        title: StringValues.changePassword,
                      ),
                      _buildBody(logic),
                    ],
                  ),
                  Positioned(
                    bottom: Dimens.zero,
                    left: Dimens.zero,
                    right: Dimens.zero,
                    child: NxFilledButton(
                      borderRadius: Dimens.zero,
                      onTap: logic.changePassword,
                      label: StringValues.changePassword,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBody(ChangePasswordController logic) => Expanded(
        child: SingleChildScrollView(
          child: Padding(
            padding: Dimens.edgeInsets8,
            child: FocusScope(
              node: logic.focusNode,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Dimens.boxHeight16,
                  TextFormField(
                    obscureText: logic.showPassword,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      hintStyle: const TextStyle(
                        color: ColorValues.grayColor,
                      ),
                      hintText: StringValues.oldPassword,
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
                      color: Theme.of(Get.context!).textTheme.bodyText1!.color,
                    ),
                    controller: logic.oldPasswordTextController,
                    onEditingComplete: logic.focusNode.nextFocus,
                  ),
                  Dimens.boxHeight24,
                  TextFormField(
                    obscureText: logic.showNewPassword,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      hintStyle: const TextStyle(
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
                    style: AppStyles.style16Normal.copyWith(
                      color: Theme.of(Get.context!).textTheme.bodyText1!.color,
                    ),
                    controller: logic.newPasswordTextController,
                    onEditingComplete: logic.focusNode.nextFocus,
                  ),
                  Dimens.boxHeight24,
                  TextFormField(
                    obscureText: logic.showNewPassword,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      hintStyle: const TextStyle(
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
                    style: AppStyles.style16Normal.copyWith(
                      color: Theme.of(Get.context!).textTheme.bodyText1!.color,
                    ),
                    controller: logic.confirmPasswordTextController,
                    onEditingComplete: logic.focusNode.unfocus,
                  ),
                  Dimens.boxHeight16,
                ],
              ),
            ),
          ),
        ),
      );
}
