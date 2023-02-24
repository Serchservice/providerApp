import 'package:provide/lib.dart';
import 'package:flutter/material.dart';

enum Popup{
  success,
  error,
  warning,
  info
}

enum NotifyPopup{
  voiceCall,
  videoCall,
  message,
}


Future getPage(NotifyPopup notify, context) {
  if(notify == NotifyPopup.message){
    return Navigator.of(context).push(UserChattingScreen.route("chatModel.id"));
  } else {
    return Navigator.of(context).push(UserChattingScreen.route("chatModel.id"));
  }
  // switch (notify) {
  //   case NotifyPopup.message:
  //     Navigator.of(context).push(UserChattingScreen.route(
  //       chatModel.id, chatModel
  //     ));
  //     break;
  //   default:
  //   return null;
  // }
}




Color getColor(popup) {
  switch (popup) {
    case Popup.error:
      return SColors.red;
    case Popup.success:
      return SColors.green;
    case Popup.warning:
      return SColors.yellow;
    case Popup.info:
      return SColors.grey;
    default:
  }
  throw SException("message");
}

Color getSideColor(popup) {
  switch (popup) {
    case Popup.error:
      return Scolors.error;
    case Popup.success:
      return Scolors.success;
    case Popup.warning:
      return Scolors.warning;
    case Popup.info:
      return Scolors.info;
    default:
  }
  throw SException("message");
}

String getTitle(popup){
  switch (popup) {
    case Popup.error:
      return "Error Notification";
    case Popup.success:
      return "Success Notification";
    case Popup.warning:
      return "Warning Notification";
    case Popup.info:
      return "For Your Information...";
    default:
  }
  throw SException("message");
}

IconData getIcon(popup){
  switch (popup) {
    case Popup.error:
      return Icons.error;
    case Popup.success:
      return Icons.check_circle;
    case Popup.warning:
      return Icons.warning_amber;
    case Popup.info:
      return Icons.info;
    default:
  }
  throw SException("message");
}