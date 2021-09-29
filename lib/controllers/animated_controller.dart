import 'dart:async';

import 'package:beautymaker/controllers/login_controller.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:getxfire/getxfire.dart';
import 'package:get/utils.dart';

class AnimatedController extends GetxController
    with SingleGetTickerProviderMixin {
  late AnimationController listAnimationController;
  late AnimationController loginAnimationController;
  late Animation _animation;
  
  late AnimationController wordFadingController;
  bool isClicked = false;
  var isGrid = false.obs;
  RxDouble x = 0.0.obs;
  RxDouble y = 0.0.obs;
  RxDouble scaleFactor = 1.0.obs;
  bool isDragging = false;
  late bool isDrawerOpen = false;
  

  Timer? timer;
  RxInt seconds = RxInt(60);

  void startTimer() {
    resetTimer();
    Get.find<LoginController>().isButtonEnabled(false);
    timer = Timer.periodic(1.seconds, (_) {
      if (seconds > 0) {
        seconds--;
      } else {
        stopTimer();
        Get.find<LoginController>().startVerify(false);
        Get.find<LoginController>().isButtonEnabled(true);
      }
      update();
    });
  }

  void resetTimer() {
    seconds = RxInt(60);
    update();
  }

  void stopTimer() {
    timer?.cancel();
    update();
  }

  @override
  void onInit() {
    super.onInit();

    loginAnimationController =
        AnimationController(vsync: this, duration: 600.milliseconds);

    wordFadingController = AnimationController(
      vsync: this,
      duration: 2300.milliseconds,
    );
    _animation = Tween(begin: 0.0, end: 1.0).animate(wordFadingController);
    wordFadingController.forward().then((_) async {
      await Future.delayed(1.seconds);
    });
    listAnimationController =
        AnimationController(vsync: this, duration: 300.milliseconds);
  }

  @override
  void onClose() {
    wordFadingController.dispose();
    listAnimationController.dispose();

    super.onClose();
  }

  void toggleIcon() {
    isClicked = !isClicked;
    isGrid(!isGrid.value);
    isClicked
        ? listAnimationController.forward()
        : listAnimationController.reverse();
    update();
  }
}
