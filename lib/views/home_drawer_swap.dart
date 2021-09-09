import 'package:beautymaker/controllers/animated_controller.dart';
import 'package:beautymaker/controllers/logout_controller.dart';
import 'package:beautymaker/controllers/product_controller.dart';
import 'package:beautymaker/views/drawer_view.dart';
import 'package:beautymaker/views/home.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:get/utils.dart';
import 'package:getxfire/getxfire.dart';

class HomeDrawerSwap extends StatelessWidget {
  const HomeDrawerSwap({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Stack(
        children: [const _buildDrawer(), const _buildPage()],
      ),
    );
  }
}

class _buildDrawer extends StatelessWidget {
  const _buildDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AnimatedController _animatedController = Get.put(AnimatedController());
    return SafeArea(child: DrawerView());
  }
}

class _buildPage extends StatelessWidget {
  const _buildPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AnimatedController _animatedController = Get.put(AnimatedController());
    LogoutController _logoutController = Get.put(LogoutController());

    void openDrawer() {
      _animatedController.x.value = 170;
      _animatedController.y.value = 120;
      _animatedController.scaleFactor.value = 0.7;
      _animatedController.isDrawerOpen = true;
    }

    void closeDrawer() {
      _animatedController.x.value = 0;
      _animatedController.y.value = 0;
      _animatedController.scaleFactor.value = 1.0;
      _animatedController.isDrawerOpen = false;
    }

    return WillPopScope(
      onWillPop: () async {
        if (_animatedController.isDrawerOpen) {
          closeDrawer();
          return false;
        } else {
          return true;
        }
      },
      child: GestureDetector(
        onHorizontalDragStart: (details) =>
            _animatedController.isDragging = true,
        onHorizontalDragUpdate: (details) {
          const delta = 1;
          if (!_animatedController.isDragging) return;
          if (details.delta.dx > delta) {
            openDrawer();
          } else if (details.delta.dx < -delta) {
            closeDrawer();
          }
        },
        child: Obx(
          () => AnimatedContainer(
              duration: 230.milliseconds,
              transform: Matrix4.translationValues(
                  _animatedController.x.value, _animatedController.y.value, 0)
                ..scale(_animatedController.scaleFactor.value),
              child: ClipRRect(
                  borderRadius: _animatedController.isDrawerOpen == true ||
                          _logoutController.isLoggedOut.value == true
                      ? BorderRadius.circular(25)
                      : BorderRadius.circular(0),
                  child: AbsorbPointer(
                      absorbing: _animatedController.isDrawerOpen,
                      child: HomePage()))),
        ),
      ),
    );
  }
}
