import 'dart:async';
import 'dart:io';

import 'package:animate_do/animate_do.dart';
import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:provide/lib.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;
import 'package:path_provider/path_provider.dart';
import 'package:file_picker/file_picker.dart';
import 'package:timeago/timeago.dart' as timeago;

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  UserInformationModel userInformationModel = HiveUserDatabase().getProfileData();
  late final Stream<List<UserChatRoomModel>> _messagesStream;
  final Map<String, StreamSubscription<UserChatModel>> messageSubscriptions = {};
  List<UserChatRoomModel> _rooms = [];
  // final List<UserChatRoomModel> _chatRooms = HiveUserDatabase().getChatRoomDataList();
  final Map<String, UserInformationModel?> profiles = {};

  @override
  void initState() {
    super.initState();
    getMessages();
  }

  @override
  void dispose() { 
    super.dispose();
    messageSubscriptions.clear();
  }

  Future<void> getMessages() async {
    _messagesStream = supabase.from(Supa().chatRoom).stream(primaryKey: ['room_id', 'id']).order('created_at').map(
      (maps) {
        _rooms = maps.map(UserChatRoomModel.fromRoomParticipants).where(
        (room) => room.otherUserID != userInformationModel.serchID || room.serchID != userInformationModel.serchID).toList();

        for (final room in _rooms) {
          getNewestMessage(context: context, roomId: room.roomID);
          getChatProfile(room.otherUserID, profiles);
        }
        return _rooms;
      }
    );
  }

  // Setup listeners to listen to the most recent message in each room
  void getNewestMessage({required BuildContext context, required String roomId}) {
    messageSubscriptions[roomId] = supabase.from(Supa().messages).stream(primaryKey: ['id']).eq('room_id', roomId).order('created_at')
      .limit(1).map<UserChatModel>((data) => data.isEmpty ? UserChatModel() : UserChatModel.fromMap(
        map: data.first, thisUserId: userInformationModel.serchID)
      ).listen((message) {
        final index = _rooms.indexWhere((room) => room.roomID == roomId);
        _rooms[index] = _rooms[index].copyWith(lastMessage: message);
        _rooms.sort((a, b) {
          /// Sort according to the last message
          /// Use the room createdAt when last message is not available
          final aTimeStamp = a.lastMessage.createdAt ?? a.createdAt;
          final bTimeStamp = b.lastMessage.createdAt ?? b.createdAt;
          return bTimeStamp.compareTo(aTimeStamp);
        });
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar.medium(
            elevation: 0,
            title: SText.center(text: "Chatroom", size: 24, weight: FontWeight.bold, color: Theme.of(context).primaryColor),
            titleSpacing: 0,
            actions: [
              IconButton(
                onPressed: (){},
                icon: const Icon(CupertinoIcons.search_circle_fill, color: SColors.light, size: 40)
              ),
            ],
            expandedHeight: 200,
          ),
          StreamBuilder<List<UserChatRoomModel>>(
            stream: _messagesStream,
            builder: (context, snapshot) {
              if(snapshot.hasData) {
                return _rooms.isEmpty ? SliverPadding(
                  padding: const EdgeInsets.symmetric(vertical: 200.0),
                  sliver: SliverToBoxAdapter(
                    child: Center(child: SText(text: "You have no conversations", color: Theme.of(context).primaryColorLight, size: 20)),
                  ),
                ) : SliverList(delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final room = _rooms[index];
                    final otherUser = profiles[room.otherUserID];
                    return Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () => createOrContinueChat(context, otherUser.serchID, userInformationModel.serchID),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 10),
                          decoration: BoxDecoration(border: Border(bottom: BorderSide(
                            color: Theme.of(context).backgroundColor, width: 2.0
                          ))),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(padding: const EdgeInsets.only(right: 10), child: UserAvatar.medium(image: otherUser!.avatar)),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(child: SText(
                                          text: "${otherUser.firstName} ${otherUser.lastName}",
                                          size: 18, weight: FontWeight.bold,
                                          color: Theme.of(context).primaryColor
                                        )),
                                      ],
                                    ),
                                    const SizedBox(height: 6),
                                    Row(
                                      children: [
                                        Icon(
                                          room.lastMessage.msgStatus == "Sent" ? Icons.done_rounded
                                          : room.lastMessage.msgStatus == "Pending" ? Icons.timelapse_rounded : Icons.done_all_rounded,
                                          size: 18,
                                          color: room.lastMessage.msgStatus == "Sent" ? SColors.hint
                                          : room.lastMessage.msgStatus == "Received" ? SColors.hint
                                          : room.lastMessage.msgStatus == "Pending" ? SColors.hint : SColors.green,
                                        ),
                                        const SizedBox(width: 3),
                                        Expanded(child: SText(
                                          text: room.lastMessage.isAudio ? "Audio ${room.lastMessage.audioDuration}"
                                          : room.lastMessage.message, color: SColors.hint,
                                          size: 16, flow: TextOverflow.ellipsis,
                                        )),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  SText(text: room.lastMessage.msgTime, color: SColors.hint),
                                  const SizedBox(height: 10),
                                  CircleAvatar(radius: 5, backgroundColor: Theme.of(context).primaryColorDark)
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  childCount: _rooms.length,
                ));
              } else {
                return SliverPadding(
                  padding: const EdgeInsets.symmetric(vertical: 200.0),
                  sliver: SliverToBoxAdapter(
                    child: Center(child: SText(text: "You have no conversations", color: Theme.of(context).primaryColorLight, size: 20)),
                  ),
                );
              }
            }
          ),
        ],
      )
    );
  }
}

class UserChattingScreen extends StatefulWidget {
  static Route route(
    String roomID,
  ) => MaterialPageRoute(
    builder: (context) => UserChattingScreen(roomID: roomID)
  );

  final String roomID;
  const UserChattingScreen({super.key, required this.roomID});

  @override
  State<UserChattingScreen> createState() => _UserChattingScreenState();
}

class _UserChattingScreenState extends State<UserChattingScreen> {
  io.Socket? socket;
  late Directory appDirectory;
  TextEditingController text = TextEditingController();
  ScrollController scroll = ScrollController();
  late final RecorderController recorder;
  late PlayerController controller;
  late final Stream<List<UserChatModel>> _messagesStream;
  late StreamSubscription<PlayerState> playerStateSubscription;
  FocusNode focus = FocusNode();
  UserInformationModel userInformationModel = HiveUserDatabase().getProfileData();
  late UserInformationModel userProfile;

  Future<void> getMessages() async {
    _messagesStream = supabase.from('messages:room_id=eq.${widget.roomID}').stream(primaryKey: ['id']).order('created_at').map(
      (maps) => maps.map((map) => UserChatModel.fromMap(map: map, thisUserId: userInformationModel.serchID)).toList()
    );
  }

  Future<void> getProfile() async {
    final messages = await _messagesStream.first;
    for (final message in messages) {
      userProfile = await loadProfile(message.otherID);
    }
  }

  Future<UserInformationModel> loadProfile(String userId) async {
    final provider = await supabase.from(Supa().profile).select().eq('id', userId).single();
    final user = await supabase.from(SupaUser().profile).select().eq('id', userId).single();
    final data = provider + user;
    final profile = UserInformationModel.fromMap(data);
    return profile;
  }

  String? path;
  String? musicFile;
  bool isRecording = false;
  bool isRecordingCompleted = false;
  bool isLoading = true;
  bool emojiShowing = false;
  bool isPaused = false;
  bool sendButton = false;
  bool isSender = false;
  Duration playDuration = Duration.zero;
  Duration playPosition = Duration.zero;

  final playerWaveStyle = const PlayerWaveStyle(
    fixedWaveColor: Colors.white54,
    liveWaveColor: Colors.white,
    spacing: 6,
  );

  @override
  void initState() {
    super.initState();
    focus.addListener(() {
      if(focus.hasFocus) setState(() => emojiShowing = false);
    }); //Keyboard listener
    text.addListener(() {
      if(text.value.text.isNotEmpty){
        setState(() => sendButton = true);
      } else {
        setState(() => sendButton = false);
      }
    });
    _getDir();
    _initialiseControllers();
    controller = PlayerController();
    // model = User(
    //   time: DateTime.now().minute.toString(),
    //   isAudio: false,
    //   isSender: false,
    // );
    _preparePlayer();
    playerStateSubscription = controller.onPlayerStateChanged.listen((_) {
      setState(() {});
    });
    connectBackend();
  }

  @override
  void dispose() {
    recorder.dispose();
    focus.dispose();
    text.dispose();
    playerStateSubscription.cancel();
    // if (model.isLastWidget) {
    //   controller.stopAllPlayers();
    // }
    controller.dispose();
    super.dispose();
  }

  void _getDir() async {
    appDirectory = await getApplicationDocumentsDirectory();
    isLoading = false;
    setState(() {});
  }

  void _initialiseControllers() {
    recorder = RecorderController()
      ..androidEncoder = AndroidEncoder.aac
      ..androidOutputFormat = AndroidOutputFormat.mpeg4
      ..iosEncoder = IosEncoder.kAudioFormatMPEG4AAC
      ..sampleRate = 44100;
  }

  void _preparePlayer() async {
    // if (model.index == null && model.path == null) return;
    // // Prepare player with extracting waveform if index is even.
    // controller.preparePlayer(
    //   path: model.path!,
    //   shouldExtractWaveform: model.index?.isEven ?? true,
    // );
    // // Extracting waveform separately if index is odd.
    // if (model.index?.isOdd ?? false) {
    //   controller.extractWaveformData(
    //     path: model.path!,
    //     noOfSamples: playerWaveStyle.getSamplesForWidth(model.width ?? 150),
    //   );
    // }
  }


  void connectBackend() {
    socket = io.io(serverLink, <String, dynamic>{
      "transports": ["websocket"],
      "autoConnect": false,
    });
    socket?.connect().onerror(debugShow("Socket Error in Connection"));
    socket?.onConnect((data) {
      debugShow("Socket Connection: ${data.toString()}");
      socket?.on("message", (msg) {
        debugShow("My message: $msg");
        // setMessageList("source", msg["message"]);
        scroll.animateTo(scroll.position.maxScrollExtent, duration: const Duration(seconds: 1), curve: Curves.easeOut);
      });
    });
    debugShow("Socket Connected: ${socket?.connected}");

    socket?.emit("signin", "currentUserInfo?.serchID");
    // socket?.emit("/test", "Hello world");
  }

  void sendMessage({required String message, required String senderID, required String receiverID}) {
    // setMessageList("source", message);
    socket?.emit("message", {
      "message": message,
      "senderID": senderID,
      "receiverID": receiverID,
    });
    debugShow("Socket ID: ${socket?.id}");
    text.clear();
    setState(() => sendButton = false);
    scroll.animateTo(scroll.position.maxScrollExtent, duration: const Duration(seconds: 1), curve: Curves.easeOut);
    // scroll.animateTo(0, duration: const Duration(seconds: 1), curve: Curves.easeOut);
  }

  timeTeller() {
    final date = DateTime.now();
    if(date.second < 60){
      // final seconds = date.subtract(Duration(seconds: date.second));
      debugPrint(timeago.format(date));
    }
    final fifteenAgo = DateTime.now().subtract(const Duration(minutes: 15));
    debugPrint(timeago.format(fifteenAgo));
  }

  var timeSent = DateTime.now().hour + DateTime.now().minute;

  // void setMessageList(String type, String message){
  //   MessageModel messageModel = MessageModel(
  //     type: type,
  //     message: message,
  //     time: timeTeller()
  //   );
  //   setState(() {
  //     messages.add(messageModel);
  //   });
  // }

  void sendMsg({required UserChatModel model}) {
    setState(() {
      // if(DateTime.now().hour == 3){
      //   messages.add(modelDate!);
      // }
      // messages.add(model);
    });
    text.clear();
    setState(() {
      sendButton = false;
      isSender = !isSender;
    });
    scroll.animateTo(scroll.position.maxScrollExtent, duration: const Duration(seconds: 1), curve: Curves.easeOut);
  }

  //To open emoji picker or keyboard
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

  void startRecording() async {
    try {
      await recorder.record();
      timeTeller();
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      setState(() {
        isRecording = true;
        isPaused = false;
      });
    }
  }

  void pauseRecording() async {
    try {
      if(isRecording){
        await recorder.pause();
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      setState(() {
        isRecording = false;
        isPaused = true;
      });
    }
  }

  void resumeRecording() async {
    try {
      if(isPaused){
        await recorder.record();
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      setState(() {
        isPaused = false;
        isRecording = true;
      });
    }
  }

  void stopRecordingAndSend() async {
    if (isRecording || isPaused) {
      recorder.reset();
      final newPath = await recorder.stop();
      if (newPath != null) {
        isRecordingCompleted = true;
        setState(() => path = newPath);
        sendMsg(model: UserChatModel(
          message: path!,
          msgTime: MessageTime.getTime(),
          isAudio: true,
          isOther: false
        ));
        setState(() {
          isRecording = false;
          isPaused = false;
        });
        debugPrint("Recorded file size: ${File(newPath).lengthSync()}");
        debugPrint(newPath);
      }
    }
  }

  void deleteRecording() {
    recorder.reset();
    recorder.refresh();
    setState(() {
      isRecording = false;
      isPaused = false;
    });
  }

  void _pickFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles();
      if (result != null) {
        musicFile = result.files.single.path;
        setState(() {
          path = musicFile;
        });
        sendMsg(model: UserChatModel(
          message: path!,
          msgTime: MessageTime.getTime(),
          isAudio: true,
          isOther: false
        ));
      } else {
        debugPrint("File not picked");
      }
    } catch (e) {
      debugPrint("File picked error $e");
    }
  }


  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    } else {
      return KeyboardDismisser(
      gestures: const [
        GestureType.onTap,
        GestureType.onPanUpdateDownDirection,
      ],
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: PreferredSize( preferredSize: Size(width, 70), child: ChatAppBar(user: userProfile)
        ),
        body: SafeArea(
          child: SizedBox(
            width: width,
            height: height,
            child: Column(
              children: [
                StreamBuilder<List<UserChatModel>>(
                  stream: _messagesStream,
                  builder: (context, snapshot) {
                    if(snapshot.hasData){
                      final messages = snapshot.data!;
                      return Expanded(
                        child: SizedBox(
                          height: height - 150,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10.0),
                            child: messages.isEmpty ? Center(
                              child: SText(
                                text: "Start conversation with ${userProfile.firstName}",
                                color: Theme.of(context).primaryColor, size: 24
                              )
                            ) : ListView.builder(
                              shrinkWrap: true,
                              controller: scroll,
                              itemCount: messages.length + 1,
                              itemBuilder: (context, index){
                                if(index == messages.length){
                                  return const SizedBox(height: 70);
                                } else {
                                  return MessageCard(message: messages[index]);
                                }
                              }
                            )
                          )
                        )
                      );
                    } else {
                      return SLoader.fallingDot();
                    }
                  }
                ),
                SafeArea(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    color: Theme.of(context).backgroundColor,
                    child: isRecording && isPaused == false
                    ? Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: AudioWaveforms(
                                enableGesture: true,
                                size: Size(MediaQuery.of(context).size.width / 2, 50),
                                recorderController: recorder,
                                waveStyle: WaveStyle(
                                  waveColor: Theme.of(context).primaryColorDark,
                                  extendWaveform: true,
                                  showMiddleLine: false,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12.0),
                                  color: Theme.of(context).scaffoldBackgroundColor,
                                ),
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 1),
                              ),
                            ),
                            const SizedBox(width: 5),
                            HeartBeating(beatsPerMinute: 60, child: const SText(text: "Recording", color: SColors.red, size: 18)),
                          ]
                        ),
                        const SizedBox(height: 20),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () => deleteRecording(),
                              child: const Icon(
                                CupertinoIcons.trash_fill,
                                size: 24,
                                color: SColors.hint
                              )
                            ),
                            InkWell(
                              onTap: () => pauseRecording(),
                              child: const Icon(
                                CupertinoIcons.pause_fill,
                                size: 24,
                                color: SColors.red
                              )
                            ),
                            InkWell(
                              onTap: () => stopRecordingAndSend(),
                              child: const CircleAvatar(
                                backgroundColor: SColors.lightPurple,
                                radius: 22,
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
                    : isRecording == false && isPaused
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Theme.of(context).scaffoldBackgroundColor,
                            ),
        
                            //Play and pause Recorded file
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                if (!controller.playerState.isPaused)
                                InkWell(
                                  onTap: () async {
                                    controller.playerState.isPlaying
                                    ? await controller.pausePlayer()
                                    : await controller.startPlayer(finishMode: FinishMode.loop);
                                  },
                                  child: Icon(
                                    controller.playerState.isPlaying ? Icons.stop : Icons.play_arrow,
                                    size: 32,
                                    color: Theme.of(context).primaryColorDark
                                  )
                                ),
                                // final twoMinuteDigits = twoDigits(duration.inMinutes.remainder(60));
                                //       final twoSecondDigits = twoDigits(duration.inSeconds.remainder(60));
                                const SizedBox(width: 5),
                                Expanded(
                                  child: AudioFileWaveforms(
                                    size: Size(MediaQuery.of(context).size.width / 1, 50),
                                    playerController: controller,
                                    waveformType: WaveformType.fitWidth,
                                    playerWaveStyle: playerWaveStyle,
                                    backgroundColor: Theme.of(context).backgroundColor
                                  ),
                                ),
                                // SText(
                                //   text: recordedIsPlaying ? formatTime(playPosition - playDuration) : formatTime(playDuration),
                                //   color: SColors.hint,
                                //   size: 16
                                // )
                              ]
                            ),
                          ),
                          const SizedBox(height: 20),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                onTap: () => deleteRecording(),
                                child: const Icon(
                                  CupertinoIcons.trash_fill,
                                  size: 24,
                                  color: SColors.hint
                                )
                              ),
                              InkWell(
                                onTap: () => resumeRecording(),
                                child: const Icon(
                                  CupertinoIcons.mic_solid,
                                  size: 24,
                                  color: SColors.red
                                )
                              ),
                              InkWell(
                                onTap: () => stopRecordingAndSend(),
                                child: const CircleAvatar(
                                  backgroundColor: SColors.lightPurple,
                                  radius: 22,
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
                    : Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: SizedBox(
                                child: TextFormField(
                                  focusNode: focus,
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Theme.of(context).primaryColor,
                                  ),
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
                                  // onChanged: (value) => value.isNotEmpty
                                  // ? setState(() => sendButton = true)
                                  // : setState(() => sendButton = false),
                                  decoration: InputDecoration(
                                    hintText: "Start typing...",
                                    hintStyle: const TextStyle(
                                      fontSize: 18,
                                      color: SColors.hint,
                                    ),
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
                                              onTap: () => showMore(context: context, pickAudio: () => _pickFile()),
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
                                          if(isRecording == false)
                                          Material(
                                            color: Colors.transparent,
                                            child: InkWell(
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
                              child: GestureDetector(
                                onTap: () => sendButton ? sendMsg(
                                  model: UserChatModel(
                                    message: text.text,
                                    msgTime: MessageTime.getTime(),
                                    isAudio: false,
                                    isOther: false
                                  ),
                                  // modelDate: DateLabel(model: )
                                ) : startRecording(),
                                child: Icon(
                                  // sendButton ? CupertinoIcons.paperplane_fill : CupertinoIcons.waveform,
                                  sendButton || isRecording ? Icons.send : Icons.mic,
                                  color: SColors.white,
                                  size: sendButton ? 22 : 26
                                ),
                              ),
                            )
                          ],
                        ),
                        emojiShowing ? SlideInUp(child: PickEmoji(text: text, height: height / 2.5)) : Container()
                      ],
                    )
                  )
                )
              ]
            )
          ),
        ),
      ),
    );
    }
  }
}
