import 'dart:io';

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

class MessageModel{
  final String? dateLabel;
  final String? type;
  final String? message;
  final String? path;
  final String time;
  final bool isSender;
  final bool isAudio;
  final String? audioDuration;
  final String? messageDate;
  final String? messageStatus;
  final int? index;
  final double? width;
  final bool isLastWidget;
  final Directory? appDirectory;
  MessageModel({
    this.audioDuration,
    this.messageDate,
    this.messageStatus,
    this.type, this.index,
    this.width, this.path,
    this.message,
    this.appDirectory,
    this.dateLabel,
    required this.time,
    required this.isAudio,
    required this.isSender,
    this.isLastWidget = false
  });
}

class ListOfLastChats{
  final String senderName;
  final String senderLastMsg;
  final String lastMsgTime;
  final VoidCallback? onClick;

  ListOfLastChats({required this.senderName, required this.senderLastMsg, required this.lastMsgTime, this.onClick});
}