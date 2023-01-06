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
import 'package:social_media_app/modules/settings/controllers/change_phone_controller.dart';
import 'package:social_media_app/utils/utility.dart';

class ChangePhoneView extends StatelessWidget {
  const ChangePhoneView({Key? key}) : super(key: key);

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
                  title: StringValues.changePhone,
                  padding: Dimens.edgeInsetsDefault,
                ),
                _buildBody(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBody() => GetBuilder<ChangePhoneController>(
        builder: (logic) {
          return Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: Dimens.edgeInsetsHorizDefault,
                child: FocusScope(
                  node: logic.focusNode,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Dimens.boxHeight8,
                      if (logic.profile.profileDetails!.user!.phone != null)
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                      text: '${StringValues.yourCurrentPhone} ',
                                      style: AppStyles.style13Normal.copyWith(
                                        color: Theme.of(Get.context!)
                                            .textTheme
                                            .bodyText1!
                                            .color,
                                      )),
                                  TextSpan(
                                    text:
                                        '${logic.profile.profileDetails!.user!.countryCode!} ${logic.profile.profileDetails!.user!.phone!}',
                                    style: AppStyles.style16Bold,
                                  ),
                                ],
                                style: AppStyles.style14Normal.copyWith(
                                  color: Theme.of(Get.context!)
                                      .textTheme
                                      .bodyText1!
                                      .color,
                                ),
                              ),
                            ),
                            Dimens.boxHeight4,
                            Text(
                              StringValues.yourCurrentPhoneDesc,
                              style: AppStyles.style13Normal.copyWith(
                                color: Theme.of(Get.context!)
                                    .textTheme
                                    .bodyText1!
                                    .color,
                              ),
                            )
                          ],
                        )
                      else
                        RichText(
                          text: TextSpan(
                            children: const [
                              TextSpan(text: StringValues.enterPhoneToAdd),
                            ],
                            style: AppStyles.style13Normal.copyWith(
                              color: Theme.of(Get.context!)
                                  .textTheme
                                  .bodyText1!
                                  .color,
                            ),
                          ),
                        ),
                      Dimens.boxHeight32,
                      Column(
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
                                borderRadius:
                                    BorderRadius.circular(Dimens.four),
                              ),
                              child: Center(
                                child: Text(
                                  '${logic.code.name} (${logic.code.dialCode})',
                                  style: AppStyles.style14Normal,
                                ),
                              ),
                            ),
                          ),
                          Dimens.boxHeight16,
                          Container(
                            height: Dimens.fiftySix,
                            constraints:
                                BoxConstraints(maxWidth: Dimens.screenWidth),
                            child: TextFormField(
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.circular(Dimens.four),
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
                              enabled: logic.otpSent ? false : true,
                              keyboardType: TextInputType.phone,
                              maxLines: 1,
                              style: AppStyles.style14Normal.copyWith(
                                color: Theme.of(Get.context!)
                                    .textTheme
                                    .bodyText1!
                                    .color,
                              ),
                              onChanged: (value) => logic.onChangeOtp(value),
                              onEditingComplete: () =>
                                  logic.focusNode.unfocus(),
                            ),
                          ),
                        ],
                      ),
                      Dimens.boxHeight16,
                      if (logic.otpSent) Dimens.boxHeight16,
                      if (logic.otpSent)
                        Container(
                          height: Dimens.fiftySix,
                          constraints:
                              BoxConstraints(maxWidth: Dimens.screenWidth),
                          child: TextFormField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.circular(Dimens.four),
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
                              color: Theme.of(Get.context!)
                                  .textTheme
                                  .bodyText1!
                                  .color,
                            ),
                            onChanged: (value) => logic.onChangeOtp(value),
                            onEditingComplete: () => logic.focusNode.unfocus(),
                          ),
                        ),
                      Dimens.boxHeight40,
                      NxFilledButton(
                        onTap: logic.otpSent
                            ? logic.addChangePhone
                            : logic.sendAddChangePhoneOtp,
                        label: logic.otpSent
                            ? StringValues.save.toUpperCase()
                            : StringValues.next.toUpperCase(),
                        height: Dimens.fiftySix,
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

  _showCountryCodeBottomSheet() {
    var lastIndex = 20;
    var countryCodes = StaticData.countryCodes.sublist(0, lastIndex);
    AppUtility.showBottomSheet(
      children: [
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
                                      Get.find<ChangePhoneController>()
                                          .onChangeCountryCode(e);
                                    },
                                  ),
                                )
                                .toList(),
                          ),
                          Center(
                            child: Padding(
                              padding: Dimens.edgeInsets8_16,
                              child: NxTextButton(
                                label: StringValues.loadMore,
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
