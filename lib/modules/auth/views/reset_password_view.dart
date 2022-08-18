import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:social_media_app/constants/colors.dart';
import 'package:social_media_app/constants/dimens.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/constants/styles.dart';
import 'package:social_media_app/global_widgets/custom_app_bar.dart';
import 'package:social_media_app/global_widgets/primary_filled_btn.dart';
import 'package:social_media_app/global_widgets/primary_text_btn.dart';
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
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                NxAppBar(
                  title: StringValues.resetPassword,
                  padding: Dimens.edgeInsets8_16,
                ),
                _buildResetPasswordFields(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildResetPasswordFields() => GetBuilder<PasswordController>(
        builder: (logic) => Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: Dimens.edgeInsets0_16,
              child: FocusScope(
                node: logic.focusNode,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Dimens.boxHeight32,
                    Text(
                      StringValues.resetYourPassword,
                      style: AppStyles.style28Bold.copyWith(
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    Dimens.boxHeight4,
                    Text(
                      StringValues.enterOtpYouGet,
                      style: AppStyles.style12Normal,
                    ),
                    Dimens.boxHeight32,
                    Container(
                      height: Dimens.fiftySix,
                      constraints: BoxConstraints(maxWidth: Dimens.screenWidth),
                      child: TextFormField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(Dimens.eight),
                          ),
                          hintStyle: AppStyles.style14Normal.copyWith(
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
                        style: AppStyles.style14Normal.copyWith(
                          color:
                              Theme.of(Get.context!).textTheme.bodyText1!.color,
                        ),
                        controller: logic.otpTextController,
                        onEditingComplete: logic.focusNode.nextFocus,
                      ),
                    ),
                    Dimens.boxHeight16,
                    Container(
                      height: Dimens.fiftySix,
                      constraints: BoxConstraints(maxWidth: Dimens.screenWidth),
                      child: TextFormField(
                        obscureText: logic.showPassword,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(Dimens.eight),
                          ),
                          hintStyle: AppStyles.style14Normal.copyWith(
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
                        style: AppStyles.style14Normal.copyWith(
                          color:
                              Theme.of(Get.context!).textTheme.bodyText1!.color,
                        ),
                        controller: logic.passwordTextController,
                        onEditingComplete: logic.focusNode.nextFocus,
                      ),
                    ),
                    Dimens.boxHeight16,
                    Container(
                      height: Dimens.fiftySix,
                      constraints: BoxConstraints(maxWidth: Dimens.screenWidth),
                      child: TextFormField(
                        obscureText: logic.showPassword,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(Dimens.eight),
                          ),
                          hintStyle: AppStyles.style14Normal.copyWith(
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
                        style: AppStyles.style14Normal.copyWith(
                          color:
                              Theme.of(Get.context!).textTheme.bodyText1!.color,
                        ),
                        controller: logic.confirmPasswordTextController,
                        onEditingComplete: logic.focusNode.unfocus,
                      ),
                    ),
                    Dimens.boxHeight32,
                    NxTextButton(
                      label: StringValues.loginToAccount,
                      onTap: () {
                        RouteManagement.goToBack();
                        RouteManagement.goToLoginView();
                      },
                    ),
                    Dimens.boxHeight32,
                    NxFilledButton(
                      onTap: () => logic.resetPassword(),
                      label: StringValues.resetPassword,
                    ),
                    Dimens.boxHeight48,
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          StringValues.doNotHaveOtp,
                          style: AppStyles.style14Normal,
                        ),
                        Dimens.boxWidth4,
                        NxTextButton(
                          label: StringValues.getOtp,
                          onTap: () {
                            RouteManagement.goToBack();
                            RouteManagement.goToForgotPasswordView();
                          },
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
