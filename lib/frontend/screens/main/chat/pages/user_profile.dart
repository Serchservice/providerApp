import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provide/lib.dart';

class UserProfileScreen extends StatefulWidget {
  UserProfileScreen({super.key});
  final ValueNotifier<int> pageIndex = ValueNotifier(0);
  final ValueNotifier<String> title = ValueNotifier('Messages');

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> with WidgetsBindingObserver, TickerProviderStateMixin{
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: userProfileCount, vsync: this);
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
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(
            CupertinoIcons.chevron_back,
            color: Theme.of(context).primaryColorLight,
            size: 28
          )
        ),
        actions: [
          IconButton(
            onPressed: () => deleteUser(
              context: context,
              onClick: () {
                Get.offUntil(GetPageRoute(page: () => const BottomNavigator(newPage: 1)), (route) => false);
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
                children: const [
                  CHH(),
                  SizedBox(height: 20),
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
              child: SChatTab(onItemSelected: onNavigationItemSelected,)
            ),
          ),
          ValueListenableBuilder(
            valueListenable: widget.pageIndex,
            builder: (BuildContext context, int value, _) {
              return userProfile[value];
            },
          ),
        ],
      ),
    );
  }
}


void deleteUser({required BuildContext context, VoidCallback? onClick}) async {
  return showDialog(
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            backgroundColor: Theme.of(context).backgroundColor,
            elevation: 0,
            title: SText(text: "Are you sure you want to delete this user?.", color: Theme.of(context).primaryColor, size: 16),
            actions: [
              SBtn(
                text: "Delete", textSize: 16,
                buttonColor: Theme.of(context).backgroundColor,
                textColor: SColors.lightPurple,
                onClick: onClick
              ),
              SBtn(
                text: "Don't delete", textSize: 16,
                onClick: () => Navigator.of(context).pop(false),
                buttonColor: Theme.of(context).backgroundColor,
                textColor: SColors.lightPurple,
              )
            ],
          );
        }
      );
    }
  );
}