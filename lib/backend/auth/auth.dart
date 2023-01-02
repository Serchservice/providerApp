import 'package:get/get.dart';
import 'package:provide/lib.dart';

class Auth extends AuthenticationProvider{
  Future signUp({
    String? username, required String password, required String email,
    required String firstName, required String lastName, required String phoneNumber,
    required String gender, bool? emailVerified,
    String? phone, String? phoneCountryCode, String? phoneCountryISOCode,
    String? country, String? countryCode, String? countryDialCode, String? countryFlag
  }) async {
    try {
      setLoading();
      final user = await FbAuth().signUp(
        username: username, password: password, email: email, firstName: firstName, lastName: lastName, phoneNumber: phoneNumber,
        gender: gender, emailVerified: emailVerified, countryCode: countryCode, countryDialCode: countryDialCode, countryFlag: countryFlag,
        phone: phone, phoneCountryCode: phoneCountryCode, phoneCountryISOCode: phoneCountryISOCode, country: country
      );
      user.sendEmailVerification();
      Get.offAll(() => const ChooseServiceScreen());
      setNotLoading();
    } on SException catch (e) {
      if(e.message.contains("email address is already in use")){
        showGetSnackbar(
          message: "Email address already exist. Try log in or change it instead.",
          type: Popup.error,
          duration: const Duration(seconds: 3)
        );
        setNotLoading();
        showGetSnackbar(
          message: "You might have used it to create an account as a User. Serch allows only one email per its product.",
          type: Popup.info,
          duration: const Duration(seconds: 5)
        );
      } else if(e.message.contains("email address is badly formatted")){
        showGetSnackbar(
          message: "Email address is not entered properly",
          type: Popup.error,
          duration: const Duration(seconds: 3)
        );
        setNotLoading();
      }
    }
  }

  Future logIn({required String password, required String email}) async {
    try {
      setLoading();
      await FbAuth().logIn(email: email, password: password);
      setNotLoading();
      Get.offAll(() => const BottomNavigator());
    } on SException catch (e) {
      setNotLoading();
      if (e.message.contains("no user record")) {
        showGetSnackbar(
          message: "User does not exist. Try sign up instead.",
          type: Popup.error,
          duration: const Duration(seconds: 3)
        );
        return;
      } else if(e.message.contains("password is invalid")){
        showGetSnackbar(
          message: "Password is incorrect. Try resetting password.",
          type: Popup.error,
          duration: const Duration(seconds: 3)
        );
      } else if (e.message.contains("null")) {
        showGetSnackbar(
          message: "You have missing fields in your detail.",
          type: Popup.error,
          duration: const Duration(seconds: 3)
        );
      } else if (e.message.contains("blocked all requests")) {
        showGetSnackbar(
          message: "There is too much login attempts. Try again later.",
          type: Popup.warning,
          duration: const Duration(seconds: 3)
        );
      }
    }
  }

  Future updateEmail({required String newEmail, required String email, required String password}) async {
    try {
      setLoading();
      await FbUpdate().updateEmailAddress(newEmail, email: email, password: password);
      setNotLoading();
    } on SException catch (e) {
      setNotLoading();
      if (e.code == "error") {
        showGetSnackbar(message: "User does not exist. Try sign up instead.", type: Popup.error,
          duration: const Duration(seconds: 3)
        );
        return;
      } else if(e.message.contains("password is invalid")){
        showGetSnackbar(message: "Password is incorrect. Try resetting password.", type: Popup.error,
          duration: const Duration(seconds: 3)
        );
      } else if (e.message.contains("null")) {
        showGetSnackbar(message: "You have missing fields in your detail.", type: Popup.error,
          duration: const Duration(seconds: 3)
        );
      } else if (e.message.contains("blocked all requests")) {
        showGetSnackbar(message: "There is too much login attempts. Try again later.", type: Popup.warning,
          duration: const Duration(seconds: 3)
        );
      }
    }
  }

  Future deleteSerchAccount() async {
    try {
      setLoading();
      await FbAuth().delete();
      setNotLoading();
    } on SException catch (e) {
      setNotLoading();
      if(e.message.contains("requires-recent-login")){
        showGetSnackbar(
          message: "You need to log in again before retrying this request.",
          type: Popup.info,
          duration: const Duration(seconds: 5),
        );
      }
      debugShow(e.message);
    }
  }

  Future signOut(context) async {
    try {
      setLoading();
      await FbAuth().signOut(context);
      setNotLoading();
    } on SException catch (e) {
      setNotLoading();
      debugShow(e.message);
    }
  }
}