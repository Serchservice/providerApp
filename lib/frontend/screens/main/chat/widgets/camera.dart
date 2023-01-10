import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:get/get.dart';
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

