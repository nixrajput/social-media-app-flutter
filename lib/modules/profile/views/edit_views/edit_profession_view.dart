import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media_app/constants/colors.dart';
import 'package:social_media_app/constants/data.dart';
import 'package:social_media_app/constants/dimens.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/constants/styles.dart';
import 'package:social_media_app/extensions/string_extensions.dart';
import 'package:social_media_app/global_widgets/app_filled_btn.dart';
import 'package:social_media_app/global_widgets/custom_app_bar.dart';
import 'package:social_media_app/global_widgets/custom_list_tile.dart';
import 'package:social_media_app/global_widgets/primary_text_btn.dart';
import 'package:social_media_app/global_widgets/unfocus_widget.dart';
import 'package:social_media_app/modules/profile/controllers/edit_profession_controller.dart';
import 'package:social_media_app/utils/utility.dart';

class EditProfessionView extends StatelessWidget {
  const EditProfessionView({Key? key}) : super(key: key);

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
                  title: StringValues.profession,
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

  Widget _buildBody() => GetBuilder<EditProfessionController>(
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
                    GestureDetector(
                      onTap: _showProfessionBottomSheet,
                      child: Container(
                        height: Dimens.fiftySix,
                        constraints:
                            BoxConstraints(maxWidth: Dimens.screenWidth),
                        padding: Dimens.edgeInsets16,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: ColorValues.grayColor,
                            width: Dimens.one,
                          ),
                          borderRadius: BorderRadius.circular(Dimens.four),
                        ),
                        child: Text(
                          logic.profession.toTitleCase(),
                          style: AppStyles.style14Normal.copyWith(
                            color: Theme.of(Get.context!)
                                .textTheme
                                .bodyLarge!
                                .color,
                          ),
                        ),
                      ),
                    ),
                    Dimens.boxHeight40,
                    NxFilledButton(
                      onTap: logic.updateProfession,
                      label: StringValues.save.toUpperCase(),
                      height: Dimens.fiftySix,
                    ),
                    Dimens.boxHeight16,
                  ],
                ),
              ),
            ),
          ),
        ),
      );

  _showProfessionBottomSheet() {
    var lastIndex = 20;
    var occupationList = StaticData.occupationList.sublist(1, lastIndex);
    AppUtility.showBottomSheet(
      children: [
        Padding(
          padding: Dimens.edgeInsetsDefault,
          child: Text(
            '${StringValues.select} ${StringValues.profession}',
            style: AppStyles.style18Bold.copyWith(
              color: Theme.of(Get.context!).textTheme.bodyLarge!.color,
            ),
          ),
        ),
        Dimens.boxHeight8,
        Expanded(
          child: Padding(
            padding: Dimens.edgeInsetsHorizDefault,
            child: StatefulBuilder(
              builder: (ctx, setInnerState) => Column(
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: StringValues.search,
                      fillColor: Theme.of(Get.context!).scaffoldBackgroundColor,
                    ),
                    maxLines: 1,
                    keyboardType: TextInputType.text,
                    textCapitalization: TextCapitalization.words,
                    style: AppStyles.style14Normal.copyWith(
                      color: Theme.of(Get.context!).textTheme.bodyLarge!.color,
                    ),
                    onChanged: (value) {
                      if (value.isEmpty) {
                        lastIndex = 20;
                        occupationList =
                            StaticData.occupationList.sublist(1, lastIndex);
                      } else {
                        occupationList = StaticData.occupationList
                            .where((element) => element
                                .toLowerCase()
                                .contains(value.toLowerCase()))
                            .toList();
                      }
                      setInnerState(() {});
                    },
                  ),
                  Dimens.boxHeight8,
                  Expanded(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
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
                            children: occupationList
                                .map(
                                  (e) => NxListTile(
                                    showBorder: false,
                                    padding: Dimens.edgeInsets8_0,
                                    title: Text(
                                      e.toTitleCase(),
                                      style: AppStyles.style14Bold.copyWith(
                                        color: Theme.of(Get.context!)
                                            .textTheme
                                            .bodyLarge!
                                            .color,
                                      ),
                                    ),
                                    onTap: () {
                                      Get.back();
                                      EditProfessionController.find
                                          .onProfessionChanged(e);
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
                                  occupationList = StaticData.occupationList
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
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
