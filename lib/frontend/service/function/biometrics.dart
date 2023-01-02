// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:local_auth_android/local_auth_android.dart';
import 'package:local_auth_ios/local_auth_ios.dart';
import 'package:local_auth/error_codes.dart' as auth_error;
import 'package:provide/lib.dart';

class Biometrics{
  static final auth = LocalAuthentication();

  static Future<bool> hasBiometrics() async {
    try {
      return await auth.canCheckBiometrics;
    } on PlatformException catch (e) {
      debugShow(e);
      return false;
    }
  }

  static Future<bool> authenticate() async {
    final available = await hasBiometrics() || await auth.isDeviceSupported();

    if(!available) return false;
    try {
      final status = await auth.authenticate(
        localizedReason: "Scan your fingerprint to authenticate",
        options: const AuthenticationOptions(
          useErrorDialogs: true,
          stickyAuth: true
        ),
        authMessages: const <AuthMessages>[
          AndroidAuthMessages(
            signInTitle: 'Biometric authentication required!',
            cancelButton: 'No thanks',
          ),
          IOSAuthMessages(
            cancelButton: 'No thanks',
          ),
        ]
      );
      return status;
    } on PlatformException catch (e) {
      if (e.code == auth_error.notAvailable) {
        debugShow(e);
        showGetSnackbar(message: "You do not have any biometric enabled on your phone", type: Popup.error);
      } else if (e.code == auth_error.notEnrolled) {
        debugShow(e);
        showGetSnackbar(message: "You failed to register your biometrics", type: Popup.error);
      } else if (e.code == auth_error.lockedOut || e.code == auth_error.permanentlyLockedOut) {
        debugShow(e);
        showGetSnackbar(message: "You seem to be locked out!", type: Popup.error);
      } else {
        debugShow(e);
        showGetSnackbar(message: "Something is wrong somewhere", type: Popup.error);
      }
      debugShow(e);
      return false;
    }
  }
}