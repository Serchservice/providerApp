import 'package:flutter/cupertino.dart';

class ChatModel{
  final Widget image;
  final String name;
  final String message;
  final IconData icon;
  final String id;
  final String? service;
  final String messageTime;
  ChatModel({
    required this.image, required this.name, required this.message, required this.messageTime,
    required this.icon, required this.id, this.service
  });
}

class ListOfLastChats{
  final String senderName;
  final String senderLastMsg;
  final String lastMsgTime;
  final VoidCallback? onClick;

  ListOfLastChats({required this.senderName, required this.senderLastMsg, required this.lastMsgTime, this.onClick});
}