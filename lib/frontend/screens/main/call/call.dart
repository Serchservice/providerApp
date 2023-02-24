import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provide/lib.dart';

Color getCallColor(UserCallModel call) {
  if(call.callMode == "Missed"){
    return SColors.red;
  } else if(call.callMode == "Outgoing"){
    return SColors.yellow;
  } else {
    return SColors.green;
  }
}

class SCallBox extends StatelessWidget {
  final UserCallModel callModel;
  const SCallBox({super.key, required this.callModel});
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => Get.to(() => CallHistoryScreen(userID: callModel.callerID,)),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 10),
          decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: Theme.of(context).backgroundColor, width: 2.0)),
            color: Colors.transparent
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: UserAvatar.small(image: callModel.callerImage),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SText(
                      text: callModel.callerName, color: Theme.of(context).primaryColor,
                      size: 18
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        if (callModel.callType == "Video") Icon(
                          CupertinoIcons.video_camera_solid,
                          color: getCallColor(callModel),
                          size: 12
                        ) else if(callModel.callType == "T2FVC") Icon(
                          CupertinoIcons.money_dollar_circle,
                          color: getCallColor(callModel),
                          size: 12
                        ) else Icon(
                          callModel.callMode == "Missed" ? CupertinoIcons.phone_down_fill
                          : callModel.callMode == "Outgoing" ? CupertinoIcons.phone_fill_arrow_up_right
                          : CupertinoIcons.phone_fill_arrow_down_left,
                          color: getCallColor(callModel),
                          size: 12
                        ),
                        const SizedBox(width: 5),
                        SText(
                          text: callModel.callMode,
                          weight: FontWeight.normal,
                          color: getCallColor(callModel),
                        )
                      ],
                    )
                  ],
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SText(
                    text: TimeFormatter.formatDateTime(callModel.callTime),
                    color: Theme.of(context).primaryColor
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CallScreen extends StatefulWidget {
  CallScreen({super.key});
  final ValueNotifier<int> pageIndex = ValueNotifier(0);
  final ValueNotifier<String> title = ValueNotifier('Messages');

  @override
  State<CallScreen> createState() => _CallScreenState();
}

class _CallScreenState extends State<CallScreen> with WidgetsBindingObserver, TickerProviderStateMixin{
  late TabController tabController;
  UserInformationModel userInformationModel = HiveUserDatabase().getProfileData();
  late final Stream<List<UserCallModel>> _callListStream;
  late final Stream<List<UserCallModel>> _missedCallListStream;
  late final Stream<List<UserCallModel>> _receivedCallListStream;
  late final Stream<List<UserCallModel>> _outgoingCallListStream;
  late List<Widget> callTypePages;

  @override
  void initState() {
    super.initState();

    _callListStream = supabase.from(Supa().callHistory).stream(primaryKey: ['id']).eq("serchID", userInformationModel.serchID)
      .order('created_at').map((maps) => maps.map((map) => UserCallModel.fromMap(map)).toList());
    _missedCallListStream = _callListStream.map((callList) => callList.where((call) => call.callMode == "Missed").toList());
    _receivedCallListStream = _callListStream.map((callList) => callList.where((call) => call.callMode == "Received").toList());
    _outgoingCallListStream = _callListStream.map((callList) => callList.where((call) => call.callMode == "Outgoing").toList());

    callTypePages = [
      AllCallHistoryScreen(userCallModel: _callListStream,),
      ReceivedCallHistoryScreen(userCallModel: _receivedCallListStream,),
      OutgoingCallHistoryScreen(userCallModel: _outgoingCallListStream,),
      MissedCallHistoryScreen(userCallModel: _missedCallListStream,),
    ];

    tabController = TabController(length: callTypePages.length, vsync: this);
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  void onNavigationItemSelected(index) {
    widget.pageIndex.value = index;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: SText.center(text: "Calls", size: 24, weight: FontWeight.bold, color: Theme.of(context).primaryColor),
        actions: [
          IconButton(
            onPressed: (){},
            icon: const Icon(CupertinoIcons.search_circle_fill, color: SColors.light, size: 28)
          ),
          PopupMenuButton<CallPopupMenus>(
            onSelected: (value) {
              // if(value == PopupMenus.signOut){
              //   WLAuth().signOut();
              // }
            },
            elevation: 0,
            color: Theme.of(context).backgroundColor,
            icon: Icon(CupertinoIcons.ellipsis_vertical, size: 20, color: Theme.of(context).primaryColor),
            itemBuilder: (context) => [
              PopupMenuItem(
                value: CallPopupMenus.clear,
                child: SText(text: "Clear", color: Theme.of(context).primaryColor, weight: FontWeight.bold)
              ),
              PopupMenuItem(
                value: CallPopupMenus.deleteAll,
                child: SText(text: "Delete all", color: Theme.of(context).primaryColor, weight: FontWeight.bold)
              )
            ]
          )
        ],
        bottom: PreferredSize(
          preferredSize: Size(MediaQuery.of(context).size.width, 80),
          child: CallModeTab(onItemSelected: onNavigationItemSelected),
        ),
      ),
      body: ValueListenableBuilder(
        valueListenable: widget.pageIndex,
        builder: (BuildContext context, int value, _) {
          return callTypePages[value];
        },
      ),
    );
  }
}

class AllCallHistoryScreen extends StatefulWidget {
  final Stream<List<UserCallModel>> userCallModel;
  const AllCallHistoryScreen({super.key, required this.userCallModel});

  @override
  State<AllCallHistoryScreen> createState() => _AllCallHistoryScreenState();
}

class _AllCallHistoryScreenState extends State<AllCallHistoryScreen> {
  List<UserCallModel> allCallList = HiveUserDatabase().getCallDataList();
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        StreamBuilder<List<UserCallModel>>(
          stream: widget.userCallModel,
          builder: (context, snapshot) {
            if(snapshot.hasData) {
              final callList = snapshot.data!;
              HiveUserDatabase().saveCallDataList(callList);
              return callList.isEmpty ? SliverPadding(
                padding: const EdgeInsets.symmetric(vertical: 200.0),
                sliver: SliverToBoxAdapter(
                  child: Center(child: SText(text: "You have no calls", color: Theme.of(context).primaryColorLight, size: 20)),
                ),
              ) : SliverList(delegate: SliverChildBuilderDelegate(
                (context, index) => SCallBox(callModel: callList[index]),
                childCount: callList.length
              ));
            } else {
              return allCallList.isEmpty ? SliverPadding(
                padding: const EdgeInsets.symmetric(vertical: 200.0),
                sliver: SliverToBoxAdapter(
                  child: Center(child: SText(text: "You have no calls", color: Theme.of(context).primaryColorLight, size: 20)),
                ),
              ) :  SliverList(delegate: SliverChildBuilderDelegate(
                (context, index) => SCallBox(callModel: allCallList[index]),
                childCount: allCallList.length
              ));
            }
          }
        )
      ],
    );
  }
}

class MissedCallHistoryScreen extends StatefulWidget {
  final Stream<List<UserCallModel>> userCallModel;
  const MissedCallHistoryScreen({super.key, required this.userCallModel});

  @override
  State<MissedCallHistoryScreen> createState() => _MissedCallHistoryScreenState();
}

class _MissedCallHistoryScreenState extends State<MissedCallHistoryScreen> {
  List<UserCallModel>? callListLength;
  List<UserCallModel> allCallList = HiveUserDatabase().getCallDataList();
  @override
  Widget build(BuildContext context) {
    final missedCallList = List<UserCallModel>.from(allCallList.where((call) => call.callMode == "Missed"));
    return CustomScrollView(
      slivers: [
        StreamBuilder<List<UserCallModel>>(
          stream: widget.userCallModel,
          builder: (context, snapshot) {
            if(snapshot.hasData) {
              final callList = snapshot.data!;
              return callList.isEmpty ? SliverPadding(
                padding: const EdgeInsets.symmetric(vertical: 200.0),
                sliver: SliverToBoxAdapter(
                  child: Center(child: SText(text: "You have no missed calls", color: Theme.of(context).primaryColorLight, size: 20)),
                ),
              ) : SliverList(delegate: SliverChildBuilderDelegate(
                (context, index) => SCallBox(callModel: callList[index]),
                childCount: callList.length
              ));
            } else {
              return allCallList.isEmpty ? SliverPadding(
                padding: const EdgeInsets.symmetric(vertical: 200.0),
                sliver: SliverToBoxAdapter(
                  child: Center(child: SText(text: "You have no missed calls", color: Theme.of(context).primaryColorLight, size: 20)),
                ),
              ) :  SliverList(delegate: SliverChildBuilderDelegate(
                (context, index) => SCallBox(callModel: missedCallList[index]),
                childCount: missedCallList.length
              ));
            }
          }
        )
      ],
    );
  }
}

class OutgoingCallHistoryScreen extends StatefulWidget {
  final Stream<List<UserCallModel>> userCallModel;
  const OutgoingCallHistoryScreen({super.key, required this.userCallModel});

  @override
  State<OutgoingCallHistoryScreen> createState() => _OutgoingCallHistoryScreenState();
}

class _OutgoingCallHistoryScreenState extends State<OutgoingCallHistoryScreen> {
  List<UserCallModel>? callListLength;
  List<UserCallModel> allCallList = HiveUserDatabase().getCallDataList();
  @override
  Widget build(BuildContext context) {
    final outgoingCallList = List<UserCallModel>.from(allCallList.where((call) => call.callMode == "Outgoing"));
    return CustomScrollView(
      slivers: [
        StreamBuilder<List<UserCallModel>>(
          stream: widget.userCallModel,
          builder: (context, snapshot) {
            if(snapshot.hasData) {
              final callList = snapshot.data!;
              return callList.isEmpty ? SliverPadding(
                padding: const EdgeInsets.symmetric(vertical: 200.0),
                sliver: SliverToBoxAdapter(
                  child: Center(child: SText(text: "You have no outgoing calls", color: Theme.of(context).primaryColorLight, size: 20)),
                ),
              ) : SliverList(delegate: SliverChildBuilderDelegate(
                (context, index) => SCallBox(callModel: callList[index]),
                childCount: callList.length
              ));
            } else {
              return allCallList.isEmpty ? SliverPadding(
                padding: const EdgeInsets.symmetric(vertical: 200.0),
                sliver: SliverToBoxAdapter(
                  child: Center(child: SText(text: "You have no outgoing calls", color: Theme.of(context).primaryColorLight, size: 20)),
                ),
              ) :  SliverList(delegate: SliverChildBuilderDelegate(
                (context, index) => SCallBox(callModel: outgoingCallList[index]),
                childCount: outgoingCallList.length
              ));
            }
          }
        )
      ],
    );
  }
}

class ReceivedCallHistoryScreen extends StatefulWidget {
  final Stream<List<UserCallModel>> userCallModel;
  const ReceivedCallHistoryScreen({super.key, required this.userCallModel});

  @override
  State<ReceivedCallHistoryScreen> createState() => _ReceivedCallHistoryScreenState();
}

class _ReceivedCallHistoryScreenState extends State<ReceivedCallHistoryScreen> {
  List<UserCallModel>? callListLength;
  List<UserCallModel> allCallList = HiveUserDatabase().getCallDataList();
  @override
  Widget build(BuildContext context) {
    final receivedCallList = List<UserCallModel>.from(allCallList.where((call) => call.callMode == "Received"));
    return CustomScrollView(
      slivers: [
        StreamBuilder<List<UserCallModel>>(
          stream: widget.userCallModel,
          builder: (context, snapshot) {
            if(snapshot.hasData) {
              final callList = snapshot.data!;
              return callList.isEmpty ? SliverPadding(
                padding: const EdgeInsets.symmetric(vertical: 200.0),
                sliver: SliverToBoxAdapter(
                  child: Center(child: SText(text: "You have no received calls", color: Theme.of(context).primaryColorLight, size: 20)),
                ),
              ) : SliverList(delegate: SliverChildBuilderDelegate(
                (context, index) => SCallBox(callModel: callList[index]),
                childCount: callList.length
              ));
            } else {
              return allCallList.isEmpty ? SliverPadding(
                padding: const EdgeInsets.symmetric(vertical: 200.0),
                sliver: SliverToBoxAdapter(
                  child: Center(child: SText(text: "You have no received calls", color: Theme.of(context).primaryColorLight, size: 20)),
                ),
              ) :  SliverList(delegate: SliverChildBuilderDelegate(
                (context, index) => SCallBox(callModel: receivedCallList[index]),
                childCount: receivedCallList.length
              ));
            }
          }
        )
      ],
    );
  }
}