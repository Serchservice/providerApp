import 'package:flutter/material.dart';
import 'package:provide/lib.dart';

class SCHTab extends StatefulWidget {
  const SCHTab({super.key, required this.onItemSelected});
  final ValueChanged<int> onItemSelected;

  @override
  State<SCHTab> createState() => _SCHTabState();
}

class _SCHTabState extends State<SCHTab> {
  var selectedIndex = 0;
  void handleItemSelected(int index){
    setState(() {
      selectedIndex = index;
    });
    widget.onItemSelected(index);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            STab(
              tabText: "All Calls",
              // icon: CupertinoIcons.home,
              index: 0,
              onTap: handleItemSelected,
              isSelected: (selectedIndex == 0),
            ),
            STab(
              tabText: "Voice Call",
              // icon: CupertinoIcons.chat_bubble_2_fill,
              index: 1,
              onTap: handleItemSelected,
              isSelected: (selectedIndex == 1),
            ),
            STab(
              tabText: "Video Call",
              // icon: CupertinoIcons.phone,
              index: 2,
              onTap: handleItemSelected,
              isSelected: (selectedIndex == 2),
            ),
            STab(
              tabText: "Tip2Fix Call",
              // icon: CupertinoIcons.phone,
              index: 3,
              onTap: handleItemSelected,
              isSelected: (selectedIndex == 3),
            ),
          ]
        ),
      );
  }
}

class STabControl extends StatefulWidget {
  const STabControl({super.key, required this.onItemSelected});
  final ValueChanged<int> onItemSelected;

  @override
  State<STabControl> createState() => _STabControlState();
}

class _STabControlState extends State<STabControl> {
  var selectedIndex = 0;
  void handleItemSelected(int index){
    setState(() {
      selectedIndex = index;
    });
    widget.onItemSelected(index);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Theme.of(context).bottomAppBarColor,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            STab(
              tabText: "All Sections",
              // icon: CupertinoIcons.home,
              index: 0,
              onTap: handleItemSelected,
              isSelected: (selectedIndex == 0),
            ),
            STab(
              tabText: "Received",
              // icon: CupertinoIcons.chat_bubble_2_fill,
              index: 1,
              onTap: handleItemSelected,
              isSelected: (selectedIndex == 1),
            ),
            STab(
              tabText: "Outgoing",
              // icon: CupertinoIcons.phone,
              index: 2,
              onTap: handleItemSelected,
              isSelected: (selectedIndex == 2),
            ),
            STab(
              tabText: "Missed",
              // icon: CupertinoIcons.settings,
              index: 3,
              onTap: handleItemSelected,
              isSelected: (selectedIndex == 3),
            ),
          ]
        ),
      );
  }
}