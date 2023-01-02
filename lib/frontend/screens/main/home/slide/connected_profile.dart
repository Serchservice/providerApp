import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provide/lib.dart';

class ConnectedProfile extends StatefulWidget {
  final String serviceStatus;
  final bool swm;
  final String name;
  final bool online;
  final bool offline;
  final VoidCallback? cancelClick;
  final VoidCallback? endClick;
  const ConnectedProfile({
    super.key, required this.serviceStatus, this.online = true, this.offline = false, required this.swm,
    required this.name, this.cancelClick, this.endClick
  });

  @override
  State<ConnectedProfile> createState() => _ConnectedProfileState();
}

class _ConnectedProfileState extends State<ConnectedProfile> {
  int selected = -1;
  void handleItemSelected(int index){
    setState(() {
      selected = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Picture(radius: 70),
        const SizedBox(height: 10),
        const SStarRate(),
        const SizedBox(height: 10),
        SText.center(
          text: widget.name,
          size: 16, weight: FontWeight.bold,
          color: Theme.of(context).scaffoldBackgroundColor
        ),
        const SizedBox(height: 10),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            SIconButton(icon: CupertinoIcons.phone_fill, iconColor: SColors.white, size: 24),
            SizedBox(width: 5),
            SIconButton(icon: CupertinoIcons.video_camera_solid, iconColor: SColors.white, size: 24),
            SizedBox(width: 5),
            SIconButton(icon: CupertinoIcons.bubble_left_bubble_right_fill, iconColor: SColors.white, size: 24),
          ],
        ),
        const SizedBox(height: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                SText(
                  text: "Status: ",
                  size: 16, weight: FontWeight.bold,
                  color: Theme.of(context).scaffoldBackgroundColor
                ),
                Icon(
                  widget.online ? CupertinoIcons.bolt_circle_fill : widget.offline ? CupertinoIcons.bolt_slash_fill
                    : CupertinoIcons.bolt_horizontal_circle_fill,
                  color: widget.online ? SColors.green : widget.offline ? SColors.red : SColors.yellow,
                  size: 16
                ),
                SText(
                  text: widget.online ? " Online" : widget.offline ? " Offline" : " Busy but Online",
                  size: 16, weight: FontWeight.bold,
                  color: widget.online ? SColors.green : widget.offline ? SColors.red : SColors.yellow,
                ),
              ],
            ),
            const SizedBox(height: 2),
            Row(
              children: [
                SText(
                  text: "Service Status: ",
                  size: 16, weight: FontWeight.bold,
                  color: Theme.of(context).scaffoldBackgroundColor
                ),
                SText(
                  text: widget.serviceStatus,
                  size: 16, weight: FontWeight.bold,
                  color: widget.serviceStatus == "Ongoing" ? SColors.green : SColors.yellow,
                ),
              ],
            ),
            const SizedBox(height: 2),
            Row(
              children: [
                SText(
                  text: "SWM Enabled: ",
                  size: 16, weight: FontWeight.bold,
                  color: Theme.of(context).scaffoldBackgroundColor
                ),
                SText(
                  text: widget.swm ? "True" : "False",
                  size: 16, weight: FontWeight.bold,
                  color: widget.swm? SColors.green : SColors.red,
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 20),
        Wrap(
          spacing: 10,
          children: [
            SButton(
              text: "Cancel Service",
              textWeight: FontWeight.bold,
              onClick: widget.cancelClick,
            ),
            SButton(
              text: "End Service",
              textWeight: FontWeight.bold,
              onClick: widget.endClick
            ),
            SButton(
              text: "RequestShare",
              textWeight: FontWeight.bold,
              onClick: () => enableRequestShare(
                context: context,
                selected: selected,
                handleItemSelected: handleItemSelected
              )
            ),
          ],
        ),
        const SizedBox(height: 50),
      ],
    );
  }
}