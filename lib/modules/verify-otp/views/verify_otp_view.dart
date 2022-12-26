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
import 'package:social_media_app/modules/verify-otp/controllers/verify_otp_controller.dart';

class VerifyOtpView extends StatelessWidget {
  const VerifyOtpView({super.key});

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
                  padding: Dimens.edgeInsetsDefault,
                  title: '${StringValues.verify} ${StringValues.otp}',
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
    return GetBuilder<VerifyOtpController>(
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
                _buildHelpText(context, logic),
                Dimens.boxHeight32,
                _buildOtpFields(context, logic),
                Dimens.boxHeight32,
                _buildResendOtpBtn(context, logic),
                Dimens.boxHeight32,
                _buildVerifyOtpBtn(logic),
                Dimens.boxHeight16,
              ],
            ),
          ),
        ),
      ),
    );
  }

  Column _buildHelpText(BuildContext context, VerifyOtpController logic) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          StringValues.verifyOtp,
          style: AppStyles.style32Bold.copyWith(
            fontWeight: FontWeight.w900,
          ),
        ),
        Dimens.boxHeight4,
        RichText(
          text: TextSpan(children: [
            TextSpan(
              text: 'We have sent you an OTP on ',
              style: AppStyles.style13Normal.copyWith(
                color: Theme.of(context).textTheme.bodyText1!.color,
              ),
            ),
            TextSpan(
              text: logic.isEmailVerification
                  ? logic.email
                  : '${logic.countryCode.dialCode} ${logic.phone}',
              style: AppStyles.style13Bold.copyWith(
                color: Theme.of(context).textTheme.bodyText1!.color,
              ),
            ),
            TextSpan(
              text: '. Please enter the OTP to verify your ',
              style: AppStyles.style13Normal.copyWith(
                color: Theme.of(context).textTheme.bodyText1!.color,
              ),
            ),
            TextSpan(
              text: ' ${logic.isEmailVerification ? 'email' : 'phone'}',
              style: AppStyles.style13Normal.copyWith(
                color: Theme.of(context).textTheme.bodyText1!.color,
              ),
            ),
          ]),
        ),
      ],
    );
  }

  FocusScope _buildOtpFields(BuildContext context, VerifyOtpController logic) {
    return FocusScope(
      node: logic.focusNode,
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
      BuildContext context, VerifyOtpController logic, int index,
      {required bool isLast}) {
    return SizedBox(
      width: Dimens.screenWidth / 8,
      height: Dimens.screenWidth / 8,
      child: TextFormField(
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(Dimens.four),
          ),
          hintStyle: AppStyles.style16Bold.copyWith(
            color: ColorValues.grayColor,
          ),
        ),
        keyboardType: TextInputType.number,
        maxLines: 1,
        textAlign: TextAlign.center,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(1),
        ],
        style: AppStyles.style16Bold.copyWith(
          color: Theme.of(context).textTheme.bodyText1!.color,
        ),
        onChanged: (value) {
          if (value.isNotEmpty && !isLast) {
            logic.onOtpChanged(value, index);
            logic.focusNode.nextFocus();
          }
          if (isLast) {
            logic.onOtpChanged(value, index);
            logic.focusNode.unfocus();
          }
        },
      ),
    );
  }

  Row _buildResendOtpBtn(BuildContext context, VerifyOtpController logic) {
    return Row(
      children: [
        Expanded(
          child: NxTextButton(
            enabled: logic.resendTimerSec == 0 && logic.resendTimerMin == 0,
            label: StringValues.resendOtp,
            onTap: () => logic.isEmailVerification
                ? logic.resendOtpToEmail()
                : logic.resendOtpToPhone(),
          ),
        ),
        Dimens.boxWidth16,
        Text(
          '${logic.resendTimerMin}:${logic.resendTimerSec}',
          style: AppStyles.style16Bold.copyWith(
            color: Theme.of(context).textTheme.bodyText1!.color,
          ),
        ),
      ],
    );
  }

  NxFilledButton _buildVerifyOtpBtn(VerifyOtpController logic) {
    return NxFilledButton(
      width: Dimens.screenWidth,
      label: StringValues.verify.toUpperCase(),
      onTap: () => logic.isEmailVerification
          ? logic.verifyOtpFromEmail()
          : logic.verifyOtpFromPhone(),
    );
  }
}
