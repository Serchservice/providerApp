import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provide/lib.dart';

class DateLabel extends StatelessWidget {
  const DateLabel({super.key, required this.model, });
  final MessageModel model;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).backgroundColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 12),
            child: Text(
              model.dateLabel!,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: SColors.hint,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ChatAppBar extends StatefulWidget {
  final ChatModel chatModel;
  const ChatAppBar({super.key, required this.chatModel});

  @override
  State<ChatAppBar> createState() => _ChatAppBarState();
}

class _ChatAppBarState extends State<ChatAppBar> {
  bool ctg = true;
  bool scheduled = false;
  final schedule = UserScheduledListModel(scheduledImage: SImages.user, scheduledTime: "10.00am");
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: AppBar(
        elevation: 0.8,
        leadingWidth: 40,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(
            CupertinoIcons.chevron_back,
            color: Theme.of(context).primaryColorLight,
            size: 28
          )
        ),
        titleSpacing: 0,
        title: InkWell(
          onTap: () => Get.to(() => UserProfileScreen()),
          child: Row(
            children: [
              widget.chatModel.image,
              const SizedBox(width: 6),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SText(
                      text: widget.chatModel.name,
                      color: Theme.of(context).primaryColorLight,
                      weight: FontWeight.bold,
                      size: 18.5,
                      flow: TextOverflow.ellipsis
                    ),
                    const SizedBox(height: 3),
                    SText(
                      text: widget.chatModel.service ?? "",
                      color: Theme.of(context).primaryColorLight,
                      weight: FontWeight.bold,
                      size: 14
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        actions: [
          const SizedBox(width: 14),
          InkWell(
            onTap: () => setState(() => ctg = !ctg),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Icon(
                CupertinoIcons.rocket_fill,
                color: ctg ? SColors.green : Theme.of(context).primaryColorLight,
                size: 22
              ),
            )
          ),
          if(scheduled)
          ScheduledBox(user: schedule)
        ],
      ),
    );
  }
}

