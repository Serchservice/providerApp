import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provide/lib.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CallHistoryScreen extends StatefulWidget {
  CallHistoryScreen({super.key, required this.userID});
  final ValueNotifier<int> pageIndex = ValueNotifier(0);
  final String userID;

  @override
  State<CallHistoryScreen> createState() => _CallHistoryScreenState();
}

class _CallHistoryScreenState extends State<CallHistoryScreen> with WidgetsBindingObserver, TickerProviderStateMixin{
  late TabController tabController;
  late List<Widget> userCallHistory;
  late UserInformationModel model;

  @override
  void initState() {
    super.initState();
    userCallHistory = [
      HistoryAllCallScreen(userID: widget.userID),
      HistoryVoiceCallScreen(userID: widget.userID),
      HistoryVideoCallScreen(userID: widget.userID),
      HistoryT2FCallScreen(userID: widget.userID)
    ];
    fetchUser();
    tabController = TabController(length: userCallHistory.length, vsync: this);
    WidgetsBinding.instance.addObserver(this);
  }

  Future<void> fetchUser() async {
    try {
      final result = await supabase.from(SupaUser().profile).select().eq("serchID", widget.userID).single() as Map;
      model = UserInformationModel(
        emailAddress: result["emailAddress"], firstName: result["firstName"], lastName: result["lastName"],
        referLink: result["referLink"], gender: result["gender"], serchAuth: result["serchAuth"], serchID: result["serchID"],
        phoneInfo: UserPhoneInfo.fromJson(result["phoneInfo"] as Map<String, dynamic>), avatar: result["avatar"],
        countryInfo: UserCountryInfo.fromJson(result["countryInfo"] as Map<String, dynamic>),
        password: result["password"], totalRating: result["totalRating"], numberOfRating: result["numberOfRating"],
        totalServiceTrips: result["total_service_trips"], balance: result["balance"], certificate: result["certificate"],
      );
    } on PostgrestException catch (e) {
      showGetSnackbar(message: e.message, type: Popup.error);
    }
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  void onNavigationItemSelected(index) => widget.pageIndex.value = index;

  @override
  Widget build(BuildContext context) {
    List<UserCallModel> callList = HiveUserDatabase().getCallDataList();
    final userModel = List<UserCallModel>.from(callList.where((user) => user.callerID == widget.userID));
    final user = userModel.reduce((value, element) => UserCallModel(
      callerImage: element.callerImage, callerName: element.callerName, callTime: element.callTime
    ));

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(CupertinoIcons.chevron_back, color: Theme.of(context).primaryColorLight, size: 28)
        ),
        actions: [
          IconButton(
            onPressed: () => deleteUser(
              context: context,
              onClick: () {
                Get.offUntil(GetPageRoute(page: () => const BottomNavigator(newPage: 2)), (route) => false);
              }
            ),
            icon: Icon(CupertinoIcons.delete, color: Theme.of(context).primaryColorLight),
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: screenPadding,
            sliver: SliverToBoxAdapter(
              child: Column(
                children: [
                  UserCallHeader(name: user.callerName, image: user.callerImage, rate: double.parse(model.totalRating)),
                  const SizedBox(height: 20),
                ],
              ),
            )
          ),
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Theme.of(context).backgroundColor,
                // borderRadius: const BorderRadius.only(topLeft: Radius.circular(50), topRight: Radius.circular(50))
              ),
              child: UserCallTypeTab(onItemSelected: onNavigationItemSelected,)
            ),
          ),
          ValueListenableBuilder(
            valueListenable: widget.pageIndex,
            builder: (BuildContext context, int value, _) {
              return userCallHistory[value];
            },
          ),
        ],
      ),
    );
  }
}

class HistoryAllCallScreen extends StatelessWidget {
  final String userID;
  const HistoryAllCallScreen({super.key, required this.userID});

  @override
  Widget build(BuildContext context) {
    List<UserCallModel> callList = HiveUserDatabase().getCallDataList();
    final userAllCalls = List<UserCallModel>.from(callList.where((call) => call.callerID == userID));
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        ((context, index) {
          return SCallBox(callModel: userAllCalls[index]);
        }),
        childCount: userAllCalls.length,
      ),
    );
  }
}

class HistoryT2FCallScreen extends StatelessWidget {
  final String userID;
  const HistoryT2FCallScreen({super.key, required this.userID});

  @override
  Widget build(BuildContext context) {
    List<UserCallModel> callList = HiveUserDatabase().getCallDataList();
    final userAllCalls = List<UserCallModel>.from(callList.where((call) => call.callerID == userID));
    final userT2FCalls = List<UserCallModel>.from(userAllCalls.where((call) => call.callType == "T2F"));
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        ((context, index) {
          return SCallBox(callModel: userT2FCalls[index]);
        }),
        childCount: userT2FCalls.length,
      ),
    );
  }
}

class HistoryVideoCallScreen extends StatelessWidget {
  final String userID;
  const HistoryVideoCallScreen({super.key, required this.userID});

  @override
  Widget build(BuildContext context) {
    List<UserCallModel> callList = HiveUserDatabase().getCallDataList();
    final userAllCalls = List<UserCallModel>.from(callList.where((call) => call.callerID == userID));
    final userVideoCalls = List<UserCallModel>.from(userAllCalls.where((call) => call.callType == "Video"));
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        ((context, index) {
          return SCallBox(callModel: userVideoCalls[index]);
        }),
        childCount: userVideoCalls.length,
      ),
    );
  }
}

class HistoryVoiceCallScreen extends StatelessWidget {
  final String userID;
  const HistoryVoiceCallScreen({super.key, required this.userID});

  @override
  Widget build(BuildContext context) {
    List<UserCallModel> callList = HiveUserDatabase().getCallDataList();
    final userAllCalls = List<UserCallModel>.from(callList.where((call) => call.callerID == userID));
    final userVoiceCalls = List<UserCallModel>.from(userAllCalls.where((call) => call.callType == "Voice"));

    return SliverList(
      delegate: SliverChildBuilderDelegate(
        ((context, index) {
          return SCallBox(callModel: userVoiceCalls[index]);
        }),
        childCount: userVoiceCalls.length,
      ),
    );
  }
}