import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media_app/constants/colors.dart';
import 'package:social_media_app/constants/dimens.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/constants/styles.dart';
import 'package:social_media_app/global_widgets/custom_app_bar.dart';
import 'package:social_media_app/global_widgets/primary_filled_btn.dart';
import 'package:social_media_app/modules/verify-otp/controllers/verify_otp_controller.dart';

class SendOtpToEmailView extends StatelessWidget {
  const SendOtpToEmailView({Key? key}) : super(key: key);

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
                  title: StringValues.sendOtp,
                  padding: Dimens.edgeInsets8_16,
                ),
                _buildBody(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context) => GetBuilder<VerifyOtpController>(
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
                    _buildHelpText(),
                    Dimens.boxHeight32,
                    _buildEmailField(logic),
                    Dimens.boxHeight32,
                    _buildSendEmailButton(logic),
                    Dimens.boxHeight16,
                  ],
                ),
              ),
            ),
          ),
        ),
      );

  Column _buildHelpText() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          StringValues.sendOtpToEmail,
          style: AppStyles.style32Bold.copyWith(
            fontWeight: FontWeight.w900,
          ),
        ),
        Dimens.boxHeight4,
        Text(
          StringValues.sendOtpToEmailDesc,
          style: AppStyles.style12Normal,
        ),
      ],
    );
  }

  Container _buildEmailField(VerifyOtpController logic) {
    return Container(
      height: Dimens.fiftySix,
      constraints: BoxConstraints(maxWidth: Dimens.screenWidth),
      child: TextFormField(
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(Dimens.eight),
          ),
          hintText: StringValues.email,
          hintStyle: AppStyles.style14Normal.copyWith(
            color: ColorValues.grayColor,
          ),
        ),
        keyboardType: TextInputType.emailAddress,
        maxLines: 1,
        style: AppStyles.style14Normal.copyWith(
          color: Theme.of(Get.context!).textTheme.bodyText1!.color,
        ),
        onEditingComplete: logic.focusNode.unfocus,
        onChanged: (value) => logic.onEmailChanged(value),
      ),
    );
  }

  NxFilledButton _buildSendEmailButton(VerifyOtpController logic) {
    return NxFilledButton(
      width: Dimens.screenWidth,
      onTap: () => logic.sendOtpToEmail(),
      label: StringValues.sendOtp.toUpperCase(),
    );
  }
}
