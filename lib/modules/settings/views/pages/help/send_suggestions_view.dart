import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media_app/constants/colors.dart';
import 'package:social_media_app/constants/dimens.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/constants/styles.dart';
import 'package:social_media_app/global_widgets/custom_app_bar.dart';
import 'package:social_media_app/global_widgets/primary_filled_btn.dart';
import 'package:social_media_app/modules/settings/controllers/send_suggestions_controller.dart';

class SendSuggestionsView extends StatelessWidget {
  const SendSuggestionsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: Dimens.screenWidth,
          height: Dimens.screenHeight,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              NxAppBar(
                title: StringValues.sendSuggestions,
                padding: Dimens.edgeInsets8_16,
              ),
              Dimens.boxHeight16,
              _buildBody(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBody() {
    return Expanded(
      child: SingleChildScrollView(
          child: GetBuilder<SendSuggestionsController>(
        builder: (logic) => Padding(
          padding: Dimens.edgeInsets0_16,
          child: FocusScope(
            node: logic.focusNode,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  height: Dimens.hundred,
                  constraints: BoxConstraints(maxWidth: Dimens.screenWidth),
                  child: TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(Dimens.eight),
                      ),
                      hintStyle: AppStyles.style14Normal.copyWith(
                        color: ColorValues.grayColor,
                      ),
                      hintText: StringValues.writeSuggestion,
                    ),
                    keyboardType: TextInputType.multiline,
                    maxLines: 4,
                    style: AppStyles.style14Normal.copyWith(
                      color: Theme.of(Get.context!).textTheme.bodyText1!.color,
                    ),
                    controller: logic.messageTextController,
                  ),
                ),
                Dimens.boxHeight40,
                NxFilledButton(
                  onTap: logic.sendSuggestionsEmail,
                  label: StringValues.next.toUpperCase(),
                ),
                Dimens.boxHeight16,
              ],
            ),
          ),
        ),
      )),
    );
  }
}
