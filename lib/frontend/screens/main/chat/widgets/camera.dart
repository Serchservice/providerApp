import 'dart:math';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:animate_do/animate_do.dart';
import 'package:provide/lib.dart';

late List<CameraDescription> cameras;

class CameraScreen extends StatefulWidget{
  const CameraScreen({super.key});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  late CameraController camController;
  bool flash = false;
  bool recording = false;
  bool frontCamera = false;
  double transform = 0;

  //Initialize camera
  void initCamera({int position = 0}) async {
    camController = CameraController(
      cameras[position], ResolutionPreset.high
    );
    try {
      await camController.initialize().then((_) {
      if (!mounted) return;
      setState(() {});
      });
    } on CameraException catch (e) {
      switch (e.code) {
        case 'CameraAccessDenied':
          showGetSnackbar(
            message: e.description!,
            type: Popup.error,
            duration: const Duration(seconds: 5)
          );
          break;
        case 'AudioAccessDenied':
          showGetSnackbar(
            message: e.description!,
            type: Popup.error,
            duration: const Duration(seconds: 5)
          );
          break;
        default:
          showGetSnackbar(
            message: e.description!,
            type: Popup.error,
            duration: const Duration(seconds: 5)
          );
          break;
      }
      debugPrint("camera error $e");
    }
  }

  @override
  void initState() {
    super.initState();
    initCamera();
    setState(() => flash = false);
  }

  @override
  void dispose() {
    camController.dispose();
    super.dispose();
  }

  //Take Picture
  void takePhoto(context) async {
    // final path = join((await getTemporaryDirectory()).path, "${DateTime.now()}.png");
    XFile path = await camController.takePicture();
    if(flash){
      camController.setFlashMode(FlashMode.off);
    }
    Navigator.of(context).push(CameraViewPicture.route(path.path));
  }

  //Start video recording
  void startVideo(context) async {
    // final path = join((await getTemporaryDirectory()).path, "${DateTime.now()}.mp4");
    await camController.startVideoRecording();
    setState(() => recording = true);
  }

  //Stop video recording
  void stopVideo(context) async {
    XFile path = await camController.stopVideoRecording();
    setState(() => recording = false);
    Navigator.of(context).push(CameraViewVideo.route(path.path));
  }

  //Set Flash mode
  void setFlash() {
    setState(() => flash = !flash);
    flash ? camController.setFlashMode(FlashMode.torch)
    : camController.setFlashMode(FlashMode.off);
  }

  //Flip camera
  void flipCamera() async {
    setState(() {
      frontCamera = !frontCamera;
      transform = transform + pi;
    });
    int cameraPosition = frontCamera ? 1 : 0;
    initCamera(position: cameraPosition);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        title: recording ? Padding(
          padding: const EdgeInsets.only(right: 10, top: 10),
          child: Center(
            child: HeartBeating(
              child: const SText(text: "Recording", color: SColors.red, size: 24),
            ),
          ),
        ) : null,
        centerTitle: true,
      ),
      body: !camController.value.isInitialized
      ? Center(child: SLoader.fallingDot(color: SColors.black, size: 60,))
      : Column(
        children: [
          Expanded(child: SizedBox(width: MediaQuery.of(context).size.width, child: CameraPreview(camController))),
          Container(
            width: MediaQuery.of(context).size.width,
            padding: screenPadding,
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    SIB(
                      icon: flash ? Icons.flash_on_outlined : Icons.flash_off_outlined,
                      onClick: () => setFlash(),
                      color: SColors.hint,
                    ),
                    GestureDetector(
                      onLongPress: () => startVideo(context),
                      onLongPressUp: () => stopVideo(context),
                      onTap: () => recording ? null : takePhoto(context),
                      child: Icon(
                        recording ? Icons.radio_button_on_sharp : Icons.camera,
                        size: recording ? 80 : 70,
                        color: recording ? SColors.red : SColors.hint,
                      ),
                    ),
                    Transform.rotate(
                      angle: transform,
                      child: SIB(
                        icon: Icons.flip_camera_ios_outlined,
                        onClick: () => flipCamera(),
                        color: SColors.hint,
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 10),
                SText(
                  text: "Hold for video or tap for photo",
                  color: Theme.of(context).primaryColor,
                  size: 16
                )
              ]
            )
          )
        ],
      )
    );
  }
}

class CameraViewPicture extends StatefulWidget {
  static Route route(
    path
  ) => MaterialPageRoute(builder: (context) => CameraViewPicture(path: path,));

  final String path;
  const CameraViewPicture({super.key, required this.path});

  @override
  State<CameraViewPicture> createState() => _CameraViewPictureState();
}

class _CameraViewPictureState extends State<CameraViewPicture> {
  final text = TextEditingController();
  bool emojiShowing = false;
  FocusNode focus = FocusNode();

  @override
  void initState() {
    super.initState();
    focus.addListener(() {
      if(focus.hasFocus){
        setState(() => emojiShowing = false);
      }
    }); //Keyboard listener
  }

  @override
  void dispose() {
    focus.dispose();
    super.dispose();
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

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    String imagePicture = widget.path;
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
          actions: [
            IconButton(
              onPressed: () async {
                final image = await cropImage(image: imagePicture, context: context);
                if(image == null) return;
                setState(() => imagePicture = image);
              },
              icon: const Icon(
                Icons.crop_rotate_outlined,
                color: SColors.hint
              )
            )
          ],
        ),
        body: WillPopScope(
          onWillPop: () => backClose(),
          child: Stack(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Image.file(
                  File(imagePicture),
                  fit: BoxFit.cover
                )
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(12.0),
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
                                  fillColor: Theme.of(context).scaffoldBackgroundColor,
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
                                      color: Theme.of(context).primaryColorDark,
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