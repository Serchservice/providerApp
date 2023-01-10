import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:get/get.dart';
import 'package:provide/lib.dart';
import 'package:animate_do/animate_do.dart';

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