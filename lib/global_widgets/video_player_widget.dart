import 'dart:io';

import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:social_media_app/constants/colors.dart';
import 'package:social_media_app/constants/dimens.dart';
import 'package:social_media_app/global_widgets/custom_video_controls.dart';
import 'package:social_media_app/helpers/utils.dart';

class NxVideoPlayerWidget extends StatefulWidget {
  final String? url;
  final BetterPlayerConfiguration? configuration;
  final bool? showControls;
  final bool? isSmallPlayer;
  final VoidCallback? onTap;

  const NxVideoPlayerWidget({
    Key? key,
    this.url,
    this.configuration,
    this.showControls = true,
    this.isSmallPlayer = false,
    this.onTap,
  }) : super(key: key);

  @override
  State<NxVideoPlayerWidget> createState() => _NxVideoPlayerWidgetState();
}

class _NxVideoPlayerWidgetState extends State<NxVideoPlayerWidget> {
  late BetterPlayerController _playerController;
  bool showControls = true;
  final GlobalKey _betterPlayerKey = GlobalKey();
  String timeLeft = "00:00";
  String duration = "00:00";

  @override
  initState() {
    super.initState();
    showControls = widget.showControls ?? true;
    _init();
    _playerController.setVolume(0.5);

    _playerController.setBetterPlayerGlobalKey(_betterPlayerKey);

    _playerController.addEventsListener((evt) {
      AppUtils.printLog('event: ${evt.betterPlayerEventType}');
      AppUtils.printLog(evt.parameters.toString());
      if (evt.betterPlayerEventType == BetterPlayerEventType.initialized) {
        if (evt.parameters != null && evt.parameters!.containsKey('progress')) {
          var progressMin = evt.parameters!['progress']
              .toString()
              .split(":")[1]
              .toString()
              .substring(0, 2);
          var progressSec = evt.parameters!['progress']
              .toString()
              .split(":")[2]
              .toString()
              .substring(0, 2);
          setState(() {
            timeLeft = "$progressMin:$progressSec";
          });
        }
      }
    });
  }

  _init() async {
    var betterPlayerDataSource = BetterPlayerDataSource(
      widget.url!.contains("https")
          ? BetterPlayerDataSourceType.network
          : BetterPlayerDataSourceType.file,
      widget.url!,
      cacheConfiguration: const BetterPlayerCacheConfiguration(
        useCache: true,
        preCacheSize: 30 * 1024 * 1024,
        maxCacheSize: 30 * 1024 * 1024,
        maxCacheFileSize: 30 * 1024 * 1024,
        key: "videoCacheKey",
      ),
    );

    _playerController = BetterPlayerController(
      widget.configuration ??
          BetterPlayerConfiguration(
            autoDispose: true,
            autoPlay: false,
            fit: BoxFit.cover,
            aspectRatio: 1 / 1,
            autoDetectFullscreenAspectRatio: true,
            showPlaceholderUntilPlay: true,
            placeholder: FutureBuilder<File>(
              future: AppUtils.getVideoThumb(widget.url!),
              builder: (ctx, data) {
                if (data.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (!data.hasData) {
                  return Container(
                    color: ColorValues.grayColor.withOpacity(0.5),
                  );
                }
                return Image.file(
                  data.data!,
                  fit: BoxFit.cover,
                  width: Dimens.screenWidth,
                  height: Dimens.screenWidth,
                );
              },
            ),
            expandToFill: true,
            autoDetectFullscreenDeviceOrientation: true,
            deviceOrientationsOnFullScreen: [
              DeviceOrientation.landscapeLeft,
              DeviceOrientation.landscapeRight,
              DeviceOrientation.portraitUp,
            ],
            controlsConfiguration: BetterPlayerControlsConfiguration(
              showControlsOnInitialize: false,
              playerTheme: BetterPlayerTheme.custom,
              customControlsBuilder:
                  (controller, onControlsVisibilityChanged) =>
                      CustomControlsWidget(
                controller: controller,
                onControlsVisibilityChanged: onControlsVisibilityChanged,
                showControls: showControls,
                timeLeft: timeLeft,
                isSmallPlayer: widget.isSmallPlayer,
              ),
            ),
          ),
      betterPlayerDataSource: betterPlayerDataSource,
    );
  }

  void pause() {
    _playerController.pause();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (_playerController.isPlaying() == true) {
          setState(() {
            showControls = !showControls;
          });
        } else {
          if (widget.isSmallPlayer == true) {
            widget.onTap!.call();
          }
        }
      },
      child: BetterPlayer(
        controller: _playerController,
        key: _betterPlayerKey,
      ),
    );
  }
}
