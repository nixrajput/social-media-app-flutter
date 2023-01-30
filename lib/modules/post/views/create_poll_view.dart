import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media_app/apis/models/entities/profile.dart';
import 'package:social_media_app/constants/colors.dart';
import 'package:social_media_app/constants/dimens.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/constants/styles.dart';
import 'package:social_media_app/global_widgets/avatar_widget.dart';
import 'package:social_media_app/global_widgets/circle_border.dart';
import 'package:social_media_app/global_widgets/custom_app_bar.dart';
import 'package:social_media_app/global_widgets/unfocus_widget.dart';
import 'package:social_media_app/modules/home/controllers/profile_controller.dart';
import 'package:social_media_app/modules/post/controllers/create_poll_controller.dart';
import 'package:social_media_app/utils/utility.dart';

class CreatePollView extends StatelessWidget {
  const CreatePollView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final profile = ProfileController.find.profileDetails!.user!;

    return UnFocusWidget(
      opaque: true,
      child: Scaffold(
        body: SafeArea(
          child: SizedBox(
            width: Dimens.screenWidth,
            height: Dimens.screenHeight,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildAppBar(profile, context),
                _buildBody(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  NxAppBar _buildAppBar(Profile profile, BuildContext context) {
    return NxAppBar(
      child: Expanded(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AvatarWidget(
              avatar: profile.avatar,
              size: Dimens.twenty,
            ),
            _buildNextBtn(context),
          ],
        ),
      ),
      padding: Dimens.edgeInsetsDefault,
    );
  }

  GestureDetector _buildNextBtn(BuildContext context) {
    return GestureDetector(
      onTap: () => CreatePollController.find.goToPollPreviewPage(),
      child: Container(
        padding: Dimens.edgeInsets8_16,
        decoration: BoxDecoration(
          color: ColorValues.primaryColor,
          borderRadius: BorderRadius.circular(Dimens.four),
        ),
        child: Center(
          child: Text(
            StringValues.next,
            style: AppStyles.style15Bold.copyWith(
              color: Theme.of(context).textTheme.bodyLarge!.color,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Expanded(
      child: GetBuilder<CreatePollController>(
        builder: (logic) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildPostPrivacyPicker(context, logic),
              Expanded(
                child: Container(
                  color: Theme.of(context).cardColor,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      SingleChildScrollView(
                        physics: const BouncingScrollPhysics(
                          parent: AlwaysScrollableScrollPhysics(),
                        ),
                        padding: Dimens.edgeInsetsDefault,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Dimens.boxHeight8,
                            _buildPoll(context, logic),
                            Dimens.boxHeight16,
                          ],
                        ),
                      ),
                      _buildBottomBarMenu(logic, context),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  _showVisibilityPicker() => AppUtility.showBottomSheet(
        children: StringValues.postVisibilityList2
            .map(
              (e) => GetBuilder<CreatePollController>(
                builder: (logic) {
                  return ListTile(
                    onTap: () {
                      AppUtility.closeBottomSheet();
                      logic.onPostVisibilityChange(e);
                    },
                    title: Text(
                      e['title']!,
                      style: AppStyles.style16Bold,
                    ),
                  );
                },
              ),
            )
            .toList(),
      );

  Widget _buildPostPrivacyPicker(
      BuildContext context, CreatePollController logic) {
    return GestureDetector(
      onTap: _showVisibilityPicker,
      child: Padding(
        padding: Dimens.edgeInsetsDefault,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              logic.pollVisibility['title']!,
              style: AppStyles.style14Normal.copyWith(
                color: Theme.of(context).textTheme.bodyLarge!.color,
              ),
            ),
            Dimens.boxWidth8,
            Icon(
              Icons.keyboard_arrow_down,
              size: Dimens.twenty,
            ),
          ],
        ),
      ),
    );
  }

  Column _buildPoll(BuildContext context, CreatePollController logic) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildPollQuestion(context, logic),
        _buildPollOptions(context, logic),
      ],
    );
  }

  Padding _buildPollQuestion(BuildContext context, CreatePollController logic) {
    return Padding(
      padding: Dimens.edgeInsets8_0,
      child: TextFormField(
        decoration: InputDecoration(
          hintText: StringValues.addQuestion,
          border: InputBorder.none,
          disabledBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          focusedErrorBorder: InputBorder.none,
          contentPadding: Dimens.edgeInsets0,
        ),
        style: AppStyles.style16Normal.copyWith(
          color: Theme.of(context).textTheme.bodyLarge!.color,
        ),
        scrollPadding: Dimens.edgeInsets0,
        minLines: 1,
        maxLines: 5,
        maxLength: 500,
        buildCounter: (context,
            {currentLength = 0, isFocused = false, maxLength}) {
          return Dimens.shrinkedBox;
        },
        keyboardType: TextInputType.multiline,
        textCapitalization: TextCapitalization.sentences,
        onChanged: (value) => logic.onChangePollQuestion(value),
      ),
    );
  }

  Widget _buildPollOptions(BuildContext context, CreatePollController logic) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        Dimens.boxHeight8,
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: logic.pollOptionFields.length,
          itemBuilder: (context, index) {
            return logic.pollOptionFields[index];
          },
        ),
        if (logic.pollOptionFields.length < 4)
          _buildAddOptionBtn(context, logic),
        Dimens.boxHeight8,
      ],
    );
  }

  GestureDetector _buildAddOptionBtn(
      BuildContext context, CreatePollController logic) {
    return GestureDetector(
      onTap: () => logic.addPollOption(context),
      child: Container(
        padding: Dimens.edgeInsets8,
        decoration: const BoxDecoration(
          color: ColorValues.primaryColor,
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Icon(
            Icons.add,
            color: ColorValues.whiteColor,
            size: Dimens.twenty,
          ),
        ),
      ),
    );
  }

  _buildPollLengthPicker(BuildContext context) {
    AppUtility.showBottomSheet(
      children: [
        Padding(
          padding: Dimens.edgeInsetsDefault,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                '${StringValues.pollLength}',
                style: AppStyles.style18Bold.copyWith(
                  color: Theme.of(context).textTheme.bodyLarge!.color,
                ),
              ),
              GestureDetector(
                  onTap: AppUtility.closeBottomSheet,
                  child: Text(
                    '${StringValues.done}',
                    style: AppStyles.style18Bold.copyWith(
                      color: ColorValues.primaryColor,
                    ),
                  )),
            ],
          ),
        ),
        GetBuilder<CreatePollController>(
          builder: (logic) {
            return Padding(
              padding: Dimens.edgeInsetsDefault,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _buildDaysPicker(context, logic),
                  _buildHoursPicker(context, logic),
                  _buildMinutesPicker(context, logic),
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  Expanded _buildMinutesPicker(
      BuildContext context, CreatePollController logic) {
    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            StringValues.minutes,
            style: AppStyles.style14Normal.copyWith(
              color: Theme.of(context).textTheme.bodyLarge!.color,
            ),
          ),
          Dimens.boxHeight8,
          Container(
            padding: Dimens.edgeInsets4_8,
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(Dimens.four),
              border: Border.all(
                color: Theme.of(context).dividerColor,
                width: Dimens.one,
              ),
            ),
            child: DropdownButton(
              isExpanded: false,
              value: logic.pollLengthMinutes,
              dropdownColor: Theme.of(context).cardColor,
              elevation: Dimens.two.toInt(),
              borderRadius: BorderRadius.circular(Dimens.four),
              underline: Dimens.shrinkedBox,
              alignment: AlignmentDirectional.center,
              iconSize: Dimens.twenty,
              style: AppStyles.style14Normal.copyWith(
                color: ColorValues.primaryColor,
              ),
              items: StringValues.pollLengthMinutes
                  .map(
                    (e) => DropdownMenuItem(
                      value: e,
                      child: Text(
                        e.toString(),
                        style: AppStyles.style14Normal.copyWith(
                          color: Theme.of(context).textTheme.bodyLarge!.color,
                        ),
                      ),
                    ),
                  )
                  .toList(),
              onChanged: (value) =>
                  logic.onChangePollLengthMinutes(int.parse(value.toString())),
            ),
          ),
        ],
      ),
    );
  }

  Expanded _buildHoursPicker(BuildContext context, CreatePollController logic) {
    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            StringValues.hours,
            style: AppStyles.style14Normal.copyWith(
              color: Theme.of(context).textTheme.bodyLarge!.color,
            ),
          ),
          Dimens.boxHeight8,
          Container(
            padding: Dimens.edgeInsets4_8,
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(Dimens.four),
              border: Border.all(
                color: Theme.of(context).dividerColor,
                width: Dimens.one,
              ),
            ),
            child: DropdownButton(
              isExpanded: false,
              value: logic.pollLengthHours,
              dropdownColor: Theme.of(context).cardColor,
              elevation: Dimens.two.toInt(),
              borderRadius: BorderRadius.circular(Dimens.four),
              underline: Dimens.shrinkedBox,
              alignment: AlignmentDirectional.center,
              iconSize: Dimens.twenty,
              style: AppStyles.style14Normal.copyWith(
                color: ColorValues.primaryColor,
              ),
              items: StringValues.pollLengthHours
                  .map(
                    (e) => DropdownMenuItem(
                      value: e,
                      child: Text(
                        e.toString(),
                        style: AppStyles.style14Normal.copyWith(
                          color: Theme.of(context).textTheme.bodyLarge!.color,
                        ),
                      ),
                    ),
                  )
                  .toList(),
              onChanged: (value) =>
                  logic.onChangePollLengthHours(int.parse(value.toString())),
            ),
          ),
        ],
      ),
    );
  }

  Expanded _buildDaysPicker(BuildContext context, CreatePollController logic) {
    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            StringValues.days,
            style: AppStyles.style14Normal.copyWith(
              color: Theme.of(context).textTheme.bodyLarge!.color,
            ),
          ),
          Dimens.boxHeight8,
          Container(
            padding: Dimens.edgeInsets4_8,
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(Dimens.four),
              border: Border.all(
                color: Theme.of(context).dividerColor,
                width: Dimens.one,
              ),
            ),
            child: DropdownButton(
              isExpanded: false,
              value: logic.pollLengthDays,
              dropdownColor: Theme.of(context).cardColor,
              elevation: Dimens.two.toInt(),
              borderRadius: BorderRadius.circular(Dimens.four),
              underline: Dimens.shrinkedBox,
              alignment: AlignmentDirectional.center,
              iconSize: Dimens.twenty,
              style: AppStyles.style14Normal.copyWith(
                color: ColorValues.primaryColor,
              ),
              items: StringValues.pollLengthDays
                  .map(
                    (e) => DropdownMenuItem(
                      value: e,
                      child: Text(
                        e.toString(),
                        style: AppStyles.style14Normal.copyWith(
                          color: Theme.of(context).textTheme.bodyLarge!.color,
                        ),
                      ),
                    ),
                  )
                  .toList(),
              onChanged: (value) =>
                  logic.onChangePollLengthDays(int.parse(value.toString())),
            ),
          ),
        ],
      ),
    );
  }

  Positioned _buildBottomBarMenu(
      CreatePollController logic, BuildContext context) {
    return Positioned(
      bottom: Dimens.zero,
      left: Dimens.zero,
      right: Dimens.zero,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          Dimens.divider,
          Container(
            padding: Dimens.edgeInsets12,
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    child: _buildPollLength(context, logic),
                  ),
                ),
                Dimens.boxWidth16,
                Row(
                  children: [
                    _buildPollQuestionLength(context, logic),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPollLength(BuildContext context, CreatePollController logic) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          StringValues.pollLength,
          style: AppStyles.style13Normal.copyWith(
            color: Theme.of(context).textTheme.bodyLarge!.color,
          ),
        ),
        Dimens.boxWidth8,
        GestureDetector(
          onTap: () => _buildPollLengthPicker(context),
          child: Padding(
            padding: Dimens.edgeInsetsVertDefault,
            child: Text(
              logic.getDaysHoursMinutes(),
              style: AppStyles.style13Normal.copyWith(
                color: ColorValues.primaryColor,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPollQuestionLength(
      BuildContext context, CreatePollController logic) {
    return NxCircleBorder(
      child: Center(
        child: Text(
          logic.pollQuestion.length.toString(),
          style: AppStyles.style12Bold.copyWith(
            color: Theme.of(context).textTheme.titleMedium!.color,
          ),
        ),
      ),
    );
  }
}
