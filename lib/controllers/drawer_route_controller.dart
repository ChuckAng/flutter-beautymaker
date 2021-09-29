import 'package:beautymaker/controllers/animated_controller.dart';
import 'package:beautymaker/models/drawer_item.dart';
import 'package:beautymaker/utils/ui/drawer_items.dart';
import 'package:beautymaker/views/home.dart';
import 'package:beautymaker/views/profile.dart';
import 'package:beautymaker/views/settings_view.dart';
import 'package:beautymaker/views/user_order_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:getxfire/getxfire.dart';

class DrawerRouteController extends GetxController {
  DrawerItem defaultItem = DrawerItems.home;
  RxBool routeClicked = false.obs;

  final _animatedController = Get.put(AnimatedController());

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

  getRoute(DrawerItem item) {
    defaultItem = item;
    closeDrawer();

    update();
  }

  onSelectedPage(BuildContext context) {
    switch (defaultItem) {
      case DrawerItems.profile:
        return Profile();
      case DrawerItems.orders:
        return UserOrderPage();
      case DrawerItems.settings:
        return SettingPage();

      case DrawerItems.home:
      default:
        return HomePage();
    }
  }
}
