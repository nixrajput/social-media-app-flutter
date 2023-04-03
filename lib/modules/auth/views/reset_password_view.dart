import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:social_media_app/constants/dimens.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/constants/styles.dart';
import 'package:social_media_app/app_widgets/app_filled_btn.dart';
import 'package:social_media_app/app_widgets/custom_app_bar.dart';
import 'package:social_media_app/app_widgets/app_text_btn.dart';
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
                  padding: Dimens.edgeInsetsDefault,
                ),
                _buildResetPasswordFields(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildResetPasswordFields(BuildContext context) =>
      GetBuilder<PasswordController>(
        builder: (logic) => Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: Dimens.edgeInsetsHorizDefault,
              child: FocusScope(
                node: logic.focusNode,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Dimens.boxHeight32,
                    Text(
                      StringValues.resetPasswordWelcome,
                      style: AppStyles.style32Bold.copyWith(
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    Dimens.boxHeight32,
                    Text(
                      StringValues.enterOtpPassword,
                      style: AppStyles.style12Normal,
                    ),
                    Dimens.boxHeight12,
                    TextFormField(
                      decoration: const InputDecoration(
                        hintText: StringValues.otp,
                      ),
                      keyboardType: TextInputType.number,
                      maxLines: 1,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(6),
                      ],
                      style: AppStyles.style14Normal.copyWith(
                        color: Theme.of(context).textTheme.bodyLarge!.color,
                      ),
                      controller: logic.otpTextController,
                      onEditingComplete: logic.focusNode.nextFocus,
                    ),
                    Dimens.boxHeight12,
                    TextFormField(
                      obscureText: logic.showPassword,
                      decoration: InputDecoration(
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
                        color: Theme.of(context).textTheme.bodyLarge!.color,
                      ),
                      controller: logic.passwordTextController,
                      onEditingComplete: logic.focusNode.nextFocus,
                    ),
                    Dimens.boxHeight12,
                    TextFormField(
                      obscureText: logic.showPassword,
                      decoration: InputDecoration(
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
                        color: Theme.of(context).textTheme.bodyLarge!.color,
                      ),
                      controller: logic.confirmPasswordTextController,
                      onEditingComplete: logic.focusNode.unfocus,
                    ),
                    Dimens.heightedBox(Dimens.twentyEight),
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
                      label: StringValues.resetPassword.toUpperCase(),
                      height: Dimens.fiftySix,
                    ),
                    Dimens.boxHeight32,
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
                    Dimens.boxHeight16,
                  ],
                ),
              ),
            ),
          ),
        ),
      );
}
