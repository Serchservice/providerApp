import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provide/lib.dart';

class SCallBox extends StatelessWidget {
  final CallModel call;
  const SCallBox({super.key, required this.call});
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => Get.to(() => CallHistoryScreen()),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 10),
          decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: Theme.of(context).backgroundColor, width: 2.0)
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.only(right: 10),
                child: Picture.medium(),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SText(
                      text: call.callerName,
                      color: Theme.of(context).primaryColor,
                      size: 18,
                      weight: FontWeight.w800,
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        call.videoCall ? Icon(
                          CupertinoIcons.video_camera_solid,
                          color: call.missed ? SColors.red
                          : call.outgoing ? SColors.yellow
                          : SColors.green,
                          size: 16
                        )
                        : call.t2fVC ? Icon(
                          CupertinoIcons.money_dollar_circle,
                          color: call.missed ? SColors.red
                          : call.outgoing ? SColors.yellow
                          : SColors.green,
                          size: 16
                        )
                        :
                        Icon(
                          call.missed ? CupertinoIcons.phone_down_fill
                          : call.outgoing ? CupertinoIcons.phone_fill_arrow_up_right
                          : CupertinoIcons.phone_fill_arrow_down_left,
                          color: call.missed ? SColors.red
                          : call.outgoing ? SColors.yellow
                          : SColors.green,
                          size: 16
                        ),
                        const SizedBox(width: 5),
                        SText(
                          text: call.missed ? "Missed"
                            : call.outgoing ? "Outgoing"
                            : "Received",
                          weight: FontWeight.normal,
                          color: call.missed ? SColors.red
                          : call.outgoing ? SColors.yellow
                          : SColors.green
                        )
                      ],
                    )
                  ],
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SText(
                    text: call.callTime,
                    color: Theme.of(context).primaryColor
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}