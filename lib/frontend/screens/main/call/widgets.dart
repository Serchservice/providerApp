import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provide/lib.dart';

class UserCallHeader extends StatelessWidget {
  final String name;
  final String image;
  final String category;
  final double rate;
  const UserCallHeader({super.key, this.name = "", this.category = "", this.rate = 0.0, this.image = ""});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(child: UserAvatar.large(image: image)),
        const SizedBox(height: 15),
        SText.center(text: name, color: Theme.of(context).primaryColorLight, size: 20, weight: FontWeight.bold,),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SText.center(
              text: rate.toString(),
              color: rate >= 3.5 ? SColors.green : rate >= 1.5 ? SColors.yellow : SColors.red, size: 16,
              weight: FontWeight.bold,
            ),
            const SizedBox(width: 10),
            RatingBarIndicator(
              rating: rate,
              itemBuilder: (context, index) => const Icon(Icons.star, color: Colors.amber),
              itemCount: 5,
              itemSize: 15.0,
            ),
          ],
        ),
      ],
    );
  }
}

class UserCallTypeTab extends StatefulWidget {
  const UserCallTypeTab({super.key, required this.onItemSelected});
  final ValueChanged<int> onItemSelected;

  @override
  State<UserCallTypeTab> createState() => _UserCallTypeTabState();
}

class _UserCallTypeTabState extends State<UserCallTypeTab> {
  var selectedIndex = 0;
  void handleItemSelected(int index){
    setState(() => selectedIndex = index);
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

class CallModeTab extends StatefulWidget {
  const CallModeTab({super.key, required this.onItemSelected});
  final ValueChanged<int> onItemSelected;

  @override
  State<CallModeTab> createState() => _CallModeTabState();
}

class _CallModeTabState extends State<CallModeTab> {
  var selectedIndex = 0;
  void handleItemSelected(int index){
    setState(() => selectedIndex = index);
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