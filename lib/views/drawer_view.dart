import 'package:beautymaker/controllers/drawer_route_controller.dart';
import 'package:beautymaker/utils/ui/drawer_items.dart';
import 'package:beautymaker/controllers/logout_controller.dart';
import 'package:beautymaker/utils/services/user_info_firebase.dart';
import 'package:beautymaker/utils/ui/text_const.dart';
import 'package:flutter/material.dart';
import 'package:getxfire/getxfire.dart';

class DrawerView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    UserInfoFirebase _userInfoController = Get.put(UserInfoFirebase());
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: size.width,
            padding: EdgeInsets.only(left: 30, top: 50),
            child: Row(
              children: [
                Expanded(
                  child: FutureBuilder(
                      future: _userInfoController.getUserData(),
                      builder: (context, snapshot) {
                        return snapshot.connectionState ==
                                ConnectionState.waiting
                            ? CircularProgressIndicator(
                                color: Colors.black,
                                strokeWidth: 2.0,
                              )
                            : Text(
                                'Hello!\n${_userInfoController.displayName}',
                                softWrap: true,
                                style:
                                    TextConsts(size: 20, color: Colors.white),
                              );
                      }),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(width: 165, child: _buildDrawerItems(context)),
          Spacer(),
          Container(width: 165, child: _buildBottomDrawerItems()),
        ],
      ),
    );
  }

  Widget _buildDrawerItems(BuildContext context) {
    final _routeController = Get.put(DrawerRouteController(), permanent: true);

    return Column(
        children: DrawerItems.upperDrawer
            .map(
              (item) => ListTile(
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                onTap: () => _routeController.getRoute(item),
                title: Text(
                  item.title,
                  style: TextStyle(color: Colors.white),
                ),
                leading: Icon(
                  item.icon,
                  color: Colors.white,
                ),
              ),
            )
            .toList());
  }

  Widget _buildBottomDrawerItems() {
    LogoutController _logoutController = Get.put(LogoutController());
    final _routeController = Get.put(DrawerRouteController(), permanent: true);

    return Column(
        children: DrawerItems.bottomDrawer
            .map(
              (item) => ListTile(
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                onTap: () {
                  _routeController.getRoute(item);
                  if (item == DrawerItems.logout) {
                    _logoutController.logout();
                  }
                },
                title: Text(
                  item.title,
                  style: TextStyle(color: Colors.white),
                ),
                leading: Icon(
                  item.icon,
                  color: Colors.white,
                ),
              ),
            )
            .toList());
  }
}
