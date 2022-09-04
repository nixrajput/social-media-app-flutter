import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media_app/constants/data.dart';
import 'package:social_media_app/constants/dimens.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/extensions/string_extensions.dart';
import 'package:social_media_app/global_widgets/custom_app_bar.dart';
import 'package:social_media_app/global_widgets/primary_filled_btn.dart';
import 'package:social_media_app/modules/profile/controllers/edit_profession_controller.dart';

class EditProfessionView extends StatelessWidget {
  const EditProfessionView({Key? key}) : super(key: key);

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
                  title: StringValues.profession,
                  padding: Dimens.edgeInsets8_16,
                ),
                Dimens.boxHeight24,
                _buildBody(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBody() => GetBuilder<EditProfessionController>(
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
                    Container(
                      height: Dimens.fiftySix,
                      constraints: BoxConstraints(maxWidth: Dimens.screenWidth),
                      child: DropdownButton(
                        elevation: 0,
                        dropdownColor:
                            Theme.of(Get.context!).dialogBackgroundColor,
                        hint: const Text(StringValues.profession),
                        isExpanded: true,
                        menuMaxHeight: Dimens.screenHeight * 0.6,
                        value: logic.profession,
                        borderRadius: BorderRadius.circular(Dimens.eight),
                        items: StaticData.occupationList
                            .map(
                              (String e) => DropdownMenuItem(
                                value: e,
                                child: Text(e.toTitleCase()),
                              ),
                            )
                            .toList(),
                        onChanged: (String? value) =>
                            logic.onProfessionChanged(value),
                      ),
                    ),
                    Dimens.boxHeight40,
                    NxFilledButton(
                      onTap: logic.updateProfession,
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
