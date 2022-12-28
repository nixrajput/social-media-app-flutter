import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:social_media_app/constants/colors.dart';
import 'package:social_media_app/constants/dimens.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/constants/styles.dart';
import 'package:social_media_app/global_widgets/custom_app_bar.dart';
import 'package:social_media_app/global_widgets/custom_list_tile.dart';
import 'package:social_media_app/global_widgets/primary_filled_btn.dart';
import 'package:social_media_app/global_widgets/unfocus_widget.dart';
import 'package:social_media_app/modules/verification/verification_controller.dart';
import 'package:social_media_app/utils/utility.dart';

class VerificationView extends StatelessWidget {
  const VerificationView({super.key});

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
                  padding: Dimens.edgeInsetsDefault,
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
    return GetBuilder<VerificationController>(
      builder: (logic) {
        return Expanded(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics(),
            ),
            child: Padding(
              padding: Dimens.edgeInsetsHorizDefault,
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
                    Dimens.boxHeight8,
                    _buildVerifiedOnOtherPlatform(logic),
                    if (logic.isVerifiedOnOtherPlatform) Dimens.boxHeight16,
                    if (logic.isVerifiedOnOtherPlatform)
                      _buildOtherPlatformLinksField(logic),
                    _buildHasWikipediaPage(logic),
                    if (logic.hasWikipediaPage) Dimens.boxHeight16,
                    if (logic.hasWikipediaPage)
                      _buildWikipediaPageLinkField(logic),
                    _buildFeaturedInNewsArticle(logic),
                    if (logic.featuredInNewsArticles) Dimens.boxHeight16,
                    if (logic.featuredInNewsArticles)
                      _buildNewsArticleLinkField(logic),
                    Dimens.boxHeight16,
                    _buildOtherLinksField(logic),
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

  Column _buildOtherLinksField(VerificationController logic) {
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
                borderRadius: BorderRadius.circular(Dimens.four),
              ),
              hintStyle: AppStyles.style14Normal.copyWith(
                color: ColorValues.grayColor,
              ),
              hintText: StringValues.otherLinks,
            ),
            keyboardType: TextInputType.url,
            maxLines: 1,
            style: AppStyles.style14Normal.copyWith(
              color: Theme.of(Get.context!).textTheme.bodyText1!.color,
            ),
            onChanged: (value) => logic.onOtherLinksChanged(value),
            onEditingComplete: logic.focusNode.unfocus,
          ),
        ),
        Padding(
          padding: Dimens.edgeInsets2,
          child: RichText(
            text: TextSpan(
              text: StringValues.otherLinksHelp,
              style: AppStyles.style12Normal.copyWith(
                color: Theme.of(Get.context!).textTheme.subtitle1!.color,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Column _buildNewsArticleLinkField(VerificationController logic) {
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
                borderRadius: BorderRadius.circular(Dimens.four),
              ),
              hintStyle: AppStyles.style14Normal.copyWith(
                color: ColorValues.grayColor,
              ),
              hintText: StringValues.newsArticleLink,
            ),
            keyboardType: TextInputType.url,
            maxLines: 1,
            style: AppStyles.style14Normal.copyWith(
              color: Theme.of(Get.context!).textTheme.bodyText1!.color,
            ),
            onChanged: (value) => logic.onNewsArticlesLinksChanged(value),
            onEditingComplete: logic.focusNode.nextFocus,
          ),
        ),
        Padding(
          padding: Dimens.edgeInsets2,
          child: RichText(
            text: TextSpan(
              text: StringValues.newsArticleLinkHelp,
              style: AppStyles.style12Normal.copyWith(
                color: Theme.of(Get.context!).textTheme.subtitle1!.color,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Row _buildFeaturedInNewsArticle(VerificationController logic) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              StringValues.featuredInNewsArticle,
              style: AppStyles.style14Bold.copyWith(
                color: Theme.of(Get.context!).textTheme.bodyText1!.color,
              ),
            ),
          ),
        ),
        Dimens.boxWidth16,
        Checkbox(
          value: logic.featuredInNewsArticles,
          onChanged: (value) {
            logic.onFeaturedInNewsArticlesChanged(value!);
          },
          activeColor: ColorValues.primaryColor,
          checkColor: Theme.of(Get.context!).scaffoldBackgroundColor,
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
      ],
    );
  }

  Column _buildWikipediaPageLinkField(VerificationController logic) {
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
                borderRadius: BorderRadius.circular(Dimens.four),
              ),
              hintStyle: AppStyles.style14Normal.copyWith(
                color: ColorValues.grayColor,
              ),
              hintText: StringValues.wikiPageLink,
            ),
            keyboardType: TextInputType.url,
            maxLines: 1,
            style: AppStyles.style14Normal.copyWith(
              color: Theme.of(Get.context!).textTheme.bodyText1!.color,
            ),
            onChanged: (value) => logic.onWikipediaPageLinkChanged(value),
            onEditingComplete: logic.focusNode.nextFocus,
          ),
        ),
        Padding(
          padding: Dimens.edgeInsets2,
          child: RichText(
            text: TextSpan(
              text: StringValues.wikiPageLinkHelp,
              style: AppStyles.style12Normal.copyWith(
                color: Theme.of(Get.context!).textTheme.subtitle1!.color,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Row _buildHasWikipediaPage(VerificationController logic) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              StringValues.hasWikiPage,
              style: AppStyles.style14Bold.copyWith(
                color: Theme.of(Get.context!).textTheme.bodyText1!.color,
              ),
            ),
          ),
        ),
        Dimens.boxWidth16,
        Checkbox(
          value: logic.hasWikipediaPage,
          onChanged: (value) {
            logic.onHasWikipediaPageChanged(value!);
          },
          activeColor: ColorValues.primaryColor,
          checkColor: Theme.of(Get.context!).scaffoldBackgroundColor,
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
      ],
    );
  }

  Column _buildOtherPlatformLinksField(VerificationController logic) {
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
                borderRadius: BorderRadius.circular(Dimens.four),
              ),
              hintStyle: AppStyles.style14Normal.copyWith(
                color: ColorValues.grayColor,
              ),
              hintText: StringValues.otherPlatformLinks,
            ),
            keyboardType: TextInputType.url,
            maxLines: 1,
            style: AppStyles.style14Normal.copyWith(
              color: Theme.of(Get.context!).textTheme.bodyText1!.color,
            ),
            onChanged: (value) => logic.onOtherPlatformLinksChanged(value),
            onEditingComplete: logic.focusNode.nextFocus,
          ),
        ),
        Padding(
          padding: Dimens.edgeInsets2,
          child: RichText(
            text: TextSpan(
              text: StringValues.otherPlatformLinksHelp,
              style: AppStyles.style12Normal.copyWith(
                color: Theme.of(Get.context!).textTheme.subtitle1!.color,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Row _buildVerifiedOnOtherPlatform(VerificationController logic) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              StringValues.verifiedOnOtherPlatform,
              style: AppStyles.style14Bold.copyWith(
                color: Theme.of(Get.context!).textTheme.bodyText1!.color,
              ),
            ),
          ),
        ),
        Dimens.boxWidth16,
        Checkbox(
          value: logic.isVerifiedOnOtherPlatform,
          onChanged: (value) {
            logic.onIsVerifiedOnOtherPlatformChanged(value!);
          },
          activeColor: ColorValues.primaryColor,
          checkColor: Theme.of(Get.context!).scaffoldBackgroundColor,
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
      ],
    );
  }

  Column _buildDocumentField(VerificationController logic) {
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
              borderRadius: BorderRadius.circular(Dimens.four),
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

  Column _buildCategoryField(VerificationController logic) {
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
              borderRadius: BorderRadius.circular(Dimens.four),
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

  Column _buildPhoneField(VerificationController logic) {
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
                borderRadius: BorderRadius.circular(Dimens.four),
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
            inputFormatters: [
              LengthLimitingTextInputFormatter(15),
            ],
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

  Column _buildEmailField(VerificationController logic) {
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
                borderRadius: BorderRadius.circular(Dimens.four),
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

  Column _buildLegalNameField(VerificationController logic) {
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
                borderRadius: BorderRadius.circular(Dimens.four),
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
            textCapitalization: TextCapitalization.words,
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

  NxFilledButton _buildSubmitBtn(VerificationController logic) {
    return NxFilledButton(
      onTap: () => logic.changePassword(),
      label: StringValues.send.toUpperCase(),
    );
  }

  _selectCategoryBottomSheet() {
    var categoriesList = StringValues.categoriesList;
    AppUtility.showBottomSheet(
      children: [
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
                      style: AppStyles.style16Bold.copyWith(
                        color:
                            Theme.of(Get.context!).textTheme.bodyText1!.color,
                      ),
                    ),
                    onTap: () {
                      Get.back();
                      Get.find<VerificationController>()
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
