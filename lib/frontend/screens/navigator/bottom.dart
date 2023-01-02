import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provide/lib.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key, required this.onItemSelected});
  final ValueChanged<int> onItemSelected;

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  var selectedIndex = 1;
  void handleItemSelected(int index){
    setState(() {
      selectedIndex = index;
    });
    widget.onItemSelected(index);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: true,
      child: Container(
        color: Theme.of(context).bottomAppBarColor,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            BottomNavItem(
              label: "Home",
              icon: CupertinoIcons.home,
              index: 0,
              onTap: handleItemSelected,
              isSelected: (selectedIndex == 0),
            ),
            BottomNavItem(
              label: "Chats",
              icon: CupertinoIcons.chat_bubble_2_fill,
              index: 1,
              onTap: handleItemSelected,
              isSelected: (selectedIndex == 1),
            ),
            BottomNavItem(
              label: "Calls",
              icon: CupertinoIcons.phone,
              index: 2,
              onTap: handleItemSelected,
              isSelected: (selectedIndex == 2),
            ),
            BottomNavItem(
              label: "Settings",
              icon: CupertinoIcons.settings,
              index: 3,
              onTap: handleItemSelected,
              isSelected: (selectedIndex == 3),
            ),
            BottomNavItem(
              label: "My Centre",
              icon: CupertinoIcons.person_crop_circle_fill_badge_plus,
              index: 4,
              onTap: handleItemSelected,
              isSelected: (selectedIndex == 4),
            ),
          ]
        ),
      ),
    );
  }
}