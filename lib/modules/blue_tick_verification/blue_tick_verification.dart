import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media_app/constants/colors.dart';
import 'package:social_media_app/constants/dimens.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/constants/styles.dart';
import 'package:social_media_app/global_widgets/circular_progress_indicator.dart';
import 'package:social_media_app/global_widgets/custom_app_bar.dart';
import 'package:social_media_app/global_widgets/custom_list_tile.dart';
import 'package:social_media_app/global_widgets/primary_filled_btn.dart';
import 'package:social_media_app/global_widgets/unfocus_widget.dart';
import 'package:social_media_app/modules/blue_tick_verification/blue_tick_verification_controller.dart';
import 'package:social_media_app/utils/utility.dart';

class BlueTickVerificationView extends StatelessWidget {
  const BlueTickVerificationView({super.key});

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
                  title: StringValues.verificationRequest,
                  padding: Dimens.edgeInsets8_16,
                ),
                Dimens.boxHeight16,
                _buildBody(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return GetBuilder<BlueTickVerificationController>(
      builder: (logic) {
        if (logic.isLoading) {
          return const Expanded(
            child: Center(
              child: NxCircularProgressIndicator(),
            ),
          );
        }

        return Expanded(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics(),
            ),
            child: Padding(
              padding: Dimens.edgeInsets0_16,
              child: FocusScope(
                node: logic.focusNode,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildLegalNameField(logic),
                    Dimens.boxHeight16,
                    _buildEmailField(logic),
                    Dimens.boxHeight16,
                    _buildPhoneField(logic),
                    Dimens.boxHeight16,
                    _buildCategoryField(logic),
                    Dimens.boxHeight16,
                    _buildDocumentField(logic),
                    Dimens.boxHeight40,
                    _buildSubmitBtn(logic),
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

  Column _buildDocumentField(BlueTickVerificationController logic) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: () => logic.selectDocument(),
          child: Container(
            padding: Dimens.edgeInsets8,
            height: Dimens.fiftySix,
            constraints: BoxConstraints(maxWidth: Dimens.screenWidth),
            decoration: BoxDecoration(
              border: Border.all(
                color: Theme.of(Get.context!).dividerColor,
              ),
              borderRadius: BorderRadius.circular(Dimens.eight),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      logic.document == null
                          ? StringValues.selectDocument
                          : logic.document!.path.substring(
                              logic.document!.path.lastIndexOf('/') + 1,
                            ),
                      style: AppStyles.style14Bold.copyWith(
                        color:
                            Theme.of(Get.context!).textTheme.bodyText1!.color,
                      ),
                    ),
                  ),
                ),
                Dimens.boxWidth16,
                if (logic.document != null)
                  Icon(
                    Icons.check_circle,
                    color: logic.document != null
                        ? ColorValues.successColor
                        : Colors.transparent,
                    size: Dimens.twenty,
                  ),
              ],
            ),
          ),
        ),
        Padding(
          padding: Dimens.edgeInsets2,
          child: RichText(
            text: TextSpan(
              text: StringValues.selectDocumentHelp,
              style: AppStyles.style12Normal.copyWith(
                color: Theme.of(Get.context!).textTheme.subtitle1!.color,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Column _buildCategoryField(BlueTickVerificationController logic) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: _selectCategoryBottomSheet,
          child: Container(
            padding: Dimens.edgeInsets8,
            height: Dimens.fiftySix,
            constraints: BoxConstraints(maxWidth: Dimens.screenWidth),
            decoration: BoxDecoration(
              border: Border.all(
                color: Theme.of(Get.context!).dividerColor,
              ),
              borderRadius: BorderRadius.circular(Dimens.eight),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      logic.category.isEmpty
                          ? StringValues.selectCategory
                          : logic.category,
                      style: AppStyles.style14Bold.copyWith(
                        color:
                            Theme.of(Get.context!).textTheme.bodyText1!.color,
                      ),
                    ),
                  ),
                ),
                Dimens.boxWidth16,
                Icon(
                  Icons.check_circle,
                  color: logic.category.isNotEmpty
                      ? ColorValues.successColor
                      : Colors.transparent,
                  size: Dimens.twenty,
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: Dimens.edgeInsets2,
          child: RichText(
            text: TextSpan(
              text: StringValues.selectCategoryHelp,
              style: AppStyles.style12Normal.copyWith(
                color: Theme.of(Get.context!).textTheme.subtitle1!.color,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Column _buildPhoneField(BlueTickVerificationController logic) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
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
              hintText: StringValues.phone,
              suffixIcon: Icon(
                Icons.check_circle,
                color: logic.phone.isNotEmpty
                    ? ColorValues.successColor
                    : Colors.transparent,
                size: Dimens.twenty,
              ),
            ),
            keyboardType: TextInputType.phone,
            maxLines: 1,
            style: AppStyles.style14Normal.copyWith(
              color: Theme.of(Get.context!).textTheme.bodyText1!.color,
            ),
            onChanged: (value) => logic.onPhoneChanged(value),
            onEditingComplete: logic.focusNode.nextFocus,
          ),
        ),
        Padding(
          padding: Dimens.edgeInsets2,
          child: RichText(
            text: TextSpan(
              text: StringValues.enterPhoneHelp,
              style: AppStyles.style12Normal.copyWith(
                color: Theme.of(Get.context!).textTheme.subtitle1!.color,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Column _buildEmailField(BlueTickVerificationController logic) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
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
              hintText: StringValues.email,
              suffixIcon: Icon(
                Icons.check_circle,
                color: logic.email.isNotEmpty
                    ? ColorValues.successColor
                    : Colors.transparent,
                size: Dimens.twenty,
              ),
            ),
            keyboardType: TextInputType.emailAddress,
            maxLines: 1,
            style: AppStyles.style14Normal.copyWith(
              color: Theme.of(Get.context!).textTheme.bodyText1!.color,
            ),
            onChanged: (value) => logic.onEmailChanged(value),
            onEditingComplete: logic.focusNode.nextFocus,
          ),
        ),
        Padding(
          padding: Dimens.edgeInsets2,
          child: RichText(
            text: TextSpan(
              text: StringValues.enterEmailHelp,
              style: AppStyles.style12Normal.copyWith(
                color: Theme.of(Get.context!).textTheme.subtitle1!.color,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Column _buildLegalNameField(BlueTickVerificationController logic) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
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
              hintText: StringValues.legalName,
              suffixIcon: Icon(
                Icons.check_circle,
                color: logic.legalName.isNotEmpty
                    ? ColorValues.successColor
                    : Colors.transparent,
                size: Dimens.twenty,
              ),
            ),
            keyboardType: TextInputType.name,
            maxLines: 1,
            style: AppStyles.style14Normal.copyWith(
              color: Theme.of(Get.context!).textTheme.bodyText1!.color,
            ),
            onChanged: (value) => logic.onLegalNameChanged(value),
            onEditingComplete: logic.focusNode.nextFocus,
          ),
        ),
        Padding(
          padding: Dimens.edgeInsets2,
          child: RichText(
            text: TextSpan(
              text: StringValues.enterLegalNameHelp,
              style: AppStyles.style12Normal.copyWith(
                color: Theme.of(Get.context!).textTheme.subtitle1!.color,
              ),
            ),
          ),
        ),
      ],
    );
  }

  NxFilledButton _buildSubmitBtn(BlueTickVerificationController logic) {
    return NxFilledButton(
      onTap: () => logic.changePassword(),
      label: StringValues.submit.toUpperCase(),
    );
  }

  _selectCategoryBottomSheet() {
    var categoriesList = StringValues.categoriesList;
    AppUtility.showBottomSheet(
      children: [
        Padding(
          padding: Dimens.edgeInsets8_16,
          child: Text(
            '${StringValues.selectCategory}',
            style: AppStyles.style18Bold.copyWith(
              color: Theme.of(Get.context!).textTheme.bodyText1!.color,
            ),
          ),
        ),
        SingleChildScrollView(
          physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          padding: Dimens.edgeInsets8_16,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: categoriesList
                .map(
                  (item) => NxListTile(
                    title: Text(
                      item,
                      style: AppStyles.style14Bold.copyWith(
                        color:
                            Theme.of(Get.context!).textTheme.bodyText1!.color,
                      ),
                    ),
                    onTap: () {
                      Get.back();
                      Get.find<BlueTickVerificationController>()
                          .onCategoryChanged(item);
                    },
                  ),
                )
                .toList(),
          ),
        )
      ],
    );
  }
}
