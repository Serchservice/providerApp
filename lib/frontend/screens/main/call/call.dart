import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provide/lib.dart';

class CallScreen extends StatefulWidget {
  CallScreen({super.key});
  final ValueNotifier<int> pageIndex = ValueNotifier(0);
  final ValueNotifier<String> title = ValueNotifier('Messages');

  @override
  State<CallScreen> createState() => _CallScreenState();
}

class _CallScreenState extends State<CallScreen> with WidgetsBindingObserver, TickerProviderStateMixin{
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: chatPageCount, vsync: this);
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
        title: SText.center(
          text: "Calls",
          size: 24,
          weight: FontWeight.bold,
          color: Theme.of(context).primaryColor
        ),
        actions: [
          IconButton(
            onPressed: (){},
            icon: const Icon(
              CupertinoIcons.search_circle_fill,
              color: SColors.light,
              size: 28
            )
          ),
          PopupMenuButton<CallPopupMenus>(
            onSelected: (value) {
              // if(value == PopupMenus.signOut){
              //   WLAuth().signOut();
              // }
            },
            elevation: 0,
            color: Theme.of(context).backgroundColor,
            icon: Icon(
              CupertinoIcons.ellipsis_vertical,
              size: 20,
              color: Theme.of(context).primaryColor
            ),
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
          child: STabControl(onItemSelected: onNavigationItemSelected),
        ),
      ),
      body: ValueListenableBuilder(
        valueListenable: widget.pageIndex,
        builder: (BuildContext context, int value, _) {
          return chatPages[value];
        },
      ),
    );
  }
}