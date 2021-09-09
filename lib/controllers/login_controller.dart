import 'package:beautymaker/controllers/animated_controller.dart';
import 'package:beautymaker/services/user_info_firebase.dart';
import 'package:beautymaker/views/home_drawer_swap.dart';
import 'package:beautymaker/views/login_view.dart';
import 'package:beautymaker/views/reset_pass_view.dart';
import 'package:flutter/material.dart';
import 'package:getxfire/getxfire.dart';
import 'package:email_auth/email_auth.dart';

class LoginController extends GetxController {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  EmailAuth _emailAuth = EmailAuth(sessionName: 'BeautyMaker');
  
  RxBool haveAccount = true.obs;
  RxBool revealPassword = false.obs;
  RxBool allFilled = false.obs;
  RxBool isLoading = false.obs;
  RxBool startVerify = false.obs;
  RxBool isButtonEnabled = false.obs;
  RxBool isFocused = false.obs;

  UserInfoFirebase _userInfoFirebase = Get.put(UserInfoFirebase());

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void swap() {
    haveAccount.value = !haveAccount.value;
  }

  void reveal() {
    revealPassword.value = !revealPassword.value;
  }

  // sign in user and verify by own database
  void signIn(String email, String password) async {
    final DocumentSnapshot userDoc = await FirebaseFirestore.instance
        .collection('UserData')
        .doc(email.trim())
        .get();
    String userEmail = userDoc.get('email');
    String userPass = userDoc.get('password');

    if (userEmail == email.trim() && userPass == password) {
      _userInfoFirebase.getEmailUid(email.trim());
      Future.delayed(3.seconds, () {
        Get.to(() => HomeDrawerSwap());
      });
    } else {
      Get.snackbar("User not found", "Please try again",
          margin: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
          backgroundColor: Colors.white,
          snackPosition: SnackPosition.BOTTOM);
    }

    isLoading(false);
  }

  // sign in user and verify by firebase
  void loginUser(String email, String password) async {
    try {
      await firebaseAuth.signInWithEmailAndPassword(
          email: email.trim(), password: password);

      Get.to(() => HomeDrawerSwap());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Get.snackbar("Error logging in account", e.message.toString(),
            margin: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
            backgroundColor: Colors.white,
            snackPosition: SnackPosition.BOTTOM);
      } else if (e.code == 'wrong-password') {
        Get.snackbar("Error logging in account", e.message.toString(),
            margin: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
            backgroundColor: Colors.white,
            snackPosition: SnackPosition.BOTTOM);
      }
      isLoading(false);
    }
  }

  void resendCode(String email) {
    if (isButtonEnabled.value == false) {
      print("cannot send!");
      return;
    } else {
      Get.find<AnimatedController>().startTimer();
      sendOTP(email);
    }
  }

  void sendOTP(String email) async {
    bool result = await _emailAuth.sendOtp(recipientMail: email.trim());
    if (result) {
      startVerify(true);

      debugPrint('OTP sent');
    } else {
      debugPrint("Failed to send OTP");
    }
  }

  void verifyOTP(String email, String otp) {
    bool result =
        _emailAuth.validateOtp(recipientMail: email.trim(), userOtp: otp);

    if (result) {
      Future.delayed(2.seconds, () {
        Get.offAll(() => ResetPasswordPage(), arguments: email.trim());
      });
    } else {
      Get.snackbar("Validation failure", "Invalid code had been entered",
          margin: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
          backgroundColor: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
          animationDuration: 2.seconds);
    }
  }

  void resetPassword(String email) async {
    try {
      await firebaseAuth.sendPasswordResetEmail(email: email.trim());
      Get.snackbar("Validation success",
          "A link is sent to your email for reset password",
          margin: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
          backgroundColor: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
          animationDuration: 2.seconds);
    } on FirebaseAuthException catch (e) {
      Get.snackbar("Error resetting password", e.message.toString(),
          margin: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
          backgroundColor: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
          duration: 2.seconds);
    }
    isLoading(false);
  }
}
