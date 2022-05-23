import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NxVideoPlayerWidget extends StatefulWidget {
  final String? url;
  final bool showFullControls;

  const NxVideoPlayerWidget({
    Key? key,
    this.url,
    required this.showFullControls,
  }) : super(key: key);

  @override
  State<NxVideoPlayerWidget> createState() => _NxVideoPlayerWidgetState();
}

class _NxVideoPlayerWidgetState extends State<NxVideoPlayerWidget> {
  late BetterPlayerController _playerController;
  bool isPlaying = false;
  Duration videoTimePlayed = const Duration(seconds: 0);

  @override
  initState() {
    super.initState();
    isPlaying = widget.showFullControls;

    playerControllerShow();
    _playerController.setVolume(0.0);
  }

  playerControllerShow() {
    var betterPlayerDataSource = BetterPlayerDataSource(
      widget.url!.contains("https")
          ? BetterPlayerDataSourceType.network
          : BetterPlayerDataSourceType.file,
      widget.url!,
    );

    _playerController = BetterPlayerController(
      BetterPlayerConfiguration(
        autoPlay: false,
        fit: BoxFit.contain,
        aspectRatio: 1 / 1,
        autoDetectFullscreenAspectRatio: true,
        autoDetectFullscreenDeviceOrientation: true,
        deviceOrientationsOnFullScreen: [
          DeviceOrientation.landscapeLeft,
          DeviceOrientation.landscapeRight,
          DeviceOrientation.portraitUp,
          DeviceOrientation.portraitDown,
        ],
        controlsConfiguration: isPlaying
            ? const BetterPlayerControlsConfiguration()
            : const BetterPlayerControlsConfiguration(
                enableFullscreen: true,
                showControlsOnInitialize: false,
                showControls: false,
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
    return BetterPlayer(
      controller: _playerController,
    );
  }
}
