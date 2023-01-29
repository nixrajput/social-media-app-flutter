import 'dart:async';

import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app/constants/colors.dart';
import 'package:social_media_app/constants/dimens.dart';
import 'package:social_media_app/constants/styles.dart';
import 'package:social_media_app/global_widgets/circular_progress_indicator.dart';
import 'package:social_media_app/global_widgets/custom_colored_box.dart';

class CustomControlsWidget extends StatefulWidget {
  const CustomControlsWidget({
    Key? key,
    this.controller,
    this.onControlsVisibilityChanged,
    required this.showControls,
    this.isSmallPlayer = false,
    this.onTap,
    this.startVideoWithAudio,
  }) : super(key: key);

  final Function(bool visbility)? onControlsVisibilityChanged;
  final BetterPlayerController? controller;
  final bool? isSmallPlayer;
  final VoidCallback? onTap;
  final bool showControls;
  final bool? startVideoWithAudio;

  @override
  CustomControlsWidgetState createState() => CustomControlsWidgetState();
}

class CustomControlsWidgetState extends State<CustomControlsWidget> {
  bool isMuted = true;
  int progress = 0;
  int progressMinutes = 0;
  int progressSeconds = 0;
  Timer? progressTimer;
  bool showControls = true;
  int totalDuration = 0;

  @override
  void dispose() {
    progressTimer?.cancel();
    super.dispose();
  }

  @override
  void initState() {
    showControls = widget.showControls;
    widget.controller!
        .setVolume(widget.startVideoWithAudio == true ? 0.5 : 0.0);
    widget.controller!.addEventsListener(onPlayerEvent);
    super.initState();
  }

  calculateDuration() {
    var splitDur = widget.controller!.videoPlayerController!.value.duration;
    setState(() {
      totalDuration = splitDur!.inSeconds;
    });
  }

  playProgressTimer() {
    const oneSec = Duration(seconds: 1);
    progressTimer = Timer.periodic(oneSec, (timer) {
      setState(() {
        progress++;
        progressSeconds++;
      });
      if (progressSeconds > 59) {
        setState(() {
          progressSeconds = 0;
          progressMinutes++;
        });
      }
      if (progress == totalDuration) {
        setState(() {
          progress = 0;
          progressSeconds = 0;
          progressMinutes = 0;
        });
        timer.cancel();
      }
    });
  }

  pauseProgressTimer() {
    if (progressTimer != null) {
      progressTimer!.cancel();
    }
  }

  resetProgressTimer() {
    setState(() {
      progress = 0;
      progressSeconds = 0;
      progressMinutes = 0;
    });
    if (progressTimer != null) {
      progressTimer!.cancel();
    }
  }

  void onPlayerEvent(BetterPlayerEvent evt) {
    /// AppUtility.log('Video Player Event: ${evt.betterPlayerEventType}');
    if (evt.betterPlayerEventType == BetterPlayerEventType.initialized) {
      if (widget.controller!.videoPlayerController!.value.volume > 0) {
        setState(() {
          isMuted = false;
        });
      }
      calculateDuration();
    }
    if (evt.betterPlayerEventType == BetterPlayerEventType.play) {
      if (widget.controller!.isPlaying() == true) {
        playProgressTimer();
      }
    }

    if (evt.betterPlayerEventType == BetterPlayerEventType.pause) {
      if (widget.controller!.isPlaying() == false) {
        pauseProgressTimer();
      }
    }

    if (evt.betterPlayerEventType == BetterPlayerEventType.finished) {
      resetProgressTimer();
      widget.controller!.seekTo(Duration.zero).then((_) {
        widget.controller!.pause();
      });
    }

    if (evt.betterPlayerEventType == BetterPlayerEventType.progress) {
      if (progressSeconds > 9 &&
          progressSeconds.remainder(10) == 0 &&
          showControls == true) {
        setState(() {
          showControls = false;
        });
      }
    }
  }

  Align _buildPlayPauseControl() {
    return Align(
      alignment: Alignment.center,
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: () {
          setState(() {
            if (widget.controller!.isPlaying() == true) {
              widget.controller!.pause();
            } else {
              widget.controller!.play();
            }
          });
        },
        child: Container(
          decoration: BoxDecoration(
            color: ColorValues.blackColor.withOpacity(0.3),
            shape: BoxShape.circle,
          ),
          child: Icon(
            widget.controller!.isPlaying()!
                ? Icons.pause
                : Icons.play_arrow_rounded,
            color: ColorValues.whiteColor,
            size: widget.isSmallPlayer! ? Dimens.fourtyEight : Dimens.sixty,
          ),
        ),
      ),
    );
  }

  Row _buildBottomControls() {
    return Row(
      children: [
        InkWell(
          onTap: () {
            setState(() {
              isMuted = !isMuted;
              if (isMuted) {
                widget.controller!.setVolume(0.0);
              } else {
                widget.controller!.setVolume(0.5);
              }
            });
          },
          child: Icon(
            isMuted ? Icons.volume_off : Icons.volume_up,
            color: ColorValues.whiteColor,
            size: widget.isSmallPlayer! ? Dimens.twentyFour : Dimens.twentyFour,
          ),
        ),
        Dimens.boxWidth8,
        InkWell(
          child: Icon(
            widget.controller!.isFullScreen
                ? Icons.fullscreen_exit
                : Icons.fullscreen,
            color: Colors.white,
            size: Dimens.twentyFour,
          ),
          onTap: () => setState(() {
            if (widget.isSmallPlayer! == true) {
              widget.onTap!();
              return;
            } else {
              if (widget.controller!.isFullScreen) {
                widget.controller!.exitFullScreen();
              } else {
                widget.controller!.enterFullScreen();
              }
            }
          }),
        ),
      ],
    );
  }

  RichText _buildDurationText() {
    return RichText(
      text: TextSpan(
          children: [
            TextSpan(text: progressMinutes.toString()),
            const TextSpan(text: ':'),
            TextSpan(text: progressSeconds.toString()),
          ],
          style: AppStyles.style14Bold.copyWith(
            color: ColorValues.whiteColor,
          )),
    );
  }

  Material _buildControls() {
    return Material(
      color: Colors.transparent,
      child: Stack(
        children: [
          Positioned(
            left: Dimens.zero,
            right: Dimens.zero,
            bottom: Dimens.zero,
            child: Container(
              padding: Dimens.edgeInsets4_8,
              color: ColorValues.blackColor.withOpacity(0.3),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _buildDurationText(),
                  if (showControls) _buildBottomControls(),
                ],
              ),
            ),
          ),
          if (showControls) _buildPlayPauseControl(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.controller!.isVideoInitialized() == false || !mounted) {
      return const Positioned.fill(
        child: NxColoredBox(
          color: ColorValues.darkGrayColor,
          child: Center(child: NxCircularProgressIndicator()),
        ),
      );
    }
    return Positioned.fill(
      child: GestureDetector(
        onTap: () {
          if (widget.controller!.isPlaying() == true) {
            setState(() {
              showControls = !showControls;
            });
          } else {
            if (widget.isSmallPlayer == true) {
              widget.onTap!.call();
              return;
            }
            setState(() {
              showControls = !showControls;
            });
          }
        },
        onDoubleTap: () {
          if (widget.controller!.isPlaying() == true) {
            widget.controller!.pause();
          } else {
            widget.controller!.play();
          }
        },
        child: _buildControls(),
      ),
    );
  }
}
