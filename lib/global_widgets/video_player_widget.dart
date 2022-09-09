import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:social_media_app/global_widgets/custom_video_controls.dart';

class NxVideoPlayerWidget extends StatefulWidget {
  final String? url;
  final BetterPlayerConfiguration? configuration;
  final bool showControls;
  final bool? isSmallPlayer;
  final VoidCallback? onTap;
  final bool? startVideoWithAudio;

  const NxVideoPlayerWidget({
    Key? key,
    this.url,
    this.configuration,
    required this.showControls,
    this.isSmallPlayer = false,
    this.onTap,
    this.startVideoWithAudio = false,
  }) : super(key: key);

  @override
  State<NxVideoPlayerWidget> createState() => _NxVideoPlayerWidgetState();
}

class _NxVideoPlayerWidgetState extends State<NxVideoPlayerWidget> {
  late BetterPlayerController _playerController;
  bool showControls = true;
  final GlobalKey _betterPlayerKey = GlobalKey();

  @override
  initState() {
    super.initState();
    showControls = widget.showControls;
    _init();
    _playerController.setVolume(widget.startVideoWithAudio == true ? 1.0 : 0.0);
    _playerController.setBetterPlayerGlobalKey(_betterPlayerKey);
  }

  _init() async {
    var betterPlayerDataSource = BetterPlayerDataSource(
      widget.url!.contains("https")
          ? BetterPlayerDataSourceType.network
          : BetterPlayerDataSourceType.file,
      widget.url!,
    );

    _playerController = BetterPlayerController(
      widget.configuration ??
          BetterPlayerConfiguration(
            autoDispose: true,
            autoPlay: false,
            fit: BoxFit.cover,
            aspectRatio: 1 / 1,
            autoDetectFullscreenAspectRatio: true,
            showPlaceholderUntilPlay: false,
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
                isSmallPlayer: widget.isSmallPlayer,
                onTap: widget.onTap,
              ),
            ),
          ),
      betterPlayerDataSource: betterPlayerDataSource,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BetterPlayer(
      controller: _playerController,
      key: _betterPlayerKey,
    );
  }
}
