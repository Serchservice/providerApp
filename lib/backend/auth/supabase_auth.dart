import 'package:get/get.dart';
import 'package:provide/lib.dart';

class FbAuth{
  Future signUp({
    String? username, required String password, required String email,
    required String firstName, required String lastName, required String phoneNumber,
    required String gender, bool? emailVerified,
    String? phone, String? phoneCountryCode, String? phoneCountryISOCode,
    String? country, String? countryCode, String? countryDialCode, String? countryFlag
  }) async {
    // try {
    //   final UserCredential user = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
    //   await AuthIDB().signUp(
    //     username: user.user?.tenantId, password: password, email: email,
    //     firstName: firstName, lastName: lastName, phoneNumber: phoneNumber, emailVerified: user.user?.emailVerified,
    //     gender: gender, serchID: CodeGenerator.generateUniqueID(), firebaseID: user.user?.uid,
    //     phone: phone, phoneCountryCode: phoneCountryCode, phoneCountryISOCode: phoneCountryISOCode,
    //     countryCode: countryCode, countryDialCode: countryDialCode, countryFlag: countryFlag, country: country
    //   );
    //   if(user.user != null) return user.user!;
    //   throw SException("User was null");
    // } on FirebaseAuthException catch (e) {
    //   throw SException("Error Message: ${e.message.toString()} ErrorCode: ${e.code.toString()}");
    // }
  }

  Future logIn({
    required String email,
    required String password,
  }) async {
    // try {
    //   final user = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
    //   if(user.user != null) return user.user!;
    //   throw SException("User was null");
    // } on FirebaseException catch (e) {
    //   throw SException("Error Message: ${e.message.toString()} ErrorCode: ${e.code.toString()}");
    // }
  }

  Future signOut(context) async {
    // try {
    //   await _firebaseAuth.signOut();
    //   Get.offAll(() => const LoginScreen());
    // } on FirebaseException catch (e) {
    //   throw SException("Error Message: ${e.message.toString()} ErrorCode: ${e.code.toString()}");
    // }
  }

  Future delete() async {
    // try {
    //   await _firebaseAuth.currentUser?.delete();
    //   Get.offAll(() => const UserStateListener());
    // } on FirebaseAuthException catch (e) {
    //   throw SException("Error Message: ${e.message.toString()} ErrorCode: ${e.code.toString()}");
    // }
  }

  Future forgotPassword({required String email}) async {
    // try {
    //   await _firebaseAuth.sendPasswordResetEmail(
    //     email: email,
    //   );
    // } on FirebaseException catch (e) {
    //   throw SException("Error Message: ${e.message.toString()} ErrorCode: ${e.code.toString()}");
    // }
  }
}

class FbUpdate{
  Future updateEmailAddress(String newEmail, {required String email, required String password}) async {
    // try {
    //   final user = FbAuth().currentUser;
    //   if(user != null){
    //     await user.updateEmail(newEmail);
    //   } else {
    //     await user?.reauthenticateWithCredential(EmailAuthProvider.credential(email: email, password: password));
    //   }
    // } on FirebaseAuthException catch (e) {
    //   throw SException("Error Message: ${e.message.toString()} ErrorCode: ${e.code.toString()}");
    // }
  }

  Future updatePassword(String newPassword, {required String email, required String password}) async {
    // try {
    //   final user = FbAuth().currentUser;
    //   if(user != null){
    //     await user.updatePassword(newPassword);
    //   } else {
    //     await user?.reauthenticateWithCredential(EmailAuthProvider.credential(email: email, password: password));
    //   }
    // } on FirebaseAuthException catch (e) {
    //   throw SException("Error Message: ${e.message.toString()} ErrorCode: ${e.code.toString()}");
    // }
  }
}