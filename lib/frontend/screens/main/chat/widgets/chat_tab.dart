import 'package:flutter/material.dart';
import 'package:provide/lib.dart';

class SChatTab extends StatefulWidget {
  const SChatTab({super.key, required this.onItemSelected});
  final ValueChanged<int> onItemSelected;

  @override
  State<SChatTab> createState() => _SChatTabState();
}

class _SChatTabState extends State<SChatTab> {
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
              tabText: "All files",
              // icon: CupertinoIcons.home,
              index: 0,
              onTap: handleItemSelected,
              isSelected: (selectedIndex == 0),
            ),
            STab(
              tabText: "Images",
              // icon: CupertinoIcons.chat_bubble_2_fill,
              index: 1,
              onTap: handleItemSelected,
              isSelected: (selectedIndex == 1),
            ),
            STab(
              tabText: "Videos",
              // icon: CupertinoIcons.phone,
              index: 2,
              onTap: handleItemSelected,
              isSelected: (selectedIndex == 2),
            ),
          ]
        ),
      );
  }
}