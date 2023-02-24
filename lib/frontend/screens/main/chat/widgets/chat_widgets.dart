import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart' as foundation;
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:date_time_format/date_time_format.dart';
import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:bubble/bubble.dart';
import 'package:provide/lib.dart';

class DateLabel extends StatelessWidget {
  const DateLabel({super.key, required this.date});
  final String date;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).backgroundColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 12),
            child: Text(
              date,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: SColors.hint,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ChatAppBar extends StatefulWidget {
  final UserInformationModel user;
  const ChatAppBar({super.key, required this.user});

  @override
  State<ChatAppBar> createState() => _ChatAppBarState();
}

class _ChatAppBarState extends State<ChatAppBar> {
  final schedule = UserScheduledListModel(scheduledImage: SImages.user, scheduledTime: "10.00am");
  UserServiceAndPlan serviceAndPlan = HiveUserDatabase().getServiceAndPlanData();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: AppBar(
        elevation: 1,
        leadingWidth: 40,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(CupertinoIcons.chevron_back, color: Theme.of(context).primaryColorLight, size: 28)
        ),
        titleSpacing: 0,
        title: InkWell(
          onTap: () => Get.to(() => UserProfileScreen()),
          child: Row(
            children: [
              UserAvatar.small(image: widget.user.avatar),
              const SizedBox(width: 6),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SText(
                      text: "${widget.user.firstName} ${widget.user.lastName}",
                      color: Theme.of(context).primaryColorLight,
                      weight: FontWeight.bold,
                      size: 18.5,
                      flow: TextOverflow.ellipsis
                    ),
                    const SizedBox(height: 3),
                    SText(
                      text: widget.user.service,
                      color: Theme.of(context).primaryColorLight,
                      weight: FontWeight.bold,
                      size: 14
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        actions: [
          const SizedBox(width: 14),
          InkWell(
            // onTap: () => setState(() => ctg = !ctg),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Icon(
                CupertinoIcons.rocket_fill,
                color: serviceAndPlan.onTrip ? SColors.green : Theme.of(context).primaryColorLight,
                size: 22
              ),
            )
          ),
          // if(scheduled)
          // ScheduledBox(user: schedule)
        ],
      ),
    );
  }
}

class PickEmoji extends StatelessWidget {
  final TextEditingController text;
  final double? height;

  const PickEmoji({super.key, required this.text, this.height});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: EmojiPicker(
        textEditingController: text,
        // onEmojiSelected: (category, emoji) {
        //   setState(() {
        //     text.text = text.text + emoji.emoji;
        //   });
        // },
        config: Config(
          columns: 7,
          // Issue: https://github.com/flutter/flutter/issues/28894
          emojiSizeMax: 32 * (foundation.defaultTargetPlatform == TargetPlatform.iOS ? 1.30 : 1.0),
          verticalSpacing: 0,
          horizontalSpacing: 0,
          gridPadding: EdgeInsets.zero,
          initCategory: Category.RECENT,
          bgColor: const Color(0xFFF2F2F2),
          indicatorColor: Colors.blue,
          iconColor: Colors.grey,
          iconColorSelected: Colors.blue,
          backspaceColor: Colors.blue,
          skinToneDialogBgColor: Colors.white,
          skinToneIndicatorColor: Colors.grey,
          enableSkinTones: true,
          showRecentsTab: true,
          recentsLimit: 28,
          replaceEmojiOnLimitExceed: false,
          noRecents: const Text(
            'No Recents',
            style: TextStyle(fontSize: 20, color: Colors.black26),
            textAlign: TextAlign.center,
          ),
          loadingIndicator: const SizedBox.shrink(),
          tabIndicatorAnimDuration: kTabScrollDuration,
          categoryIcons: const CategoryIcons(),
          buttonMode: ButtonMode.MATERIAL,
          checkPlatformCompatibility: true,
        ),
      ),
    );
  }
}

showMore({
  required BuildContext context, void Function()? pickAudio
}) => showModalBottomSheet(
  context: context,
  barrierColor: Colors.transparent,
  backgroundColor: Colors.transparent,
  elevation: 0,
  builder: (context) => StatefulBuilder(
    builder: (context, setState) => Padding(
      padding: const EdgeInsets.only(bottom: 60.0),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Card(
          color: Theme.of(context).backgroundColor,
          margin: const EdgeInsets.all(16),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Wrap(
              spacing: 10,
              runSpacing: 5,
              alignment: WrapAlignment.spaceBetween,
              children: [
                SIconTextButton(
                  icon: Icons.insert_drive_file_rounded,
                  onClick: () => pickFile(
                    context: context, type: FileType.any,
                    allowMultiple: true,
                  ),
                  color: SColors.blue,
                  text: "Document"
                ),
                SIconTextButton(
                  icon: Icons.camera_alt_rounded,
                  onClick: () => Get.to(() => const CameraScreen()),
                  color: SColors.lightPurple,
                  text: "Camera"
                ),
                SIconTextButton(
                  icon: Icons.insert_photo_rounded,
                  onClick: () => pickFile(
                    context: context, type: FileType.image,
                    allowMultiple: true,
                  ),
                  color: SColors.virgo,
                  text: "Gallery"
                ),
                SIconTextButton(
                  icon: Icons.headphones_rounded,
                  onClick: pickAudio,
                  // onClick: () => pickFile(
                  //   context: context, type: FileType.audio,
                  //   allowMultiple: true,
                  // ),
                  color: SColors.aries,
                  text: "Audio"
                ),
              ]
            ),
          ),
        )
      ),
    ),
  )
);

class MessageCard extends StatefulWidget {
  final UserChatModel message;
  const MessageCard({super.key, required this.message,});

  @override
  State<MessageCard> createState() => _MessageCardState();
}

class _MessageCardState extends State<MessageCard> {
  late PlayerController controller;
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
    // if (widget.message.index != null) {
    //   file = File('${widget.message.appDirectory!.path}/audio${widget.message.index}.mp3');
    //   // await file?.writeAsBytes((await rootBundle.load('asset/audio/audio${widget.message.index}.mp3')).buffer.asUint8List());
    // }
    if (widget.message.isAudio && widget.message.message.isEmpty) return;
    // Prepare player with extracting waveform if index is even.
    controller.preparePlayer(path: widget.message.message);
    controller.extractWaveformData(path: widget.message.message);
    // Extracting waveform separately if index is odd.
    // if (widget.message.index?.isOdd ?? false) {
    //   controller.extractWaveformData(
    //     path: widget.message.path ?? file!.path,
    //   );
    // }
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
    if (widget.message.message.isAudioFileName) {
      controller.stopAllPlayers();
    }
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Bubble(
      color: widget.message.isOther ? Theme.of(context).primaryColorDark : Theme.of(context).bottomAppBarColor,
      margin: const BubbleEdges.only(top: 10),
      alignment: widget.message.isOther ? Alignment.topRight : Alignment.topLeft,
      nip: widget.message.isOther ? BubbleNip.rightTop : BubbleNip.leftTop,
      child: Container(
          constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.7),
          child: widget.message.isAudio && (widget.message.message.isNotEmpty) ? Column(
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
                      color: widget.message.isOther ? SColors.white : Theme.of(context).primaryColor,
                    ),
                    // splashColor: Colors.transparent,
                    // highlightColor: Colors.transparent,
                  ),
                  Expanded(
                    child: AudioFileWaveforms(
                      size: Size(MediaQuery.of(context).size.width / 1, 40),
                      playerController: controller,
                      waveformType: WaveformType.fitWidth,
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
                      text: controller.playerState.isPlaying ? "" : widget.message.audioDuration,
                      color: SColors.hint,
                      size: 12, weight: FontWeight.bold
                    ),
                    Row(
                      children: [
                        SText(
                          text: widget.message.msgTime,
                          color: SColors.lightTheme4,
                          size: 11, weight: FontWeight.bold
                        ),
                        if(widget.message.isOther)
                        Row(
                          children: [
                            const SizedBox(width: 6),
                            Icon(
                              widget.message.msgStatus == "Pending"
                              ? Icons.timelapse
                              : widget.message.msgStatus == "Sent"
                              ? Icons.done_rounded
                              : Icons.done_all_rounded,
                              color: widget.message.msgStatus == "Pending"
                              ? SColors.hint
                              : widget.message.msgStatus == "Sent"
                              ? SColors.hint
                              : SColors.green,
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
          : widget.message.isAudio && widget.message.message.isNotEmpty ? const SizedBox.shrink()
          : Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 14, right: 40),
                child: SText(
                  text: widget.message.message,
                  color: widget.message.isOther ? SColors.white : Theme.of(context).primaryColor,
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
                      text: widget.message.msgTime,
                      color: SColors.lightTheme4,
                      size: 11, weight: FontWeight.bold
                    ),
                    if(widget.message.isOther)
                    Row(
                      children: [
                        const SizedBox(width: 6),
                        Icon(
                          widget.message.msgStatus == "Pending"
                          ? Icons.timelapse
                          : widget.message.msgStatus == "Sent"
                          ? Icons.done_rounded
                          : Icons.done_all_rounded,
                          color: widget.message.msgStatus == "Pending"
                          ? SColors.hint
                          : widget.message.msgStatus == "Sent"
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

class MessageTime{
  static String timeAgoSinceDate(int time){
    DateTime notificationDate = DateTime.fromMillisecondsSinceEpoch(time);
    final date = DateTime.now();
    final diff = date.difference(notificationDate);

    if(diff.inDays > 8){
      return DateFormat("dd/MM/yyyy HH:mm:ss").format(notificationDate);
    } else if((diff.inDays / 7).floor() >= 1){
      return "Last Week";
    } else if(diff.inDays >= 2){
      return '${diff.inDays} days ago';
    } else if(diff.inDays >= 1){
      return "1 day ago";
    } else if(diff.inHours >= 2){
      return '${diff.inHours} hours ago';
    } else if(diff.inHours >= 1){
      return '1 hour ago';
    } else if(diff.inMinutes >= 2){
      return '${diff.inMinutes} minutes ago';
    } else if(diff.inMinutes >= 1){
      return '1 minute ago';
    } else if(diff.inSeconds >= 3){
      return '${diff.inSeconds} seconds ago';
    } else {
      return "now";
    }
  }

  static String getPmAm(int time) {
    DateTime notificationDate = DateTime.fromMillisecondsSinceEpoch(time);
    final date = DateTime.now();
    final diff = date.difference(notificationDate);

    if(diff.inHours < 12){
      if(diff.inHours.toString().startsWith("0")){
        return "${diff.inHours.toString()}am";
      }
      return "${diff.inHours}am";
    } else {
      return "${diff.inHours}pm";
    }
  }

  static bool isSameDay(int time){
    DateTime notificationDate = DateTime.fromMillisecondsSinceEpoch(time);
    final date = DateTime.now();
    final diff = date.difference(notificationDate);

    if(diff.inDays > 0){
      return false;
    } else {
      return true;
    }
  }

  static bool isSameMinute(int time){
    DateTime notificationDate = DateTime.fromMillisecondsSinceEpoch(time);
    final date = DateTime.now();
    final diff = date.difference(notificationDate);

    if(diff.inMinutes <= 1){
      return true;
    } else {
      return false;
    }
  }

  static String getRoomId(String a, String b){
    if(a.compareTo(b) > 0){
      return a + b;
    } else {
      return b + a;
    }
  }

  static String getHeaderTime() {
    final dateTime = DateTime.now();
    debugPrint(dateTime.format());
    debugPrint(DateTimeFormat.format(dateTime));
    return "";
  }

  static String getTime() {
    var hour = DateTime.now().hour;
    var minutes = DateTime.now().minute;
    final fifteenAgo = DateTime.now().subtract(const Duration(minutes: 1));
    debugPrint(timeago.format(fifteenAgo));
    if(minutes.toString().length < 2){
      if (hour < 1){
        return '$hour:${minutes}0am';
      } else if(hour == 13){
        return '1:${minutes}0pm';
      } else if(hour == 14){
        return '2:${minutes}0pm';
      } else if(hour == 15){
        return '3:${minutes}0pm';
      } else if(hour == 16){
        return '4:${minutes}0pm';
      } else if(hour == 17){
        return '5:${minutes}0pm';
      } else if(hour == 18){
        return '6:${minutes}0pm';
      } else if(hour == 19){
        return '7:${minutes}0pm';
      } else if(hour == 20){
        return '8:${minutes}0pm';
      } else if(hour == 21){
        return '9:${minutes}0pm';
      } else if(hour == 22){
        return '10:${minutes}0pm';
      } else if(hour == 23){
        return '11:${minutes}0pm';
      } else {
        return '$hour:${minutes}0am';
      }
    } else {
      if (hour < 1){
        return '$hour:${minutes}am';
      } else if(hour == 13){
        return '1:${minutes}pm';
      } else if(hour == 14){
        return '2:${minutes}pm';
      } else if(hour == 15){
        return '3:${minutes}pm';
      } else if(hour == 16){
        return '4:${minutes}pm';
      } else if(hour == 17){
        return '5:${minutes}pm';
      } else if(hour == 18){
        return '6:${minutes}pm';
      } else if(hour == 19){
        return '7:${minutes}pm';
      } else if(hour == 20){
        return '8:${minutes}pm';
      } else if(hour == 21){
        return '9:${minutes}pm';
      } else if(hour == 22){
        return '10:${minutes}pm';
      } else if(hour == 23){
        return '11:${minutes}pm';
      } else {
        return '$hour:${minutes}am';
      }
    }
  }
}