import 'dart:async';

import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app/constants/colors.dart';
import 'package:social_media_app/constants/dimens.dart';
import 'package:social_media_app/constants/styles.dart';
import 'package:social_media_app/global_widgets/circular_progress_indicator.dart';

class CustomControlsWidget extends StatefulWidget {
  final BetterPlayerController? controller;
  final Function(bool visbility)? onControlsVisibilityChanged;
  final bool showControls;
  final bool? isSmallPlayer;
  final VoidCallback? onTap;
  final bool? startVideoWithAudio;

  const CustomControlsWidget({
    Key? key,
    this.controller,
    this.onControlsVisibilityChanged,
    required this.showControls,
    this.isSmallPlayer = false,
    this.onTap,
    this.startVideoWithAudio,
  }) : super(key: key);

  @override
  CustomControlsWidgetState createState() => CustomControlsWidgetState();
}

class CustomControlsWidgetState extends State<CustomControlsWidget> {
  bool isMuted = true;
  Timer? progressTimer;
  int progress = 0;
  int progressMinutes = 0;
  int progressSeconds = 0;
  int totalDuration = 0;
  bool showControls = true;

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

  @override
  void initState() {
    showControls = widget.showControls;
    widget.controller!
        .setVolume(widget.startVideoWithAudio == true ? 0.5 : 0.0);
    widget.controller!.addEventsListener(onPlayerEvent);
    super.initState();
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

  @override
  void dispose() {
    progressTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.controller!.isVideoInitialized() == false) {
      return const Positioned.fill(
        child: Center(
          child: NxCircularProgressIndicator(
            color: ColorValues.whiteColor,
          ),
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
        child: Material(
          color: Colors.transparent,
          child: Stack(
            children: [
              Positioned(
                left: 0.0,
                right: 0.0,
                bottom: 0.0,
                child: Container(
                  padding: Dimens.edgeInsets4_8,
                  color: ColorValues.blackColor.withOpacity(0.3),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      RichText(
                        text: TextSpan(
                            children: [
                              TextSpan(text: progressMinutes.toString()),
                              const TextSpan(text: ':'),
                              TextSpan(text: progressSeconds.toString()),
                            ],
                            style: AppStyles.style14Bold.copyWith(
                              color: ColorValues.whiteColor,
                            )),
                      ),
                      if (showControls)
                        Row(
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
                                size: widget.isSmallPlayer!
                                    ? Dimens.twentyFour
                                    : Dimens.twentyFour,
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
                        ),
                    ],
                  ),
                ),
              ),
              if (showControls)
                Align(
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
                        size: widget.isSmallPlayer!
                            ? Dimens.fourtyEight
                            : Dimens.sixty,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
