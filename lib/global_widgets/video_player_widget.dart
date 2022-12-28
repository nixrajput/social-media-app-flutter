import 'dart:io';

import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:social_media_app/global_widgets/cached_network_image.dart';
import 'package:social_media_app/global_widgets/custom_video_controls.dart';

class NxVideoPlayerWidget extends StatefulWidget {
  final String url;
  final String? thumbnailUrl;
  final BetterPlayerConfiguration? configuration;
  final bool showControls;
  final bool? isSmallPlayer;
  final VoidCallback? onTap;
  final bool? startVideoWithAudio;

  const NxVideoPlayerWidget({
    Key? key,
    required this.url,
    this.configuration,
    required this.showControls,
    this.isSmallPlayer = false,
    this.onTap,
    this.startVideoWithAudio,
    this.thumbnailUrl,
  }) : super(key: key);

  @override
  State<NxVideoPlayerWidget> createState() => _NxVideoPlayerWidgetState();
}

class _NxVideoPlayerWidgetState extends State<NxVideoPlayerWidget> {
  late BetterPlayerController _playerController;

  @override
  initState() {
    _init();
    super.initState();
  }

  _init() {
    var betterPlayerDataSource = BetterPlayerDataSource(
        widget.url.contains("https")
            ? BetterPlayerDataSourceType.network
            : BetterPlayerDataSourceType.file,
        widget.url,
        cacheConfiguration: const BetterPlayerCacheConfiguration(
          useCache: true,
        ));

    _playerController = BetterPlayerController(
      widget.configuration ??
          BetterPlayerConfiguration(
            autoDispose: true,
            autoPlay: false,
            fit: BoxFit.cover,
            aspectRatio: 1 / 1,
            autoDetectFullscreenAspectRatio: true,
            showPlaceholderUntilPlay: true,
            placeholderOnTop: true,
            placeholder: widget.thumbnailUrl == null
                ? const SizedBox()
                : widget.thumbnailUrl!.startsWith("http") ||
                        widget.thumbnailUrl!.startsWith("https")
                    ? NxNetworkImage(imageUrl: widget.thumbnailUrl!)
                    : Image.file(File(widget.thumbnailUrl!)),
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
                showControls: widget.showControls,
                isSmallPlayer: widget.isSmallPlayer,
                onTap: widget.onTap,
                startVideoWithAudio: widget.startVideoWithAudio,
              ),
            ),
          ),
      betterPlayerDataSource: betterPlayerDataSource,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BetterPlayer(controller: _playerController);
  }
}
