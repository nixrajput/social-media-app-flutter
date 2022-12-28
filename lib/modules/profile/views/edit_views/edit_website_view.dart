import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media_app/constants/colors.dart';
import 'package:social_media_app/constants/dimens.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/constants/styles.dart';
import 'package:social_media_app/global_widgets/custom_app_bar.dart';
import 'package:social_media_app/global_widgets/primary_filled_btn.dart';
import 'package:social_media_app/modules/profile/controllers/edit_website_controller.dart';

class EditWebsiteView extends StatelessWidget {
  const EditWebsiteView({Key? key}) : super(key: key);

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
                  title: StringValues.website,
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

  Widget _buildBody() => GetBuilder<EditWebsiteController>(
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
                    Dimens.boxHeight8,
                    Container(
                      height: Dimens.fiftySix,
                      constraints: BoxConstraints(maxWidth: Dimens.screenWidth),
                      child: TextFormField(
                        decoration: InputDecoration(
                          hintText: StringValues.website,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(Dimens.four),
                          ),
                          hintStyle: AppStyles.style14Normal.copyWith(
                            color: ColorValues.grayColor,
                          ),
                        ),
                        maxLines: 1,
                        initialValue: logic.website,
                        keyboardType: TextInputType.url,
                        style: AppStyles.style14Normal.copyWith(
                          color:
                              Theme.of(Get.context!).textTheme.bodyText1!.color,
                        ),
                        onChanged: (value) => logic.onChangeWebsite(value),
                        onEditingComplete: logic.focusNode.unfocus,
                      ),
                    ),
                    Dimens.boxHeight40,
                    NxFilledButton(
                      onTap: logic.updateWebsite,
                      label: StringValues.save.toUpperCase(),
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
