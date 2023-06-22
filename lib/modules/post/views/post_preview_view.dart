import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:social_media_app/apis/models/entities/profile.dart';
import 'package:social_media_app/app_widgets/avatar_widget.dart';
import 'package:social_media_app/app_widgets/custom_app_bar.dart';
import 'package:social_media_app/app_widgets/expandable_text_widget.dart';
import 'package:social_media_app/app_widgets/file_image.dart';
import 'package:social_media_app/app_widgets/unfocus_widget.dart';
import 'package:social_media_app/app_widgets/video_player_widget.dart';
import 'package:social_media_app/constants/colors.dart';
import 'package:social_media_app/constants/dimens.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/constants/styles.dart';
import 'package:social_media_app/modules/home/controllers/profile_controller.dart';
import 'package:social_media_app/modules/post/controllers/create_post_controller.dart';
import 'package:social_media_app/routes/route_management.dart';
import 'package:social_media_app/utils/file_utility.dart';

class PostPreviewView extends StatelessWidget {
  const PostPreviewView({Key? key}) : super(key: key);

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
            const Spacer(),
            _buildNextBtn(context),
          ],
        ),
      ),
      padding: Dimens.edgeInsetsDefault,
    );
  }

  GestureDetector _buildNextBtn(BuildContext context) {
    return GestureDetector(
      onTap: () => CreatePostController.find.createNewPost(),
      child: Container(
        padding: Dimens.edgeInsets8_16,
        decoration: BoxDecoration(
          color: ColorValues.primaryColor,
          borderRadius: BorderRadius.circular(Dimens.four),
        ),
        child: Center(
          child: Text(
            StringValues.post,
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
      child: GetBuilder<CreatePostController>(
        builder: (logic) {
          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics(),
            ),
            padding: Dimens.edgeInsetsDefault,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildPost(context, logic),
                Dimens.boxHeight16,
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildPost(BuildContext context, CreatePostController logic) {
    final profile = ProfileController.find.profileDetails!.user!;
    return Container(
      margin: Dimens.edgeInsets8_0,
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(Dimens.four),
        boxShadow: AppStyles.defaultShadow,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildPostHead(context, profile),
          if (logic.caption.isNotEmpty)
            Padding(
              padding: Dimens.edgeInsets8.copyWith(
                top: Dimens.zero,
              ),
              child: NxExpandableText(text: logic.caption),
            ),
          Dimens.boxHeight4,
          _buildPostMedia(context, logic),
          Dimens.boxHeight8,
          _buildPostTime(context),
          Dimens.boxHeight8,
        ],
      ),
    );
  }

  Widget _buildPostHead(BuildContext context, Profile profile) => Padding(
        padding: Dimens.edgeInsets8,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: RouteManagement.goToProfileView,
              child: AvatarWidget(
                avatar: profile.avatar,
                size: Dimens.twenty,
              ),
            ),
            Dimens.boxWidth8,
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildFullName(context, profile),
                  _buildUsername(context, profile),
                ],
              ),
            ),
          ],
        ),
      );

  Widget _buildFullName(BuildContext context, Profile profile) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                child: RichText(
                  text: TextSpan(
                    text: '${profile.fname} ${profile.lname}',
                    style: AppStyles.style14Bold.copyWith(
                      color: Theme.of(context).textTheme.bodyLarge!.color,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = RouteManagement.goToProfileView,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              if (profile.isVerified)
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Dimens.boxWidth4,
                    Icon(
                      Icons.verified,
                      color: ColorValues.primaryColor,
                      size: Dimens.sixTeen,
                    ),
                  ],
                ),
            ],
          ),
        ],
      );

  Widget _buildPostTime(BuildContext context) {
    return Padding(
      padding: Dimens.edgeInsets0_8,
      child: Text(
        DateFormat('dd MMM yyyy hh:mm a').format(DateTime.now().toLocal()),
        style: AppStyles.style12Normal.copyWith(
          color: Theme.of(context).textTheme.titleMedium!.color,
        ),
      ),
    );
  }

  Widget _buildUsername(BuildContext context, Profile profile) => RichText(
        text: TextSpan(
          text: profile.uname,
          style: AppStyles.style13Normal.copyWith(
            color: Theme.of(context).textTheme.titleMedium!.color,
          ),
        ),
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
      );

  Widget _buildPostMedia(BuildContext context, CreatePostController logic) {
    return FlutterCarousel(
      items: logic.pickedFileList.map(
        (media) {
          if (FileUtility.isVideoFile(media.path)) {
            return NxVideoPlayerWidget(
              url: media.path,
              isSmallPlayer: true,
              showControls: true,
              startVideoWithAudio: true,
            );
          }
          return NxFileImage(
            file: media,
            width: Dimens.screenWidth,
          );
        },
      ).toList(),
      options: CarouselOptions(
        height: Dimens.screenWidth * 0.75,
        aspectRatio: 1 / 1,
        viewportFraction: 1.0,
        showIndicator: true,
        floatingIndicator: false,
        slideIndicator: CircularWaveSlideIndicator(
          indicatorRadius: Dimens.four,
          itemSpacing: Dimens.twelve,
        ),
      ),
    );
  }
}
