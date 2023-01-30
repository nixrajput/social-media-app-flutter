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
import 'package:social_media_app/global_widgets/unfocus_widget.dart';
import 'package:social_media_app/modules/settings/controllers/change_phone_controller.dart';
import 'package:social_media_app/utils/utility.dart';

class ChangePhoneView extends StatelessWidget {
  const ChangePhoneView({Key? key}) : super(key: key);

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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                NxAppBar(
                  title: StringValues.changePhone,
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
    return GetBuilder<ChangePhoneController>(
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
                                  text:
                                      '${StringValues.current} ${StringValues.phone.toLowerCase()} : ',
                                ),
                                TextSpan(
                                  text:
                                      '${logic.profile.profileDetails!.user!.countryCode!} ${logic.profile.profileDetails!.user!.phone!}',
                                  style: AppStyles.style16Bold,
                                ),
                              ],
                              style: AppStyles.style16Normal.copyWith(
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .color,
                              ),
                            ),
                          ),
                          Dimens.boxHeight32,
                          Text(
                            StringValues.yourCurrentPhoneDesc,
                            style: AppStyles.style13Normal.copyWith(
                              color:
                                  Theme.of(context).textTheme.bodyLarge!.color,
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
                            color: Theme.of(context).textTheme.bodyLarge!.color,
                          ),
                        ),
                      ),
                    Dimens.boxHeight12,
                    Container(
                      constraints: BoxConstraints(
                        minHeight: Dimens.fiftySix,
                        maxHeight: Dimens.fiftySix,
                      ),
                      decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        border: Border.all(
                          color: Theme.of(context).dividerColor,
                          width: Dimens.pointEight,
                        ),
                        borderRadius: BorderRadius.circular(Dimens.four),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () => _showCountryCodeBottomSheet(context),
                            child: Padding(
                              padding: Dimens.edgeInsets8,
                              child: Text(
                                '${logic.countryCode.dialCode}',
                                style: AppStyles.style14Bold.copyWith(
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .color,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            margin: Dimens.edgeInsets12_6,
                            width: Dimens.pointEight,
                            height: Dimens.fiftySix,
                            color: Theme.of(context).dividerColor,
                          ),
                          Expanded(
                            child: TextFormField(
                              decoration: InputDecoration(
                                fillColor: ColorValues.transparent,
                                hintText: StringValues.phoneNo,
                                border: const OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                ),
                                disabledBorder: const OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                ),
                                enabledBorder: const OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                ),
                                focusedBorder: const OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                ),
                                errorBorder: const OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                ),
                                focusedErrorBorder: const OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                ),
                                constraints: BoxConstraints(
                                  minHeight: Dimens.fiftySix,
                                  maxHeight: Dimens.fiftySix,
                                ),
                              ),
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                                LengthLimitingTextInputFormatter(12),
                              ],
                              enabled: logic.otpSent ? false : true,
                              keyboardType: TextInputType.phone,
                              maxLines: 1,
                              style: AppStyles.style14Normal.copyWith(
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .color,
                              ),
                              onChanged: (value) => logic.onChangeOtp(value),
                              onEditingComplete: () =>
                                  logic.focusNode.unfocus(),
                            ),
                          ),
                        ],
                      ),
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
                              borderRadius: BorderRadius.circular(Dimens.four),
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
                            color: Theme.of(context).textTheme.bodyLarge!.color,
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
  }

  _showCountryCodeBottomSheet(BuildContext context) {
    var lastIndex = 20;
    var countryCodes = StaticData.countryCodes.sublist(0, lastIndex);
    AppUtility.showBottomSheet(
      children: [
        Padding(
          padding: Dimens.edgeInsetsDefault,
          child: Text(
            StringValues.select,
            style: AppStyles.style18Bold.copyWith(
              color: Theme.of(context).textTheme.bodyLarge!.color,
            ),
          ),
        ),
        Dimens.boxHeight8,
        Expanded(
          child: StatefulBuilder(
            builder: (ctx, setInnerState) => Column(
              children: [
                Padding(
                  padding: Dimens.edgeInsetsHorizDefault,
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: StringValues.search,
                      fillColor: Theme.of(context).scaffoldBackgroundColor,
                    ),
                    maxLines: 1,
                    keyboardType: TextInputType.text,
                    textCapitalization: TextCapitalization.words,
                    style: AppStyles.style14Normal.copyWith(
                      color: Theme.of(context).textTheme.bodyLarge!.color,
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
                      padding: Dimens.edgeInsetsHorizDefault,
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
                                    showBorder: false,
                                    leading: Text(
                                      e.name.toTitleCase(),
                                      style: AppStyles.style14Bold.copyWith(
                                        color: Theme.of(context)
                                            .textTheme
                                            .bodyLarge!
                                            .color,
                                      ),
                                    ),
                                    leadingFlex: 1,
                                    trailing: Text(
                                      e.dialCode.toTitleCase(),
                                      style: AppStyles.style14Bold.copyWith(
                                        color: Theme.of(context)
                                            .textTheme
                                            .bodyLarge!
                                            .color,
                                      ),
                                    ),
                                    onTap: () {
                                      Get.back();
                                      ChangePhoneController.find
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
