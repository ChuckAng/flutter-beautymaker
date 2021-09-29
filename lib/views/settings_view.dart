import 'package:beautymaker/controllers/logout_controller.dart';
import 'package:beautymaker/utils/services/user_info_firebase.dart';
import 'package:beautymaker/utils/ui/text_const.dart';
import 'package:beautymaker/views/profile.dart';
import 'package:beautymaker/views/reset_pass_view.dart';
import 'package:beautymaker/views/user_order_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:getxfire/getxfire.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final _userInfoFirebase = Get.put(UserInfoFirebase());
    final _logoutController = Get.put(LogoutController());

    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(
            'Settings',
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
          toolbarHeight: 65,
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        backgroundColor: Colors.brown[50],
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 18.0, bottom: 10),
              child: Text(
                'My Profile',
                style: TextConsts(size: 16),
              ),
            ),
            InkWell(
              onTap: () {
                Get.to(() => Profile());
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(18),
                      bottomRight: Radius.circular(20)),
                  color: Colors.white,
                ),
                height: 65,
                width: size.width * .85,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 22.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 170,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(
                              FeatherIcons.user,
                            ),
                            Text(
                              'Profile Update',
                              style: TextConsts(size: 15),
                            ),
                          ],
                        ),
                      ),
                      Icon(FeatherIcons.arrowRight),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 18.0, bottom: 10, top: 20),
              child: Text(
                'My Orders',
                style: TextConsts(size: 16),
              ),
            ),
            InkWell(
              onTap: () {
                Get.to(() => UserOrderPage());
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(18),
                      bottomRight: Radius.circular(20)),
                  color: Colors.white,
                ),
                height: 65,
                width: size.width * .85,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 22.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 150,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(
                              FontAwesomeIcons.receipt,
                            ),
                            Text(
                              'View orders',
                              style: TextConsts(size: 15),
                            ),
                          ],
                        ),
                      ),
                      Icon(FeatherIcons.arrowRight),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 18.0, bottom: 10, top: 20),
              child: Text(
                'Security Settings',
                style: TextConsts(size: 16),
              ),
            ),
            InkWell(
              onTap: () {
                Get.to(() => ResetPasswordPage(),
                    arguments: _userInfoFirebase.emailUid);
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(18),
                      bottomRight: Radius.circular(20)),
                  color: Colors.white,
                ),
                height: 65,
                width: size.width * .85,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 22.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 180,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(
                              FeatherIcons.lock,
                            ),
                            Text(
                              'Password Update',
                              style: TextConsts(size: 15),
                            ),
                          ],
                        ),
                      ),
                      Icon(FeatherIcons.arrowRight),
                    ],
                  ),
                ),
              ),
            ),
            Spacer(),
            InkWell(
              onTap: () {
                _logoutController.logout();
              },
              child: Align(
                alignment: Alignment.bottomRight,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(18),
                        bottomLeft: Radius.circular(20)),
                    color: Colors.white,
                  ),
                  height: 65,
                  width: size.width * .85,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 22.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(FeatherIcons.arrowLeft),
                        Container(
                          width: 120,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Logout',
                                style: TextConsts(size: 15),
                              ),
                              Icon(
                                FeatherIcons.userCheck,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
          ],
        ));
  }
}
