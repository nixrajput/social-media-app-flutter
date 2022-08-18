import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NxVideoPlayerWidget extends StatefulWidget {
  final String? url;
  final BetterPlayerConfiguration? configuration;
  final bool? showControls;

  const NxVideoPlayerWidget({
    Key? key,
    this.url,
    this.configuration,
    this.showControls = true,
  }) : super(key: key);

  @override
  State<NxVideoPlayerWidget> createState() => _NxVideoPlayerWidgetState();
}

class _NxVideoPlayerWidgetState extends State<NxVideoPlayerWidget> {
  late BetterPlayerController _playerController;
  bool showControls = true;
  Duration videoTimePlayed = const Duration(seconds: 0);

  @override
  initState() {
    super.initState();
    showControls = widget.showControls!;
    playerControllerShow();
    _playerController.setVolume(0.5);
    _playerController.addEventsListener((evt) {
      debugPrint('event: ${evt.betterPlayerEventType}');
      if (evt.betterPlayerEventType == BetterPlayerEventType.play) {
        setState(() {
          showControls = false;
        });
      }
    });
  }

  playerControllerShow() {
    var betterPlayerDataSource = BetterPlayerDataSource(
      widget.url!.contains("https")
          ? BetterPlayerDataSourceType.network
          : BetterPlayerDataSourceType.file,
      widget.url!,
    );

    _playerController = BetterPlayerController(
      widget.configuration ??
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
            controlsConfiguration: BetterPlayerControlsConfiguration(
              enableFullscreen: true,
              enablePip: true,
              pipMenuIcon: Icons.picture_in_picture,
              showControlsOnInitialize: false,
              enablePlayPause: false,
              enableSkips: false,
              //controlsHideTime: const Duration(milliseconds: 100),
              showControls: showControls,
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
        setState(() {
          showControls = !showControls;
        });
      },
      child: BetterPlayer(
        controller: _playerController,
      ),
    );
  }
}
