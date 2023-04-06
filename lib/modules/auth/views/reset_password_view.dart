import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:social_media_app/app_widgets/app_filled_btn.dart';
import 'package:social_media_app/app_widgets/app_text_btn.dart';
import 'package:social_media_app/app_widgets/custom_app_bar.dart';
import 'package:social_media_app/app_widgets/unfocus_widget.dart';
import 'package:social_media_app/constants/dimens.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/constants/styles.dart';
import 'package:social_media_app/modules/auth/controllers/password_controller.dart';
import 'package:social_media_app/routes/route_management.dart';

class ResetPasswordView extends StatelessWidget {
  const ResetPasswordView({Key? key}) : super(key: key);

  Widget _buildBody(BuildContext context) => GetBuilder<PasswordController>(
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
                      StringValues.resetPassword,
                      style: AppStyles.h2,
                      textAlign: TextAlign.center,
                    ),
                    Dimens.boxHeight8,
                    Text(
                      StringValues.resetPasswordHelp,
                      style: AppStyles.p,
                      textAlign: TextAlign.center,
                    ),
                    Dimens.boxHeight32,
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

  @override
  Widget build(BuildContext context) {
    return UnFocusWidget(
      child: Scaffold(
        body: SafeArea(
          child: SizedBox(
            width: Dimens.screenWidth,
            height: Dimens.screenHeight,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const NxAppBar(),
                _buildBody(context),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
