import 'package:beautymaker/views/stackHomePage.dart';
import 'package:flutter/animation.dart';
import 'package:getxfire/getxfire.dart';
import 'package:get/utils.dart';

class AnimatedController extends GetxController
    with SingleGetTickerProviderMixin {
  late AnimationController animationController;
  bool isClicked = false;
  var isGrid = false.obs;
  RxInt test = 0.obs;
  var xOffset = 0.0.obs;
  var yOffset = 0.0.obs;
  var scaleFactor = 1.0.obs;
  // RxInt xOffset = 0.obs;
  // var yOffset = 0.obs;
  // var scaleFactor = 1.0.obs;

  @override
  void onInit() {
    super.onInit();
    animationController =
        AnimationController(vsync: this, duration: 500.milliseconds);
    Home();
    update();
  }

  @override
  void onClose() {
    animationController.dispose();
    super.onClose();
  }

  void toggleDrawer() {
    xOffset = 170 as RxDouble;
    yOffset = 120 as RxDouble;
    scaleFactor = 0.7 as RxDouble;
    update();
  }

  void onClickBeauty() {
    test++;
    update();
  }

  void toggleIcon() {
    isClicked = !isClicked;
    isGrid(!isGrid.value);
    isClicked ? animationController.forward() : animationController.reverse();
    update();
  }

  // void openDrawer() {
  //   xOffset++;
  //   update();
  // }

  // void closeDrawer() {
  //   xOffset = 0 as RxInt;
  //   yOffset = 0 as RxInt;
  //   scaleFactor = 1 as RxDouble;
  //   update();
  // }

}
