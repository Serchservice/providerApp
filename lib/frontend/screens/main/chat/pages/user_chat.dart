import 'package:animate_do/animate_do.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provide/lib.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

class UserChattingScreen extends StatefulWidget {
  static Route route(
    String id,
    ChatModel chatModel
  ) => MaterialPageRoute(
    builder: (context) => UserChattingScreen(id: id, chatModel: chatModel)
  );

  final String id;
  final ChatModel chatModel;
  const UserChattingScreen({super.key, required this.id, required this.chatModel});

  @override
  State<UserChattingScreen> createState() => _UserChattingScreenState();
}

class _UserChattingScreenState extends State<UserChattingScreen> {
  io.Socket? socket;
  TextEditingController text = TextEditingController();
  ScrollController scroll = ScrollController();
  FlutterSoundRecorder recorder = FlutterSoundRecorder();
  FlutterSoundPlayer player = FlutterSoundPlayer();
  String recordedFile = "";
  bool emojiShowing = false;
  FocusNode focus = FocusNode();
  List<MessageModel> messages = [];

  bool playing = false;
  bool paused = false;
  bool recordingPaused = false;
  bool recording = false;
  bool playBack = false;
  bool playerStarted = false;
  bool sendButton = false;
  Duration playDuration = Duration.zero;
  Duration playPosition = Duration.zero;

  bool ctg = true;

  @override
  void initState() {
    super.initState();
    focus.addListener(() {
      if(focus.hasFocus){
        setState(() => emojiShowing = false);
      }
    }); //Keyboard listener
    // text.addListener(() => setState(() => textControl = text.text)); //Text Listener
    initRecorder().then((value) {
      setState(() { });
    });
    player.openPlayer().then((value) {
      setState(() { });
    });
    connectBackend();
  }

  @override
  void dispose() {
    player.closePlayer();
    recorder.closeRecorder();
    focus.dispose();
    text.dispose();
    super.dispose();
  }

  void connectBackend() {
    socket = io.io(serverLink, <String, dynamic>{
      "transports": ["websocket"],
      "autoConnect": false,
    });
    socket?.connect().onerror(debugShow("Error"));
    socket?.onConnect((data) {
      debugShow(data.toString());
      socket?.on("message", (msg) {
        debugShow(msg);
        setMessageList("source", msg["message"]);
        scroll.animateTo(scroll.position.maxScrollExtent, duration: const Duration(seconds: 1), curve: Curves.easeOut);
      });
    });
    debugShow(socket?.connected);

    socket?.emit("signin", currentUserInfo?.serchID);
    // socket?.emit("/test", "Hello world");
  }

  void sendMessage({required String message, required String senderID, required String receiverID}) {
    setMessageList("source", message);
    socket?.emit("message", {
      "message": message,
      "senderID": senderID,
      "receiverID": receiverID,
    });
    debugShow(socket?.id);
    text.clear();
    setState(() => sendButton = false);
    scroll.animateTo(scroll.position.maxScrollExtent, duration: const Duration(seconds: 1), curve: Curves.easeOut);
  }

  String timeTeller() {
    // DateTime.now().toString().substring(10, 16)
    var hour = DateTime.now().hour;
    var minutes = DateTime.now().minute;
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
      return '5:${minutes.toString()}pm';
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
      return '12:${minutes}am';
    }
  }

  void setMessageList(String type, String message){
    MessageModel messageModel = MessageModel(
      type: type,
      message: message,
      time: timeTeller()
    );
    setState(() {
      messages.add(messageModel);
    });
  }

  Future initRecorder() async {
    final status = await Permission.microphone.request();

    if(status != PermissionStatus.granted){
      await showGetSnackbar(
        message: "Microphone permission is not granted",
        type: Popup.warning,
        duration: const Duration(seconds: 5),
      );
    }
    await recorder.openRecorder();
    recorder.setSubscriptionDuration(const Duration(milliseconds: 500));
  }

  Future startRecording() async {
    await recorder.startRecorder(toFile: recordedFile).then((value) {
      setState(() {});
    }).onError((error, stackTrace) => debugShow(error.toString()));
    setState(() => recording = true);
  }

  Future deleteRecording() async => await recorder.deleteRecord(fileName: recordedFile);

  Future pauseRecording() async {
    setState(() => recordingPaused = !recordingPaused);
    if(recorder.isPaused && recordingPaused){
      await recorder.resumeRecorder();
    } else {
      await recorder.pauseRecorder();
    }
  }

  Future stopRecordingAndSend() async {
    await recorder.stopRecorder().then((value) {
      setState(() {
        playBack = true;
      });
    });
    setState(() => recording = false);
    debugShow("Recorder file: $recordedFile");
  }

  void playRecording() {
    if(playerStarted && playBack && recorder.isStopped && player.isStopped){
      player.startPlayer(fromURI: recordedFile, //codec: kIsWeb ? Codec.opusWebM : Codec.aacADTS,
        whenFinished: () {
          setState(() {});
        }).then((value) {
        setState(() {});
      });
    } else if(player.isPlaying){
      player.pausePlayer();
    } else if(player.isPaused){
      player.resumePlayer();
    }
  }

  void stopPlayer() {
    player.stopPlayer().then((value) {
      setState(() {});
    });
  }

  void open(){
    setState(() => emojiShowing = !emojiShowing);
    if(emojiShowing == true){
      focus.unfocus();
      focus.canRequestFocus = false;
    } else {
      setState(() => emojiShowing = false);
      if(emojiShowing == false){
        focus.requestFocus();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: PreferredSize(
        preferredSize: Size(width, 70),
        child: ChatAppBar(chatModel: widget.chatModel,)
      ),
      body: SizedBox(
        width: width,
        height: height,
        child: Column(
          children: [
            Expanded(
              child: SizedBox(
                height: height - 150,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: ListView.builder(
                    shrinkWrap: true,
                    controller: scroll,
                    itemCount: messages.length + 1,
                    itemBuilder: (context, index){
                      if(index == messages.length){
                        return const SizedBox(height: 70);
                      }
                      if(messages[index].type == "senderID"){
                        return SendMessageCard(
                          message: messages[index].message,
                          messageDate: messages[index].time,
                          messageStatus: messages[index].status == "Sent"
                            ? Icons.done_outlined
                            : messages[index].status == "Waiting" || messages[index].status == "Not Sent"
                            ? Icons.timer_10_select_outlined
                            : Icons.done_all_outlined,
                          iconColor: messages[index].status == "Read"
                          ? SColors.blue
                          : SColors.grey
                        );
                      } else {
                        return SendMessageCard(
                          message: messages[index].message,
                          messageDate: messages[index].time,
                          messageStatus: messages[index].status == "Sent"
                            ? Icons.done_outlined
                            : messages[index].status == "Waiting" || messages[index].status == "Not Sent"
                            ? Icons.timer_10_select_outlined
                            : Icons.done_all_outlined,
                          iconColor: messages[index].status == "Read"
                          ? SColors.blue
                          : SColors.grey
                        );
                        // return ReplyMessageCard(
                        //   message: messages[index].message,
                        //   messageDate: messages[index].time,
                        // );
                      }
                    }
                  ),
                )
              ),
            ),
            // const Align(
            //   alignment: Alignment.bottomCenter,
            //   child: SUBTF()
            // )

            Align(
              alignment: Alignment.bottomCenter,
              child: recording || recorder.isRecording
              ? Container(
                width: MediaQuery.of(context).size.width,
                color: Theme.of(context).backgroundColor,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      recordingPaused || recorder.isPaused
                      ? Container(
                        padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Theme.of(context).scaffoldBackgroundColor,
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                InkWell(
                                  onTap: () => playRecording(),
                                  child: Icon(
                                    playing ? CupertinoIcons.pause_rectangle_fill : CupertinoIcons.arrowtriangle_right_square_fill,
                                    size: 24,
                                    color: SColors.hint
                                  )
                                ),
                                const SizedBox(width: 5),
                                StreamBuilder<PlaybackDisposition>(
                                  stream: player.onProgress,
                                  builder: (context, snapshot){
                                    final duration = snapshot.hasData ? snapshot.data!.duration : Duration.zero;
                                    final twoMinuteDigits = twoDigits(duration.inMinutes.remainder(60));
                                    final twoSecondDigits = twoDigits(duration.inSeconds.remainder(60));
                                    return Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Slider(
                                          min: 0,
                                          activeColor: SColors.hint,
                                          inactiveColor: SColors.hint,
                                          max: playDuration.inSeconds.toDouble(),
                                          value: playPosition.inSeconds.toDouble(),
                                          onChanged: (value) async {}
                                        ),
                                        SText(
                                          text: "$twoMinuteDigits : $twoSecondDigits",
                                          color: Theme.of(context).primaryColor, size: 16,
                                          weight: FontWeight.bold
                                        ),
                                      ],
                                    );
                                  }
                                )
                              ],
                            ),
                            SText(
                              text: playing ? formatTime(playPosition - playDuration) : formatTime(playDuration),
                              color: SColors.hint,
                              size: 16
                            )
                          ]
                        ),
                      )
                      : StreamBuilder<RecordingDisposition>(
                        stream: recorder.onProgress,
                        builder: (context, snapshot) {
                          final duration = snapshot.hasData ? snapshot.data!.duration : Duration.zero;
                          final twoMinuteDigits = twoDigits(duration.inMinutes.remainder(60));
                          final twoSecondDigits = twoDigits(duration.inSeconds.remainder(60));
                          return Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SText(
                                text: "$twoMinuteDigits : $twoSecondDigits",
                                color: Theme.of(context).primaryColor, size: 16,
                                weight: FontWeight.bold
                              ),
                              Row(
                                children: [
                                  const SText.center(
                                    text:  "Recording",
                                    color: SColors.red,
                                    size: 16,
                                    weight: FontWeight.bold
                                  ),
                                  DefaultTextStyle(
                                    style: const TextStyle(
                                      fontSize: 16
                                    ),
                                    child: AnimatedTextKit(
                                      repeatForever: true,
                                      animatedTexts: [
                                        TyperAnimatedText("...")
                                      ],
                                    )
                                  )
                                ],
                              )
                            ]
                          );
                        },
                      ),
                      const SizedBox(height: 20),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const InkWell(
                            child: Icon(
                              CupertinoIcons.trash_fill,
                              size: 24,
                              color: SColors.hint
                            )
                          ),
                          InkWell(
                            onTap: () => pauseRecording(),
                            child: Icon(
                              recordingPaused ? CupertinoIcons.mic_solid : CupertinoIcons.pause_fill,
                              size: 24,
                              color: SColors.red
                            )
                          ),
                          InkWell(
                            onTap: () => stopRecordingAndSend(),
                            child: const CircleAvatar(
                              backgroundColor: SColors.lightPurple,
                              radius: 25,
                              child: Icon(
                                CupertinoIcons.paperplane_fill,
                                color: SColors.white,
                                size: 20
                              ),
                            ),
                          ),
                        ]
                      )
                    ]
                  )
                ),
              )
              : Column(
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
                              onChanged: (value) => value.isNotEmpty
                              ? setState(() => sendButton = true)
                              : setState(() => sendButton = false),
                              decoration: InputDecoration(
                                hintText: "Enter your message",
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
                                suffixIcon: Padding(
                                  padding: const EdgeInsetsDirectional.only(end: 1.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Material(
                                        color: Colors.transparent,
                                        child: InkWell(
                                          // onTap: () => showMore(context),
                                          onTap: () => showMore(context),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Transform.rotate(
                                              angle: 120,
                                              child: Icon(
                                                Icons.attach_file_rounded,
                                                color: Theme.of(context).primaryColorLight,
                                                size: 24
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      if(sendButton == false)
                                      Material(
                                        color: Colors.transparent,
                                        child: InkWell(
                                          // onPressed: () => Get.to(() => const CameraScreen()),
                                          onTap: () => Get.to(() => const CameraScreen()),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Icon(
                                              Icons.camera_alt_rounded,
                                              color: Theme.of(context).primaryColorLight,
                                              size: 24
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
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
                        const SizedBox(width: 10),
                        CircleAvatar(
                          backgroundColor: SColors.lightPurple,
                          radius: 22,
                          child: InkWell(
                            onTap: () => sendButton ? sendMessage(
                              message: text.text,
                              senderID: currentUserInfo!.serchID!,
                              receiverID: widget.chatModel.id,
                            ) : startRecording(),
                            child: Icon(
                              // sendButton ? CupertinoIcons.paperplane_fill : CupertinoIcons.waveform,
                              sendButton ? Icons.send : Icons.mic,
                              color: SColors.white,
                              size: sendButton ? 22 : 26
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  // Offstage(
                  //   offstage: !emojiShowing,
                  emojiShowing ? SlideInUp(child: PickEmoji(text: text,)) : Container()
                ],
              )
            )
          ]
        )
      ),
    );
  }
}
