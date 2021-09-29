import 'package:beautymaker/controllers/animated_controller.dart';
import 'package:beautymaker/controllers/drawer_route_controller.dart';
import 'package:beautymaker/controllers/logout_controller.dart';
import 'package:beautymaker/views/drawer_view.dart';
import 'package:flutter/material.dart';
import 'package:get/utils.dart';
import 'package:getxfire/getxfire.dart';

class HomeDrawerSwap extends StatelessWidget {
  const HomeDrawerSwap({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[850],
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
    return SafeArea(child: DrawerView());
  }
}

class _buildPage extends StatelessWidget {
  const _buildPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AnimatedController _animatedController = Get.put(AnimatedController());
    LogoutController _logoutController = Get.put(LogoutController());
    DrawerRouteController _routeController = Get.put(DrawerRouteController(),permanent: true);

    return WillPopScope(
      onWillPop: () async {
        if (_animatedController.isDrawerOpen) {
          _routeController.closeDrawer();
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
            FocusScope.of(context).unfocus();
            _routeController.openDrawer();
          } else if (details.delta.dx < -delta) {
            _routeController.closeDrawer();
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
                      child: _routeController.onSelectedPage(context)))),
        ),
      ),
    );
  }
}
