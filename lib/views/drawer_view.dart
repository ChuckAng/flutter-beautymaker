import 'package:beautymaker/components/drawer_items.dart';
import 'package:beautymaker/controllers/animated_controller.dart';
import 'package:beautymaker/controllers/logout_controller.dart';
import 'package:beautymaker/services/user_info_firebase.dart';
import 'package:flutter/material.dart';
import 'package:getxfire/getxfire.dart';

class DrawerView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    UserInfoFirebase _userInfoController = Get.put(UserInfoFirebase());
    AnimatedController _animatedController = Get.put(AnimatedController());
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
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    image: DecorationImage(
                        image: NetworkImage(
                            "https://learnyzen.com/wp-content/uploads/2017/08/test1-481x385.png")),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
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
                                _userInfoController.displayName,
                                softWrap: true,
                                style: TextStyle(fontSize: 23),
                              );
                      }),
                ),
              ],
            ),
          ),
          Container(width: 165, child: _buildDrawerItems(context)),
          Divider(
            height: 100,
            endIndent: 235,
            indent: 15,
            thickness: 1.0,
            color: Colors.grey,
          ),
          Container(width: 165, child: _buildBottomDrawerItems(context)),
        ],
      ),
    );
  }

  Widget _buildDrawerItems(BuildContext context) {
    return Column(
        children: DrawerItems.all
            .map(
              (item) => ListTile(
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                onTap: () {},
                title: Text(
                  item.title,
                  style: TextStyle(color: Colors.black),
                ),
                leading: Icon(
                  item.icon,
                  color: Colors.black,
                ),
              ),
            )
            .toList());
  }

  Widget _buildBottomDrawerItems(BuildContext context) {
    LogoutController _logoutController = Get.put(LogoutController());

    return Column(
        children: DrawerItems.bottomDrawer
            .map(
              (item) => ListTile(
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                onTap: () {
                  switch (item) {
                    case DrawerItems.logout:
                      _logoutController.logout();
                      break;
                    default:
                      debugPrint('Invalid selection');
                  }
                },
                title: Text(
                  item.title,
                  style: TextStyle(color: Colors.black),
                ),
                leading: Icon(
                  item.icon,
                  color: Colors.black,
                ),
              ),
            )
            .toList());
  }
}
