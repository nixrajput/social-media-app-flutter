import 'package:flutter/material.dart';
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

class ForgotPasswordView extends StatelessWidget {
  const ForgotPasswordView({Key? key}) : super(key: key);

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
                      StringValues.forgotPassword,
                      style: AppStyles.h2,
                      textAlign: TextAlign.center,
                    ),
                    Dimens.boxHeight8,
                    Text(
                      StringValues.forgotPasswordHelp,
                      style: AppStyles.p,
                      textAlign: TextAlign.center,
                    ),
                    Dimens.boxHeight32,
                    TextFormField(
                      decoration: const InputDecoration(
                        hintText: StringValues.enterEmail,
                      ),
                      keyboardType: TextInputType.emailAddress,
                      maxLines: 1,
                      style: AppStyles.style14Normal.copyWith(
                        color: Theme.of(context).textTheme.bodyLarge!.color,
                      ),
                      controller: logic.emailTextController,
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
                      onTap: () => logic.sendResetPasswordOTP(),
                      label: StringValues.sendOtp,
                    ),
                    Dimens.boxHeight32,
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          StringValues.alreadyHaveOtp,
                          style: AppStyles.style14Normal,
                        ),
                        Dimens.boxWidth4,
                        NxTextButton(
                          label: StringValues.resetPassword,
                          onTap: () {
                            RouteManagement.goToBack();
                            RouteManagement.goToResetPasswordView();
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
