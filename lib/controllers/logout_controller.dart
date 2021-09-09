import 'dart:async';

import 'package:beautymaker/controllers/animated_controller.dart';
import 'package:beautymaker/controllers/login_controller.dart';
import 'package:beautymaker/views/login_view.dart';
import 'package:flutter/material.dart';
import 'package:getxfire/getxfire.dart';

class LogoutController extends GetxController {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final User? user = FirebaseAuth.instance.currentUser;
  RxBool isLoggedOut = false.obs;

  void logout() async {
    await firebaseAuth.signOut();
    isLoggedOut(true);
    Get.find<LoginController>().isLoading(false);
    Timer(1.5.seconds, () {
      Get.offAll(() => LoginPage());
    });
    update();
  }
}
