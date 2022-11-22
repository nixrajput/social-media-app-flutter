import 'package:flutter/material.dart';
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
import 'package:social_media_app/modules/profile/controllers/edit_profession_controller.dart';
import 'package:social_media_app/utils/utility.dart';

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
                    // Container(
                    //   height: Dimens.fiftySix,
                    //   constraints: BoxConstraints(maxWidth: Dimens.screenWidth),
                    //   child: DropdownButton(
                    //     elevation: 0,
                    //     dropdownColor:
                    //         Theme.of(Get.context!).dialogBackgroundColor,
                    //     hint: const Text(StringValues.profession),
                    //     isExpanded: true,
                    //     style: AppStyles.style14Normal.copyWith(
                    //       color:
                    //           Theme.of(Get.context!).textTheme.bodyText1!.color,
                    //     ),
                    //     value: logic.profession,
                    //     borderRadius: BorderRadius.circular(Dimens.eight),
                    //     items: StaticData.occupationList
                    //         .map(
                    //           (String e) => DropdownMenuItem(
                    //             value: e,
                    //             child: Text(e.toTitleCase()),
                    //           ),
                    //         )
                    //         .toList(),
                    //     onChanged: (String? value) =>
                    //         logic.onProfessionChanged(value),
                    //   ),
                    // ),
                    InkWell(
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
                          borderRadius: BorderRadius.circular(Dimens.eight),
                        ),
                        child: Text(
                          logic.profession.toTitleCase(),
                          style: AppStyles.style14Normal.copyWith(
                            color: Theme.of(Get.context!)
                                .textTheme
                                .bodyText1!
                                .color,
                          ),
                        ),
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

  _showProfessionBottomSheet() {
    var lastIndex = 20;
    var occupationList = StaticData.occupationList.sublist(1, lastIndex);
    AppUtility.showBottomSheet(
      children: [
        Padding(
          padding: Dimens.edgeInsets8_16,
          child: Text(
            '${StringValues.select} ${StringValues.profession}',
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
                ),
                Dimens.boxHeight8,
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
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
                                  title: Text(
                                    e.toTitleCase(),
                                    style: AppStyles.style14Normal.copyWith(
                                      color: Theme.of(Get.context!)
                                          .textTheme
                                          .bodyText1!
                                          .color,
                                    ),
                                  ),
                                  onTap: () {
                                    Get.back();
                                    Get.find<EditProfessionController>()
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
        )
      ],
    );
  }
}
