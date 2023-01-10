import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provide/lib.dart';

class UserStateListener extends StatefulWidget {
  ///Auth listener for changes in the user auth state. Mostly used as a widget after the splashscreen.
  ///
  ///This is where the Supabase listens to the auth changes of the user session.
  const UserStateListener({super.key});

  @override
  State<UserStateListener> createState() => _UserStateListenerState();
}

class _UserStateListenerState extends State<UserStateListener> {
  Future<void> _redirect() async {
    // await for for the widget to mount
    await Future.delayed(Duration.zero);

    final session = supabase.auth.currentSession;
    if (session != null) {
      Get.offAll(() => const BottomNavigator());
    } else {
      Get.offAll(() => const BottomNavigator());
      // Get.offAll(() => const OnboardScreen());
    }
  }

  @override
  void initState() {
    _redirect();
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Container();
}