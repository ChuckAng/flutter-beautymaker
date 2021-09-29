import 'package:beautymaker/utils/services/user_info_firebase.dart';
import 'package:flutter/material.dart';
import 'package:getxfire/getxfire.dart';
import 'package:get/utils.dart';

/* ***********************************************

 Create User by storing email and password to firebase

*************************************************** */

class CreateUserFirebase extends GetxController {
  UserInfoFirebase _userInfoFirebase = Get.put(UserInfoFirebase());
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final User? user = FirebaseAuth.instance.currentUser;
  RxBool isLoading = false.obs;
  RxBool finishedLoading = false.obs;

  final CollectionReference userData =
      FirebaseFirestore.instance.collection('UserData');

  void createUser(String email, String password) async {
    try {
      await firebaseAuth
          .createUserWithEmailAndPassword(
              email: email.trim(), password: password)
          .then((value) async {
        userData.doc(email.trim()).set({
          "email": value.user!.email,
          "password": password,
        });
      });
      _userInfoFirebase.getEmailUid(email.trim());
    } on FirebaseAuthException catch (e) {
      Get.snackbar("Error creating account", e.message.toString(),
          margin: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
          backgroundColor: Colors.white,
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
