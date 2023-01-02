import 'package:flutter/material.dart';
import 'package:provide/lib.dart';

class SFilesTab extends StatefulWidget {
  const SFilesTab({super.key, required this.onItemSelected});
  final ValueChanged<int> onItemSelected;

  @override
  State<SFilesTab> createState() => _SFilesTabState();
}

class _SFilesTabState extends State<SFilesTab> {
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
              tabText: "All Files",
              // icon: CupertinoIcons.home,
              index: 0,
              onTap: handleItemSelected,
              isSelected: (selectedIndex == 0),
            ),
            STab(
              tabText: "Documents",
              // icon: CupertinoIcons.chat_bubble_2_fill,
              index: 1,
              onTap: handleItemSelected,
              isSelected: (selectedIndex == 1),
            ),
            STab(
              tabText: "Images",
              // icon: CupertinoIcons.phone,
              index: 2,
              onTap: handleItemSelected,
              isSelected: (selectedIndex == 2),
            ),
            STab(
              tabText: "Videos",
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