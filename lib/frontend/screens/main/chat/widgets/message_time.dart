import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:date_time_format/date_time_format.dart';

class MessageTime{
  static String timeAgoSinceDate(int time){
    DateTime notificationDate = DateTime.fromMillisecondsSinceEpoch(time);
    final date = DateTime.now();
    final diff = date.difference(notificationDate);

    if(diff.inDays > 8){
      return DateFormat("dd/MM/yyyy HH:mm:ss").format(notificationDate);
    } else if((diff.inDays / 7).floor() >= 1){
      return "Last Week";
    } else if(diff.inDays >= 2){
      return '${diff.inDays} days ago';
    } else if(diff.inDays >= 1){
      return "1 day ago";
    } else if(diff.inHours >= 2){
      return '${diff.inHours} hours ago';
    } else if(diff.inHours >= 1){
      return '1 hour ago';
    } else if(diff.inMinutes >= 2){
      return '${diff.inMinutes} minutes ago';
    } else if(diff.inMinutes >= 1){
      return '1 minute ago';
    } else if(diff.inSeconds >= 3){
      return '${diff.inSeconds} seconds ago';
    } else {
      return "now";
    }
  }

  static String getPmAm(int time) {
    DateTime notificationDate = DateTime.fromMillisecondsSinceEpoch(time);
    final date = DateTime.now();
    final diff = date.difference(notificationDate);

    if(diff.inHours < 12){
      if(diff.inHours.toString().startsWith("0")){
        return "${diff.inHours.toString()}am";
      }
      return "${diff.inHours}am";
    } else {
      return "${diff.inHours}pm";
    }
  }

  static bool isSameDay(int time){
    DateTime notificationDate = DateTime.fromMillisecondsSinceEpoch(time);
    final date = DateTime.now();
    final diff = date.difference(notificationDate);

    if(diff.inDays > 0){
      return false;
    } else {
      return true;
    }
  }

  static bool isSameMinute(int time){
    DateTime notificationDate = DateTime.fromMillisecondsSinceEpoch(time);
    final date = DateTime.now();
    final diff = date.difference(notificationDate);

    if(diff.inMinutes <= 1){
      return true;
    } else {
      return false;
    }
  }

  static String getRoomId(String a, String b){
    if(a.compareTo(b) > 0){
      return a + b;
    } else {
      return b + a;
    }
  }

  static String getHeaderTime() {
    final dateTime = DateTime.now();
    debugPrint(dateTime.format());
    debugPrint(DateTimeFormat.format(dateTime));
    return "";
  }

  static String getTime() {
    var hour = DateTime.now().hour;
    var minutes = DateTime.now().minute;
    final fifteenAgo = DateTime.now().subtract(const Duration(minutes: 1));
    debugPrint(timeago.format(fifteenAgo));
    if(minutes.toString().length < 2){
      if (hour < 1){
        return '$hour:${minutes}0am';
      } else if(hour == 13){
        return '1:${minutes}0pm';
      } else if(hour == 14){
        return '2:${minutes}0pm';
      } else if(hour == 15){
        return '3:${minutes}0pm';
      } else if(hour == 16){
        return '4:${minutes}0pm';
      } else if(hour == 17){
        return '5:${minutes}0pm';
      } else if(hour == 18){
        return '6:${minutes}0pm';
      } else if(hour == 19){
        return '7:${minutes}0pm';
      } else if(hour == 20){
        return '8:${minutes}0pm';
      } else if(hour == 21){
        return '9:${minutes}0pm';
      } else if(hour == 22){
        return '10:${minutes}0pm';
      } else if(hour == 23){
        return '11:${minutes}0pm';
      } else {
        return '$hour:${minutes}0am';
      }
    } else {
      if (hour < 1){
        return '$hour:${minutes}am';
      } else if(hour == 13){
        return '1:${minutes}pm';
      } else if(hour == 14){
        return '2:${minutes}pm';
      } else if(hour == 15){
        return '3:${minutes}pm';
      } else if(hour == 16){
        return '4:${minutes}pm';
      } else if(hour == 17){
        return '5:${minutes}pm';
      } else if(hour == 18){
        return '6:${minutes}pm';
      } else if(hour == 19){
        return '7:${minutes}pm';
      } else if(hour == 20){
        return '8:${minutes}pm';
      } else if(hour == 21){
        return '9:${minutes}pm';
      } else if(hour == 22){
        return '10:${minutes}pm';
      } else if(hour == 23){
        return '11:${minutes}pm';
      } else {
        return '$hour:${minutes}am';
      }
    }
  }
}