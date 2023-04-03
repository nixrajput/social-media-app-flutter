import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';
import 'package:social_media_app/constants/colors.dart';
import 'package:social_media_app/constants/dimens.dart';
import 'package:social_media_app/app_widgets/circular_progress_indicator.dart';
import 'package:social_media_app/app_widgets/custom_app_bar.dart';
import 'package:social_media_app/app_widgets/unfocus_widget.dart';

class ImageViewerScreen extends StatelessWidget {
  const ImageViewerScreen({super.key, required this.url});

  final String url;

  @override
  Widget build(BuildContext context) {
    return UnFocusWidget(
      child: Scaffold(
        body: SafeArea(
          child: SizedBox(
            width: Dimens.screenWidth,
            height: Dimens.screenHeight,
            child: Stack(
              children: [
                _buildBody(),
                Positioned(
                  top: Dimens.zero,
                  left: Dimens.zero,
                  right: Dimens.zero,
                  child: NxAppBar(
                    padding: Dimens.edgeInsets8_16,
                    bgColor: Theme.of(context).scaffoldBackgroundColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBody() {
    return Center(
      child: PhotoView(
        backgroundDecoration: BoxDecoration(
          color: Theme.of(Get.context!).scaffoldBackgroundColor,
        ),
        imageProvider: NetworkImage(url),
        wantKeepAlive: true,
        basePosition: Alignment.center,
        initialScale: PhotoViewComputedScale.contained,
        minScale: PhotoViewComputedScale.contained * 0.8,
        maxScale: PhotoViewComputedScale.contained * 5,
        loadingBuilder: (ctx, chunkEvt) => Container(
          width: double.infinity,
          height: Dimens.screenWidth,
          decoration: BoxDecoration(
            color: ColorValues.grayColor.withOpacity(0.25),
          ),
          child: Center(
            child: NxCircularProgressIndicator(
              value: chunkEvt == null
                  ? 0
                  : chunkEvt.cumulativeBytesLoaded /
                      chunkEvt.expectedTotalBytes!,
            ),
          ),
        ),
        errorBuilder: (ctx, url, err) => Container(
          width: double.infinity,
          height: Dimens.screenWidth,
          decoration: BoxDecoration(
            color: ColorValues.grayColor.withOpacity(0.25),
          ),
          child: const Center(
            child: Icon(
              Icons.info,
              color: ColorValues.errorColor,
            ),
          ),
        ),
      ),
    );
  }
}
