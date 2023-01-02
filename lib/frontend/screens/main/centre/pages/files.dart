import 'dart:async';

import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provide/lib.dart';

class DocsAndFilesScreen extends StatefulWidget {
  DocsAndFilesScreen({super.key});
  final ValueNotifier<int> pageIndex = ValueNotifier(0);
  final ValueNotifier<String> title = ValueNotifier('Messages');

  @override
  State<DocsAndFilesScreen> createState() => _DocsAndFilesScreenState();
}

class _DocsAndFilesScreenState extends State<DocsAndFilesScreen> with WidgetsBindingObserver, TickerProviderStateMixin {
  late TabController tabController;
  ConnectivityResult connectionState = ConnectivityResult.none;
  StreamSubscription? subscription;
  bool isAlert = false;
  bool isDeviceConnected = false;

  //Check ConnectionState everytime
  getConnection(context) => subscription = Connectivity().onConnectivityChanged.listen((ConnectivityResult result) async {
    isDeviceConnected = await InternetConnectionChecker().hasConnection;
    connectionState = await Connectivity().checkConnectivity();
    if(!isDeviceConnected && isAlert == false){
      showConnectionDialogBox(context: context);
      setState(() => isAlert = true);
    }
  });

  showConnectionDialogBox({
    required BuildContext context, double titleSize = 14, double contentSize = 14, FontWeight titleWeight = FontWeight.bold,
    FontWeight contentWeight = FontWeight.normal,
  }) => showCupertinoDialog(
      context: context,
      builder:(context) => StatefulBuilder(
        builder: (context, setState) => CupertinoAlertDialog(
          title: SText(
            text: connectionState == ConnectivityResult.mobile ? "No Mobile Connection"
            : connectionState == ConnectivityResult.wifi ? "No Wifi Connection" : "No Connection",
            size: titleSize, weight: titleWeight, color: SColors.black
          ),
          content: SText(
            text: connectionState == ConnectivityResult.mobile ? "Please check your mobile data connection"
            : connectionState == ConnectivityResult.wifi ? "Please check your wifi connection" : "Please check your internet connection",
            size: contentSize, weight: contentWeight, color: SColors.black
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () async {
                Navigator.pop(context, 'Cancel');
                setState(() => isAlert = false);
                isDeviceConnected = await InternetConnectionChecker().hasConnection;
                if(!isDeviceConnected){
                  showConnectionDialogBox(context: context);
                  setState(() => isAlert = true);
                }
              },
              child: SText(text: "Understood", color: SColors.black, weight: titleWeight, size: titleSize),
            )
          ],
      )
    )
  );

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: filesCount, vsync: this);
    WidgetsBinding.instance.addObserver(this);
    getConnection(context);
  }

  @override
  void dispose() {
    super.dispose();
    subscription?.cancel();
    WidgetsBinding.instance.removeObserver(this);
  }

  void onNavigationItemSelected(index) {
    widget.pageIndex.value = index;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar.large(
            elevation: 0.5,
            leading: IconButton(
              onPressed: () => Get.back(),
              icon: Icon(
                CupertinoIcons.chevron_back,
                color: Theme.of(context).primaryColorLight,
                size: 28
              )
            ),
            title: SText(
              text: "Documents and Files",
              color: Theme.of(context).primaryColorLight,
              size: 40,
              weight: FontWeight.bold
            ),
            expandedHeight: 200,
            bottom: PreferredSize(
              preferredSize: Size(MediaQuery.of(context).size.width, 80),
              child: SFilesTab(onItemSelected: onNavigationItemSelected),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: screenPadding,
              child: ValueListenableBuilder(
                valueListenable: widget.pageIndex,
                builder: (BuildContext context, int value, _) {
                  return files[value];
                },
              )
            ),
          ),
        ],
      )
    );
  }
}