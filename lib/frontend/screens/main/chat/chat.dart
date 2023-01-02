import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provide/lib.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {

  List <ChatModel> chats = [
    ChatModel(
      image: const Picture.medium(),
      name: "Frank Waters",
      message: "Hi, Evaristus",
      messageTime: "10:04",
      id: "Eva",
      icon: Icons.done_all_outlined
    ),
    ChatModel(
      image: const Picture.medium(),
      name: "Eva Waters",
      message: "Hi, Awesome",
      messageTime: "10:04",
      id: "Frank",
      icon: Icons.done_all_outlined
    ),
    ChatModel(
      image: const Picture.medium(),
      name: "Frank Waters",
      message: "Hi, Evaristus",
      messageTime: "10:04",
      id: "Eva",
      icon: Icons.done_all_outlined
    ),
    ChatModel(
      image: const Picture.medium(),
      name: "Eva Waters",
      message: "Hi, Awesome",
      messageTime: "10:04",
      id: "Frank",
      icon: Icons.done_all_outlined
    ),
    ChatModel(
      image: const Picture.medium(),
      name: "Eva Waters",
      message: "Hi, Awesome",
      messageTime: "10:04",
      id: "Frank",
      icon: Icons.done_all_outlined
    ),
    ChatModel(
      image: const Picture.medium(),
      name: "Frank Waters",
      message: "Hi, Evaristus",
      messageTime: "10:04",
      id: "Eva",
      icon: Icons.done_all_outlined
    ),
    ChatModel(
      image: const Picture.medium(),
      name: "Eva Waters",
      message: "Hi, Awesome",
      messageTime: "10:04",
      id: "Frank",
      icon: Icons.done_all_outlined
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar.medium(
            elevation: 0,
            title: SText.center(
              text: "Chatroom",
              size: 24,
              weight: FontWeight.bold,
              color: Theme.of(context).primaryColor
            ),
            titleSpacing: 0,
            actions: [
              IconButton(
                onPressed: (){},
                icon: const Icon(
                  CupertinoIcons.search_circle_fill,
                  color: SColors.light,
                  size: 40
                )
              ),
            ],
            expandedHeight: 200,
          ),

          SliverList(
            delegate: SliverChildBuilderDelegate(
              ((context, index) => SChatCard(chatModel: chats[index])),
              childCount: chats.length,
            )
          )
        ],
      )
      // body: SingleChildScrollView(
      //   physics: const AlwaysScrollableScrollPhysics(),
      //   child: Padding(
      //     padding: screenPadding,
      //     child: Column(
      //       children: [
      //         SChatBox.electrician(
      //           onClick: () => Get.to(() => const UserChattingScreen()
      //         ),
      //         ),
      //         const SChatBox.plumber(),
      //         const SChatBox.barber(),
      //         const SChatBox.mechanic(),
      //       ],
      //     )
      //   )
      // )
    );
  }
}