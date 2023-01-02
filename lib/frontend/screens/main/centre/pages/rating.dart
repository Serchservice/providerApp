import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provide/lib.dart';

class RatingScreen extends StatefulWidget {
  RatingScreen({super.key});
  final ValueNotifier<int> pageIndex = ValueNotifier(0);
  final ValueNotifier<String> title = ValueNotifier('Messages');

  @override
  State<RatingScreen> createState() => _RatingScreenState();
}

class _RatingScreenState extends State<RatingScreen> with WidgetsBindingObserver, TickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: ratingCount, vsync: this);
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
              text: "Ratings",
              color: Theme.of(context).primaryColorLight,
              size: 30,
              weight: FontWeight.bold
            ),
            expandedHeight: 300,
            bottom: PreferredSize(
              preferredSize: Size(MediaQuery.of(context).size.width, 80),
              child: SRatingTab(onItemSelected: onNavigationItemSelected),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: screenPadding,
              child: ValueListenableBuilder(
                valueListenable: widget.pageIndex,
                builder: (BuildContext context, int value, _) {
                  return rating[value];
                },
              )
            ),
          ),
        ],
      )
    );
  }
}