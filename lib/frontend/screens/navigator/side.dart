import 'package:flutter/material.dart';

class SideNavigator extends StatefulWidget {
  final Widget menu;
  final VoidCallback? onClick;
  const SideNavigator({super.key, required this.menu, this.onClick});

  @override
  State<SideNavigator> createState() => _SideNavigatorState();
}

class _SideNavigatorState extends State<SideNavigator> {
  @override
  Widget build(BuildContext context) {
    const icon = Icons.arrow_forward_ios_rounded;
    const align = Alignment.center;
    const double size = 42;
    const width = double.infinity;
    return Container(
      height: MediaQuery.of(context).size.height,
      width: 60,
      decoration: BoxDecoration(color: Theme.of(context).primaryColor),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 10,),
          // UserAccountsDrawerHeader(
          //   decoration: BoxDecoration(color: Theme.of(context).primaryColor),
          //   accountName: SUText(text: "text", color: Theme.of(context).primaryColor),
          //   accountEmail: SUText(text: "text", color: Theme.of(context).primaryColor),
          //   currentAccountPictureSize: const Size.square(60),
          //   currentAccountPicture: CircleAvatar(
          //     backgroundColor: Theme.of(context).primaryColor,
          //     child: SUText(text: "text", color: Theme.of(context).primaryColor),
          //   ),
          // ),
          const SizedBox(height: 40,),
          widget.menu,
          const Spacer(),
          Container(
            alignment: align,
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: widget.onClick,
                child: SizedBox(
                  width: width,
                  height: size,
                  child: Icon(
                    icon,
                    color: Theme.of(context).scaffoldBackgroundColor
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

// class CollapseIcon extends StatelessWidget {
//   final bool collapsed;
//   final BuildContext context;
//   const CollapseIcon({
//     Key? key,
//     required this.collapsed,
//     required this.context
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     const double size = 42;
//     final icon = collapsed ? Icons.arrow_forward_ios_rounded : Icons.arrow_back_ios_new_rounded;
//     final align = collapsed ? Alignment.center : Alignment.centerRight;
//     final margin = collapsed ? null : const EdgeInsets.only(right: 10);
//     final width = collapsed ? double.infinity : size;
//     return Container(
//       alignment: align,
//       margin: margin,
//       child: Material(
//         color: Colors.transparent,
//         child: InkWell(
//           onTap: () {
//             final provider = Provider.of<SideNavigationProvider>(context, listen: false);
//             provider.toggleCollapsed();
//           },
//           child: SizedBox(
//             width: width,
//             height: size,
//             child: Icon(
//               icon,
//               color: Theme.of(context).scaffoldBackgroundColor
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }


// class SUSideNavigator extends StatefulWidget {
//   final Widget menu;
//   const SUSideNavigator({super.key, required this.menu});

//   @override
//   State<SUSideNavigator> createState() => _SUSideNavigatorState();
// }

// class _SUSideNavigatorState extends State<SUSideNavigator> {
//   @override
//   Widget build(BuildContext context) {
//     final provide = Provider.of<SideNavigationProvider>(context);
//     final collapsed = provide.collapsed;
//     return Container(
//       height: MediaQuery.of(context).size.height,
//       padding: const EdgeInsets.symmetric(horizontal: 6),
//       width: collapsed ? 80 : 150,
//       decoration: BoxDecoration(color: Theme.of(context).appBarTheme.backgroundColor),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.start,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           const SizedBox(height: 10,),
//           UserAccountsDrawerHeader(
//             decoration: BoxDecoration(color: Theme.of(context).scaffoldBackgroundColor),
//             accountName: SUText(text: "text", color: Theme.of(context).scaffoldBackgroundColor),
//             accountEmail: SUText(text: "text", color: Theme.of(context).scaffoldBackgroundColor),
//             currentAccountPictureSize: const Size.square(50),
//             currentAccountPicture: CircleAvatar(
//               backgroundColor: Theme.of(context).scaffoldBackgroundColor,
//               child: SUText(text: "text", color: Theme.of(context).scaffoldBackgroundColor),
//             ),
//           ),
//           const SizedBox(height: 40,),
//           widget.menu,
//           const Spacer(),
//           CollapseIcon(collapsed: collapsed, context: context)
//         ],
//       ),
//     );
//   }
// }