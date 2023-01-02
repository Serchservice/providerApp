import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provide/lib.dart';

class SChatBox extends StatelessWidget {
  final ListOfLastChats lastChats;
  const SChatBox({super.key, required this.lastChats});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        margin: const EdgeInsets.only(bottom: 8),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Theme.of(context).backgroundColor)
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
                    text: lastChats.senderName,
                    color: Theme.of(context).primaryColor,
                    size: 18,
                    weight: FontWeight.w800,
                  ),
                  const SizedBox(height: 10),
                  SText(
                    text: lastChats.senderLastMsg,
                    weight: FontWeight.normal,
                    color: Theme.of(context).primaryColor
                  )
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SText(
                  text: lastChats.lastMsgTime,
                  color: Theme.of(context).primaryColor
                ),
                const SizedBox(height: 10),
                Icon(
                  CupertinoIcons.checkmark_alt,
                  color: Theme.of(context).primaryColor,
                  size: 14
                )
              ],
            )
          ],
        )
      ),
    );
  }
}

class SChatCard extends StatelessWidget {
  final ChatModel chatModel;
  const SChatCard({super.key, required this.chatModel});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => Navigator.of(context).push(UserChattingScreen.route(
          chatModel.id, chatModel
        )),
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
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: chatModel.image,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SText(
                      text: chatModel.name,
                      size: 18,
                      weight: FontWeight.bold,
                      color: Theme.of(context).primaryColor,
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Icon(chatModel.icon, size: 18, color: SColors.hint,),
                        const SizedBox(width: 3),
                        SText(
                          text: chatModel.message,
                          color: SColors.hint,
                          size: 16
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SText(
                    text: chatModel.messageTime,
                    color: SColors.hint,
                  ),
                  const SizedBox(height: 10),
                  CircleAvatar(
                    radius: 5,
                    backgroundColor: Theme.of(context).primaryColorDark,
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

