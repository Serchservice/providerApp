import 'dart:async';
import 'dart:io';

import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provide/lib.dart';

class MessageCard extends StatefulWidget {
  final MessageModel model;
  const MessageCard({super.key, required this.model,});

  @override
  State<MessageCard> createState() => _MessageCardState();
}

class _MessageCardState extends State<MessageCard> {
  late PlayerController controller;
  File? file;
  late StreamSubscription<PlayerState> playerStateSubscription;

  @override
  void initState() {
    super.initState();
    controller = PlayerController();
    _preparePlayer();
    playerStateSubscription = controller.onPlayerStateChanged.listen((_) {
      setState(() {});
    });
  }

  void _preparePlayer() async {
    if (widget.model.index != null) {
      file = File('${widget.model.appDirectory!.path}/audio${widget.model.index}.mp3');
      // await file?.writeAsBytes((await rootBundle.load('asset/audio/audio${widget.model.index}.mp3')).buffer.asUint8List());
    }
    if (widget.model.index == null && widget.model.path == null && file?.path == null) {
      return;
    }
    // Prepare player with extracting waveform if index is even.
    controller.preparePlayer(
      path: widget.model.path ?? file!.path,
      shouldExtractWaveform: widget.model.index?.isEven ?? true,
    );
    // Extracting waveform separately if index is odd.
    if (widget.model.index?.isOdd ?? false) {
      controller.extractWaveformData(
        path: widget.model.path ?? file!.path,
        noOfSamples: playerWaveStyle.getSamplesForWidth(widget.model.width ?? 200),
      );
    }
  }

  late PlayerWaveStyle playerWaveStyle = const PlayerWaveStyle(
    fixedWaveColor: Colors.white54,
    liveWaveColor: SColors.white,
    spacing: 6,
  );

  String duration() {
    final duration = controller.maxDuration;
    return '${(duration ~/ 36000).toString().padLeft(2, '0')}:${(duration % 60).toString().padLeft(2, '0')}';
  }

  @override
  void dispose() {
    super.dispose();
    playerStateSubscription.cancel();
    if (widget.model.isLastWidget) {
      controller.stopAllPlayers();
    }
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Bubble(
      color: widget.model.isSender ? Theme.of(context).primaryColorDark : Theme.of(context).bottomAppBarColor,
      margin: const BubbleEdges.only(top: 10),
      alignment: widget.model.isSender ? Alignment.topRight : Alignment.topLeft,
      nip: widget.model.isSender ? BubbleNip.rightTop : BubbleNip.leftTop,
      child: Container(
          constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.7),
          child: widget.model.isAudio && (widget.model.path != null || file?.path != null) ? Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  // if (!controller.playerState.isStopped)
                  InkWell(
                    onTap: () async {
                      controller.playerState.isPlaying ? await controller.pausePlayer()
                      : await controller.startPlayer(finishMode: FinishMode.pause);
                    },
                    child: Icon(
                      controller.playerState.isPlaying ? Icons.stop : Icons.play_arrow, size: 35,
                      color: widget.model.isSender ? SColors.white : Theme.of(context).primaryColor,
                    ),
                    // splashColor: Colors.transparent,
                    // highlightColor: Colors.transparent,
                  ),
                  Expanded(
                    child: AudioFileWaveforms(
                      size: Size(MediaQuery.of(context).size.width / 1, 40),
                      playerController: controller,
                      waveformType: widget.model.index?.isOdd ?? false ? WaveformType.fitWidth : WaveformType.fitWidth,
                      playerWaveStyle: playerWaveStyle,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 38.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SText(
                      text: duration(),
                      color: SColors.hint,
                      size: 12, weight: FontWeight.bold
                    ),
                    Row(
                      children: [
                        SText(
                          text: widget.model.time,
                          color: SColors.lightTheme4,
                          size: 11, weight: FontWeight.bold
                        ),
                        if(widget.model.isSender)
                        Row(
                          children: [
                            const SizedBox(width: 6),
                            Icon(
                              widget.model.messageStatus == "Pending"
                              ? Icons.timelapse
                              : widget.model.messageStatus == "Sent"
                              ? Icons.done_rounded
                              : Icons.done_all_rounded,
                              color: widget.model.messageStatus == "Pending"
                              ? SColors.hint
                              : widget.model.messageStatus == "Sent"
                              ? SColors.hint
                              : Scolors.success,
                              size: 18
                            )
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              )
            ],
          )
          : widget.model.isAudio && widget.model.path == null ? const SizedBox.shrink()
          : Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 14, right: 40),
                child: SText(
                  text: widget.model.message!,
                  color: widget.model.isSender ? SColors.white : Theme.of(context).primaryColor,
                  size: 18
                ),
              ),
              Positioned(
                bottom: 0, right: 0,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SText(
                      text: widget.model.time,
                      color: SColors.lightTheme4,
                      size: 11, weight: FontWeight.bold
                    ),
                    if(widget.model.isSender)
                    Row(
                      children: [
                        const SizedBox(width: 6),
                        Icon(
                          widget.model.messageStatus == "Pending"
                          ? Icons.timelapse
                          : widget.model.messageStatus == "Sent"
                          ? Icons.done_rounded
                          : Icons.done_all_rounded,
                          color: widget.model.messageStatus == "Pending"
                          ? SColors.hint
                          : widget.model.messageStatus == "Sent"
                          ? SColors.hint
                          : Scolors.success,
                          size: 18
                        )
                      ],
                    )
                  ],
                )
              )
            ],
          ),
        ),
    );
  }
}