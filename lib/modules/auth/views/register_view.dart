import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:social_media_app/constants/colors.dart';
import 'package:social_media_app/constants/dimens.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/constants/styles.dart';
import 'package:social_media_app/global_widgets/app_filled_btn.dart';
import 'package:social_media_app/global_widgets/custom_app_bar.dart';
import 'package:social_media_app/global_widgets/primary_text_btn.dart';
import 'package:social_media_app/global_widgets/unfocus_widget.dart';
import 'package:social_media_app/modules/auth/controllers/register_controller.dart';
import 'package:social_media_app/routes/route_management.dart';
import 'package:social_media_app/utils/utility.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({Key? key}) : super(key: key);

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
                NxAppBar(
                  title: StringValues.register,
                  showBackBtn: true,
                  padding: Dimens.edgeInsetsDefault,
                ),
                _buildBody(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return GetBuilder<RegisterController>(
      builder: (logic) => Expanded(
        child: SingleChildScrollView(
          child: Padding(
            padding: Dimens.edgeInsetsHorizDefault,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                Dimens.boxHeight32,
                Text(
                  StringValues.registerWelcome,
                  style: AppStyles.style32Bold.copyWith(
                    fontWeight: FontWeight.w900,
                  ),
                ),
                Dimens.boxHeight32,
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 500),
                  child: logic.isEmailVerified
                      ? _buildRegistrationBody(context, logic)
                      : _buildVerificationBody(context, logic),
                ),
                Dimens.boxHeight32,
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 500),
                  child: logic.isEmailVerified
                      ? _buildRegisterBtn(context, logic)
                      : _buildActionBtn(context, logic),
                ),
                Dimens.boxHeight32,
                _buildAlreadyRegisteredBtn(),
                Dimens.boxHeight16,
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRegistrationBody(
      BuildContext context, RegisterController logic) {
    return FocusScope(
      node: logic.focusNode,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            StringValues.enterDetailsToRegister,
            style: AppStyles.style14Normal.copyWith(
              color: Theme.of(context).textTheme.bodyLarge!.color,
            ),
          ),
          Dimens.boxHeight12,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: TextFormField(
                  decoration: const InputDecoration(
                    hintText: StringValues.firstName,
                  ),
                  keyboardType: TextInputType.name,
                  maxLines: 1,
                  style: AppStyles.style14Normal.copyWith(
                    color: Theme.of(context).textTheme.bodyLarge!.color,
                  ),
                  controller: logic.fNameTextController,
                  onEditingComplete: logic.focusNode.nextFocus,
                ),
              ),
              Dimens.boxWidth12,
              Expanded(
                child: TextFormField(
                  decoration: const InputDecoration(
                    hintText: StringValues.lastName,
                  ),
                  keyboardType: TextInputType.name,
                  maxLines: 1,
                  style: AppStyles.style14Normal.copyWith(
                    color: Theme.of(context).textTheme.bodyLarge!.color,
                  ),
                  controller: logic.lNameTextController,
                  onEditingComplete: logic.focusNode.nextFocus,
                ),
              ),
            ],
          ),
          Dimens.boxHeight12,
          TextFormField(
            decoration: const InputDecoration(
              hintText: StringValues.username,
            ),
            keyboardType: TextInputType.text,
            maxLines: 1,
            style: AppStyles.style14Normal.copyWith(
              color: Theme.of(context).textTheme.bodyLarge!.color,
            ),
            controller: logic.unameTextController,
            onEditingComplete: logic.focusNode.nextFocus,
          ),
          Dimens.boxHeight12,
          TextFormField(
            obscureText: logic.showPassword,
            decoration: InputDecoration(
              hintText: StringValues.password,
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
            obscureText: logic.showConfirmPassword,
            decoration: InputDecoration(
              hintText: StringValues.confirmPassword,
              suffixIcon: InkWell(
                onTap: logic.toggleViewConfirmPassword,
                child: Icon(
                  logic.showConfirmPassword
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
        ],
      ),
    );
  }

  Widget _buildVerificationBody(
      BuildContext context, RegisterController logic) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 500),
      child: logic.isOtpSent
          ? _buildOtpSentBody(context, logic)
          : _buildEnterEmailBody(context, logic),
    );
  }

  Widget _buildOtpSentBody(BuildContext context, RegisterController logic) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          StringValues.enterOtpYouGet,
          style: AppStyles.style14Normal.copyWith(
            color: Theme.of(context).textTheme.bodyLarge!.color,
          ),
        ),
        Dimens.boxHeight12,
        _buildOtpFields(context, logic),
        Dimens.boxHeight32,
        _buildResendOtpBtn(context, logic),
      ],
    );
  }

  Widget _buildEnterEmailBody(BuildContext context, RegisterController logic) {
    return FocusScope(
      node: logic.focusNode,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            StringValues.enterEmailToSendOtp,
            style: AppStyles.style14Normal.copyWith(
              color: Theme.of(context).textTheme.bodyLarge!.color,
            ),
          ),
          Dimens.boxHeight12,
          TextFormField(
            decoration: const InputDecoration(
              hintText: StringValues.email,
            ),
            keyboardType: TextInputType.emailAddress,
            maxLines: 1,
            style: AppStyles.style14Normal.copyWith(
              color: Theme.of(context).textTheme.bodyLarge!.color,
            ),
            controller: logic.emailTextController,
            onEditingComplete: logic.focusNode.unfocus,
          ),
        ],
      ),
    );
  }

  FocusScope _buildOtpFields(BuildContext context, RegisterController logic) {
    return FocusScope(
      node: logic.otpFocusNode,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildOtpField(context, logic, 0, isLast: false),
          _buildOtpField(context, logic, 1, isLast: false),
          _buildOtpField(context, logic, 2, isLast: false),
          _buildOtpField(context, logic, 3, isLast: false),
          _buildOtpField(context, logic, 4, isLast: false),
          _buildOtpField(context, logic, 5, isLast: true),
        ],
      ),
    );
  }

  SizedBox _buildOtpField(
      BuildContext context, RegisterController logic, int index,
      {required bool isLast}) {
    return SizedBox(
      width: Dimens.screenWidth / 8,
      height: Dimens.screenWidth / 8,
      child: TextFormField(
        decoration: const InputDecoration(
          hintText: StringValues.zero,
        ),
        keyboardType: TextInputType.number,
        maxLines: 1,
        textAlign: TextAlign.center,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(1),
        ],
        style: AppStyles.style16Bold.copyWith(
          color: Theme.of(context).textTheme.bodyLarge!.color,
        ),
        onChanged: (value) {
          if (value.isNotEmpty && !isLast) {
            logic.onOtpChanged(value, index);
            logic.otpFocusNode.nextFocus();
          }
          if (isLast) {
            logic.onOtpChanged(value, index);
            logic.otpFocusNode.unfocus();
          }
        },
      ),
    );
  }

  Row _buildResendOtpBtn(BuildContext context, RegisterController logic) {
    return Row(
      children: [
        Expanded(
          child: NxTextButton(
            enabled: logic.resendTimerSec == 0 && logic.resendTimerMin == 0,
            label: StringValues.resendOtp,
            onTap: () => logic.resendOtpToEmail(),
          ),
        ),
        Dimens.boxWidth12,
        Text(
          '${logic.resendTimerMin}:${logic.resendTimerSec}',
          style: AppStyles.style16Bold.copyWith(
            color: Theme.of(context).textTheme.bodyLarge!.color,
          ),
        ),
      ],
    );
  }

  Widget _buildRegisterBtn(BuildContext context, RegisterController logic) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildAgreeTerms(context),
        Dimens.boxHeight12,
        NxFilledButton(
          onTap: () => logic.register(),
          label: StringValues.register.toUpperCase(),
          width: Dimens.screenWidth,
          height: Dimens.fiftySix,
        ),
      ],
    );
  }

  NxFilledButton _buildActionBtn(
      BuildContext context, RegisterController logic) {
    return NxFilledButton(
      width: Dimens.screenWidth,
      height: Dimens.fiftySix,
      label: logic.isOtpSent
          ? StringValues.verify.toUpperCase()
          : StringValues.sendOtp.toUpperCase(),
      onTap: () =>
          logic.isOtpSent ? logic.verifyOtpFromEmail() : logic.sendOtpToEmail(),
    );
  }

  RichText _buildAgreeTerms(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          const TextSpan(
            text: StringValues.agreeToPrivacyAndTerms1,
          ),
          TextSpan(
            text: StringValues.termsOfUse,
            style: AppStyles.style13Normal.copyWith(
              color: ColorValues.linkColor,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () =>
                  AppUtility.openUrl(Uri.parse(StringValues.termsOfServiceUrl)),
          ),
          const TextSpan(
            text: ', ',
          ),
          TextSpan(
            text: StringValues.privacyPolicy,
            style: AppStyles.style13Normal.copyWith(
              color: ColorValues.linkColor,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () =>
                  AppUtility.openUrl(Uri.parse(StringValues.privacyPolicyUrl)),
          ),
          const TextSpan(
            text: ' ${StringValues.and} ',
          ),
          TextSpan(
            text: StringValues.communityGuidelines,
            style: AppStyles.style13Normal.copyWith(
              color: ColorValues.linkColor,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () => AppUtility.openUrl(
                  Uri.parse(StringValues.communityGuidelinesUrl)),
          ),
          const TextSpan(
            text: '.',
          ),
        ],
        style: AppStyles.style13Normal.copyWith(
          color: Theme.of(context).textTheme.titleMedium!.color,
        ),
      ),
    );
  }

  Row _buildAlreadyRegisteredBtn() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          StringValues.alreadyHaveAccount,
          style: AppStyles.style14Normal,
        ),
        Dimens.boxWidth4,
        NxTextButton(
          label: StringValues.login,
          onTap: () {
            RouteManagement.goToBack();
            RouteManagement.goToLoginView();
          },
        ),
      ],
    );
  }
}
