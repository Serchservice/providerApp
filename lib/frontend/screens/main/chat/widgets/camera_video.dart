import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:provide/lib.dart';
import 'package:animate_do/animate_do.dart';

class CameraViewVideo extends StatefulWidget {
  static Route route(
    path
  ) => MaterialPageRoute(builder: (context) => CameraViewVideo(path: path,));

  final String path;
  const CameraViewVideo({super.key, required this.path});

  @override
  State<CameraViewVideo> createState() => _CameraViewVideoState();
}

class _CameraViewVideoState extends State<CameraViewVideo> {
  late VideoPlayerController videoController;
  final text = TextEditingController();
  bool emojiShowing = false;
  bool playing = false;
  FocusNode focus = FocusNode();

  @override
  void initState() {
    super.initState();
    focus.addListener(() {
      if(focus.hasFocus){
        setState(() => emojiShowing = false);
      }
    }); //Keyboard listener

    videoController = VideoPlayerController.file(File(widget.path))
    ..initialize().then((_) {
      // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    focus.dispose();
    videoController.dispose();
  }

  void open(){
    setState(() => emojiShowing = !emojiShowing);
    if(emojiShowing == true){
      focus.unfocus();
      focus.canRequestFocus = false;
    } else {
      focus.requestFocus();
    }
  }

  Future<bool> backClose() {
    if(emojiShowing == true){
      setState(() => emojiShowing = false);
    } else {
      Navigator.pop(context);
    }
    return Future.value(false);
  }

  void playVideo() {
    if(videoController.value.isPlaying){
      videoController.pause();
      setState(() => playing = true);
    } else if(videoController.value.isPlaying == false){
      videoController.play();
      setState(() => playing = false);
    }
    // setState(() {
    //   videoController.value.isPlaying ? videoController.pause() : videoController.play();
    // });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return KeyboardDismisser(
      gestures: const [
        GestureType.onTap,
        GestureType.onPanUpdateDownDirection,
      ],
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(
              CupertinoIcons.chevron_back,
              color: SColors.hint,
              size: 28
            )
          ),
        ),
        body: WillPopScope(
          onWillPop: () => backClose(),
          child: Stack(
            children: [
              videoController.value.isInitialized
                ? SizedBox(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: AspectRatio(
                      aspectRatio: videoController.value.aspectRatio,
                      child: SizedBox(
                        // height: MediaQuery.of(context).size.height,
                        // width: MediaQuery.of(context).size.width,
                        child: VideoPlayer(videoController)
                      ),
                    ),
                )
                : Container(),
              Align(
                alignment: Alignment.center,
                child: InkWell(
                  onTap: () => playVideo(),
                  child: CircleAvatar(
                    backgroundColor: Colors.transparent,
                    child: Icon(
                      !videoController.value.isPlaying ? Icons.play_arrow : playing ? Icons.pause : Icons.play_arrow,
                      color: SColors.hint,
                      size: 50,
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: SizedBox(
                              child: TextFormField(
                                focusNode: focus,
                                style: STexts.normalForm(context),
                                cursorColor: Theme.of(context).primaryColor,
                                controller: text,
                                maxLines: 5,
                                minLines: 1,
                                textAlignVertical: TextAlignVertical.center,
                                maxLengthEnforcement: MaxLengthEnforcement.none,
                                textCapitalization: TextCapitalization.sentences,
                                autovalidateMode: AutovalidateMode.onUserInteraction,
                                // enabled: enabled,
                                // textInputAction: TextInputAction.newline,
                                keyboardType: TextInputType.multiline,
                                // validator: validate,
                                onChanged: (value) => debugShow(value.toString()),
                                decoration: InputDecoration(
                                  hintText: "Add Caption...",
                                  hintStyle: STexts.hints(context),
                                  isDense: true,
                                  filled: true,
                                  prefixIcon: InkWell(
                                    onTap: () => open(),
                                    child: Icon(
                                      emojiShowing == false ? FontAwesomeIcons.solidFaceGrin
                                      : FontAwesomeIcons.solidKeyboard
                                      ,
                                      color: SColors.hint
                                    ),
                                  ),
                                  fillColor: Theme.of(context).backgroundColor,
                                  border: InputBorder.none,
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: const BorderRadius.all(Radius.circular(5)),
                                    borderSide: BorderSide(
                                      width: 1.8,
                                      color: Theme.of(context).disabledColor,
                                      style: BorderStyle.solid,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: const BorderRadius.all(Radius.circular(5)),
                                    borderSide: BorderSide(
                                      color: Theme.of(context).primaryColorLight,
                                      width: 1.8,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      color: Theme.of(context).backgroundColor,
                      height: 70,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              padding: const EdgeInsets.all(6.0),
                              decoration: BoxDecoration(
                                color: Scolors.info3,
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Row(
                                children: const [
                                  SText(
                                    text: "Send to",
                                    color: SColors.black,
                                    weight: FontWeight.bold,
                                    size: 14
                                  ),
                                ],
                              )
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                              onTap: () => {},
                              child: Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: SColors.lightPurple,
                                  borderRadius: BorderRadius.circular(50)
                                ),
                                child: const Icon(
                                  CupertinoIcons.paperplane_fill,
                                  color: SColors.white,
                                  size: 20
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    emojiShowing == true ? SlideInUp(child: PickEmoji(text: text, height: height / 2)) : Container()
                  ],
                ),
              ),
            ]
          ),
        ),
      ),
    );
  }
}