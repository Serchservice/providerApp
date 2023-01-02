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
            onPressed: (){},
            icon: Icon(CupertinoIcons.bookmark, color: Theme.of(context).primaryColorLight),
          ),
          IconButton(
            onPressed: (){},
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
                  const CHH(good: true,),
                  const SizedBox(height: 10),
                  CHHButtons(
                    voiceClick: () {},
                    videoClick: () {},
                    psClick: () {},
                    messageClick: () {},
                  ),
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
              child: Column(
                children: [
                  SCHTab(onItemSelected: onNavigationItemSelected,),
                ],
              )
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