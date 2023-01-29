import 'dart:async';
import 'dart:io';

import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app/constants/colors.dart';
import 'package:social_media_app/constants/styles.dart';
import 'package:social_media_app/global_widgets/cached_network_image.dart';
import 'package:social_media_app/global_widgets/custom_colored_box.dart';
import 'package:social_media_app/global_widgets/custom_video_controls.dart';

class NxVideoPlayerWidget extends StatefulWidget {
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

  final BetterPlayerConfiguration? configuration;
  final bool? isSmallPlayer;
  final VoidCallback? onTap;
  final bool showControls;
  final bool? startVideoWithAudio;
  final String? thumbnailUrl;
  final String url;

  @override
  State<NxVideoPlayerWidget> createState() => _NxVideoPlayerWidgetState();
}

class _NxVideoPlayerWidgetState extends State<NxVideoPlayerWidget> {
  final StreamController<bool> _placeholderStreamController =
      StreamController.broadcast();

  late BetterPlayerController _playerController;
  bool _showPlaceholder = true;

  @override
  void dispose() {
    _placeholderStreamController.close();
    super.dispose();
  }

  @override
  initState() {
    super.initState();
    _init();
  }

  void _setPlaceholderVisibleState(bool hidden) {
    _placeholderStreamController.add(hidden);
    _showPlaceholder = hidden;
  }

  Widget _buildVideoPlaceholder() {
    return StreamBuilder<bool>(
      stream: _placeholderStreamController.stream,
      builder: (context, snapshot) {
        return _showPlaceholder
            ? widget.thumbnailUrl != null
                ? widget.thumbnailUrl!.startsWith("http") ||
                        widget.thumbnailUrl!.startsWith("https")
                    ? NxNetworkImage(
                        imageUrl: widget.thumbnailUrl!,
                        imageFit: BoxFit.contain,
                      )
                    : Image.file(
                        File(widget.thumbnailUrl!),
                        fit: BoxFit.contain,
                      )
                : const NxColoredBox()
            : const SizedBox();
      },
    );
  }

  _init() {
    var betterPlayerDataSource = BetterPlayerDataSource(
      widget.url.contains("https") || widget.url.contains("http")
          ? BetterPlayerDataSourceType.network
          : BetterPlayerDataSourceType.file,
      widget.url,
      cacheConfiguration: const BetterPlayerCacheConfiguration(
        useCache: true,
        maxCacheSize: 1024 * 1024 * 1024,
        maxCacheFileSize: 1024 * 1024 * 1024,
        preCacheSize: 1024 * 1024 * 1024,
      ),
    );

    var kDefaultConfiguration = BetterPlayerConfiguration(
      autoDispose: true,
      autoPlay: false,
      fit: BoxFit.contain,
      aspectRatio: 1.0,
      showPlaceholderUntilPlay: true,
      placeholderOnTop: false,
      placeholder: _buildVideoPlaceholder(),
      expandToFill: true,
      errorBuilder: (ctx, errorMessage) => Center(
        child: Text(
          errorMessage!,
          style: AppStyles.style14Normal.copyWith(
            color: ColorValues.errorColor,
          ),
        ),
      ),
      autoDetectFullscreenDeviceOrientation: true,
      autoDetectFullscreenAspectRatio: true,
      playerVisibilityChangedBehavior: (visibilityFraction) async {
        if (_playerController.isPlaying() == true) {
          if (visibilityFraction == 0) {
            await _playerController.pause();
          } else {
            await _playerController.play();
          }
        }
      },
      controlsConfiguration: BetterPlayerControlsConfiguration(
        showControlsOnInitialize: false,
        playerTheme: BetterPlayerTheme.custom,
        customControlsBuilder: (controller, onControlsVisibilityChanged) =>
            CustomControlsWidget(
          controller: controller,
          onControlsVisibilityChanged: onControlsVisibilityChanged,
          showControls: widget.showControls,
          isSmallPlayer: widget.isSmallPlayer,
          onTap: widget.onTap,
          startVideoWithAudio: widget.startVideoWithAudio,
        ),
      ),
    );

    _playerController = BetterPlayerController(kDefaultConfiguration);
    _playerController.setupDataSource(betterPlayerDataSource);
    _playerController.addEventsListener((event) {
      if (event.betterPlayerEventType == BetterPlayerEventType.play) {
        _setPlaceholderVisibleState(false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BetterPlayer(
      key: widget.key,
      controller: _playerController,
    );
  }
}
