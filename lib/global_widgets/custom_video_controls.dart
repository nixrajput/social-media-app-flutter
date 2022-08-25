import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app/constants/colors.dart';
import 'package:social_media_app/constants/dimens.dart';

class CustomControlsWidget extends StatefulWidget {
  final BetterPlayerController? controller;
  final Function(bool visbility)? onControlsVisibilityChanged;
  final bool? showControls;
  final String timeLeft;
  final bool? isSmallPlayer;

  const CustomControlsWidget({
    Key? key,
    this.controller,
    this.onControlsVisibilityChanged,
    this.showControls = true,
    required this.timeLeft,
    this.isSmallPlayer = false,
  }) : super(key: key);

  @override
  CustomControlsWidgetState createState() => CustomControlsWidgetState();
}

class CustomControlsWidgetState extends State<CustomControlsWidget> {
  bool isMuted = false;

  @override
  Widget build(BuildContext context) {
    if (widget.showControls! == true) {
      return Positioned.fill(
        child: Material(
          color: Colors.transparent,
          child: Column(
            mainAxisAlignment: widget.isSmallPlayer!
                ? MainAxisAlignment.end
                : MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (widget.isSmallPlayer! == false)
                Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: Dimens.edgeInsetsOnlyTop4.copyWith(
                      right: Dimens.four,
                    ),
                    child: InkWell(
                      child: CircleAvatar(
                        backgroundColor:
                            ColorValues.blackColor.withOpacity(0.75),
                        radius: Dimens.sixTeen,
                        child: Icon(
                          widget.controller!.isFullScreen
                              ? Icons.fullscreen_exit
                              : Icons.fullscreen,
                          color: Colors.white,
                          size: Dimens.twenty,
                        ),
                      ),
                      onTap: () => setState(() {
                        if (widget.controller!.isFullScreen) {
                          widget.controller!.exitFullScreen();
                        } else {
                          widget.controller!.enterFullScreen();
                        }
                      }),
                    ),
                  ),
                ),
              Padding(
                padding: Dimens.edgeInsets8,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          if (widget.controller!.isPlaying()!) {
                            widget.controller!.pause();
                          } else {
                            widget.controller!.play();
                          }
                        });
                      },
                      child: Icon(
                        widget.controller!.isPlaying()!
                            ? Icons.pause
                            : Icons.play_arrow_rounded,
                        color: ColorValues.whiteColor,
                        size: widget.isSmallPlayer!
                            ? Dimens.twentyEight
                            : Dimens.thirtyTwo,
                      ),
                    ),
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
                            ? Dimens.twentyEight
                            : Dimens.thirtyTwo,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }
    return const SizedBox();
  }
}
