// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// // import 'package:google_nav_bar/google_nav_bar.dart';
// import 'package:provide/lib.dart';

// class SScreenNavigator extends StatefulWidget {
//   const SScreenNavigator({super.key});

//   @override
//   State<SScreenNavigator> createState() => _SScreenNavigatorState();
// }

// class _SScreenNavigatorState extends State<SScreenNavigator> {
//   // int _page = 0;
//   final pages = navPages;
//   final short = shortChatTabs;
//   @override
//   Widget build(BuildContext context) {
//     return const BottomNavigator();
//     // return Scaffold(
//     //   backgroundColor: Theme.of(context).scaffoldBackgroundColor,
//     //   body: Row(
//     //     children: [
//     //       SafeArea(
//     //         child: SideNavigator(
//     //           menu: DrawerMenu(
//     //             selectedIndex: _page,
//     //             onTabChange: (int index) {
//     //               setState(() {
//     //                 _page = index;
//     //               });
//     //             },
//     //             rippleColor: Colors.blueGrey,
//     //             hoverColor: Colors.grey,
//     //             haptic: true, // haptic feedback
//     //             tabBorderRadius: 10,
//     //             activeColor: SUColors.white,
//     //             tabActiveBorder: Border.all(color: SUColors.white, width: 1),
//     //             color: Colors.grey[800],
//     //             tabBorder: Border.all(color: SUColors.black, width: 1),
//     //             curve: Curves.bounceIn,
//     //             duration: const Duration(milliseconds: 100),
//     //             gap: 10,
//     //             iconSize: 24,
//     //             padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
//     //             tabMargin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
//     //             tabs: [
//     //               GButton(icon: CupertinoIcons.home, iconColor: SUColors.hint, iconActiveColor: Theme.of(context).scaffoldBackgroundColor,),
//     //               GButton(icon: CupertinoIcons.chat_bubble_2_fill),
//     //               GButton(icon: CupertinoIcons.phone),
//     //               GButton(icon: CupertinoIcons.settings),
//     //               GButton(icon: CupertinoIcons.person_crop_circle_fill_badge_plus),
//     //             ]
//     //           ),
//     //         ),
//     //       ),
//     //       Expanded(flex: 5, child: pages[_page])
//     //     ],
//     //   ),
//     // );
//   }
// }