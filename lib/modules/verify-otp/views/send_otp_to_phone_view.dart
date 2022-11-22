import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:social_media_app/constants/colors.dart';
import 'package:social_media_app/constants/data.dart';
import 'package:social_media_app/constants/dimens.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/constants/styles.dart';
import 'package:social_media_app/extensions/string_extensions.dart';
import 'package:social_media_app/global_widgets/custom_app_bar.dart';
import 'package:social_media_app/global_widgets/custom_list_tile.dart';
import 'package:social_media_app/global_widgets/primary_filled_btn.dart';
import 'package:social_media_app/global_widgets/primary_text_btn.dart';
import 'package:social_media_app/modules/verify-otp/controllers/verify_otp_controller.dart';
import 'package:social_media_app/utils/utility.dart';

class SendOtpToPhoneView extends StatelessWidget {
  const SendOtpToPhoneView({Key? key}) : super(key: key);

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
                    _buildPhoneFields(logic),
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
          StringValues.sendOtpToPhone,
          style: AppStyles.style32Bold.copyWith(
            fontWeight: FontWeight.w900,
          ),
        ),
        Dimens.boxHeight4,
        Text(
          StringValues.sendOtpToPhoneDesc,
          style: AppStyles.style12Normal,
        ),
      ],
    );
  }

  Column _buildPhoneFields(VerifyOtpController logic) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: _showCountryCodeBottomSheet,
          child: Container(
            height: Dimens.fiftySix,
            decoration: BoxDecoration(
              border: Border.all(
                color: Theme.of(Get.context!).dividerColor,
              ),
              borderRadius: BorderRadius.circular(Dimens.eight),
            ),
            child: Center(
              child: Text(
                '${logic.countryCode.name} (${logic.countryCode.dialCode})',
                style: AppStyles.style14Normal,
              ),
            ),
          ),
        ),
        Dimens.boxHeight16,
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
              hintText: StringValues.phoneNo,
            ),
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(12),
            ],
            keyboardType: TextInputType.phone,
            maxLines: 1,
            style: AppStyles.style14Normal.copyWith(
              color: Theme.of(Get.context!).textTheme.bodyText1!.color,
            ),
            onChanged: (value) => logic.onPhoneChanged(value),
            onEditingComplete: () => logic.focusNode.unfocus(),
          ),
        ),
      ],
    );
  }

  NxFilledButton _buildSendEmailButton(VerifyOtpController logic) {
    return NxFilledButton(
      width: Dimens.screenWidth,
      onTap: () => logic.sendOtpToPhone(),
      label: StringValues.sendOtp.toUpperCase(),
    );
  }

  _showCountryCodeBottomSheet() {
    var lastIndex = 20;
    var countryCodes = StaticData.countryCodes.sublist(0, lastIndex);
    AppUtility.showBottomSheet(
      [
        Padding(
          padding: Dimens.edgeInsets8_16,
          child: Text(
            StringValues.select,
            style: AppStyles.style18Bold.copyWith(
              color: Theme.of(Get.context!).textTheme.bodyText1!.color,
            ),
          ),
        ),
        Dimens.boxHeight8,
        Expanded(
          child: StatefulBuilder(
            builder: (ctx, setInnerState) => Column(
              children: [
                Container(
                  height: Dimens.fiftySix,
                  margin: Dimens.edgeInsets0_16,
                  constraints: BoxConstraints(maxWidth: Dimens.screenWidth),
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: StringValues.search,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(Dimens.eight),
                      ),
                      hintStyle: AppStyles.style14Normal.copyWith(
                        color: ColorValues.grayColor,
                      ),
                    ),
                    maxLines: 1,
                    keyboardType: TextInputType.text,
                    textCapitalization: TextCapitalization.words,
                    style: AppStyles.style14Normal.copyWith(
                      color: Theme.of(Get.context!).textTheme.bodyText1!.color,
                    ),
                    onChanged: (value) {
                      if (value.isEmpty) {
                        lastIndex = 20;
                        countryCodes =
                            StaticData.countryCodes.sublist(1, lastIndex);
                      } else {
                        countryCodes = StaticData.countryCodes
                            .where((element) => element.name
                                .toLowerCase()
                                .contains(value.toLowerCase()))
                            .toList();
                      }
                      setInnerState(() {});
                    },
                  ),
                ),
                Dimens.boxHeight8,
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics(),
                    ),
                    child: Padding(
                      padding: Dimens.edgeInsets0_16,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: countryCodes
                                .map(
                                  (e) => NxListTile(
                                    leading: Text(
                                      e.name.toTitleCase(),
                                      style: AppStyles.style14Normal.copyWith(
                                        color: Theme.of(Get.context!)
                                            .textTheme
                                            .bodyText1!
                                            .color,
                                      ),
                                    ),
                                    leadingFlex: 1,
                                    trailing: Text(
                                      e.dialCode.toTitleCase(),
                                      style: AppStyles.style14Normal.copyWith(
                                        color: Theme.of(Get.context!)
                                            .textTheme
                                            .bodyText1!
                                            .color,
                                      ),
                                    ),
                                    onTap: () {
                                      Get.back();
                                      Get.find<VerifyOtpController>()
                                          .onCountryCodeChanged(e);
                                    },
                                  ),
                                )
                                .toList(),
                          ),
                          Center(
                            child: Padding(
                              padding: Dimens.edgeInsets8_16,
                              child: NxTextButton(
                                label: 'Load more',
                                onTap: () {
                                  lastIndex += 20;
                                  countryCodes = StaticData.countryCodes
                                      .sublist(1, lastIndex);
                                  setInnerState(() {});
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
