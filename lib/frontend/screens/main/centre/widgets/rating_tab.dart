import 'package:flutter/material.dart';
import 'package:provide/lib.dart';

class SRatingTab extends StatefulWidget {
  const SRatingTab({super.key, required this.onItemSelected});
  final ValueChanged<int> onItemSelected;

  @override
  State<SRatingTab> createState() => _SRatingTabState();
}

class _SRatingTabState extends State<SRatingTab> {
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
              tabText: "Rating Summary",
              // icon: CupertinoIcons.home,
              index: 0,
              onTap: handleItemSelected,
              isSelected: (selectedIndex == 0),
            ),
            STab(
              tabText: "Good Ratings",
              // icon: CupertinoIcons.chat_bubble_2_fill,
              index: 1,
              onTap: handleItemSelected,
              isSelected: (selectedIndex == 1),
            ),
            STab(
              tabText: "Bad Ratings",
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