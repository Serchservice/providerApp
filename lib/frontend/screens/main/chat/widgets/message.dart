import 'package:flutter/material.dart';
import 'package:provide/lib.dart';

class MessageModel{
  final String type;
  final String message;
  final String time;
  final String status;
  MessageModel({required this.type, required this.message, required this.time, this.status = "Sent"});
}

class SendMessageCard extends StatelessWidget {
  const SendMessageCard({
    super.key, required this.message, required this.messageDate, required this.messageStatus, required this.iconColor,
  });
  final String message;
  final String messageDate;
  final IconData messageStatus;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: outerMyChatPadding,
      child: Align(
        alignment: Alignment.centerRight,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              padding: chatBoxPadding,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColorDark,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(borderRadius),
                  bottomRight: Radius.circular(borderRadius),
                  bottomLeft: Radius.circular(borderRadius),
                ),
              ),
              child: SText(text: message, color: SColors.white, size: 15),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 2.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SText(text: messageDate, color: Theme.of(context).primaryColorLight, size: 11, weight: FontWeight.bold),
                  const SizedBox(width: 1),
                  Icon(messageStatus, color: iconColor, size: 16)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

// class SendMessageCard extends StatelessWidget {
//   final String message;
//   final String time;
//   final IconData status;
//   final Color color;
//   const SendMessageCard({
//     super.key, required this.message, required this.time, required this.status, this.color = SColors.hint
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Align(
//       alignment: Alignment.centerRight,
//       child: ConstrainedBox(
//         constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width - 50),
//         child: Stack(
//           children: [
//             Card(
//               color: Theme.of(context).primaryColorDark,
//               elevation: 1,
//               shape: const RoundedRectangleBorder(
//                 borderRadius: BorderRadius.only(
//                   topLeft: Radius.circular(borderRadius),
//                   bottomRight: Radius.circular(borderRadius),
//                   bottomLeft: Radius.circular(borderRadius),
//                 ),
//               ),
//               margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
//                 child: SText(text: message, color: SColors.white, size: 15),
//               ),
//             ),
//             Positioned(
//               bottom: 4,
//               right: 10,
//               child: Row(
//                 children: [
//                   SText(text: time, color: Theme.of(context).primaryColorLight, size: 11, weight: FontWeight.bold),
//                   const SizedBox(width: 5),
//                   Icon(status, color: color, size: 24)
//                 ]
//               )
//             )
//           ],
//         )
//       )
//     );
//   }
// }

// class ReplyMessageCard extends StatelessWidget {
//   final String message;
//   final String time;
//   const ReplyMessageCard({super.key, required this.message, required this.time});

//   @override
//   Widget build(BuildContext context) {
//     return Align(
//       alignment: Alignment.centerLeft,
//       child: ConstrainedBox(
//         constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width - 50),
//         child: Card(
//           color: Theme.of(context).primaryColorDark,
//           elevation: 1,
//           shape: const RoundedRectangleBorder(
//             borderRadius: BorderRadius.only(
//               topLeft: Radius.circular(borderRadius),
//               bottomRight: Radius.circular(borderRadius),
//               bottomLeft: Radius.circular(borderRadius),
//             ),
//           ),
//           margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
//           child: Stack(
//             children: [
//               Padding(
//                 padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
//                 child: SText(text: message, color: SColors.white, size: 15),
//               ),
//               Positioned(
//                 bottom: 4,
//                 right: 10,
//                 child: SText(text: time, color: Theme.of(context).primaryColorLight, size: 11, weight: FontWeight.bold),
//               )
//             ]
//           ),
//         )
//       )
//     );
//   }
// }

class ReplyMessageCard extends StatelessWidget {
  const ReplyMessageCard({
    Key? key,
    required this.message,
    required this.messageDate,
  }) : super(key: key);

  final String message;
  final String messageDate;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: outerOtherChatPadding,
      child: Align(
        alignment: Alignment.centerLeft,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: chatBoxPadding,
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(borderRadius),
                  topRight: Radius.circular(borderRadius),
                  bottomRight: Radius.circular(borderRadius),
                ),
              ),
              child: SText(text: message, color: SColors.white, size: 15),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5.0),
              child: SText(text: messageDate, color: Theme.of(context).primaryColorLight, size: 11, weight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}

