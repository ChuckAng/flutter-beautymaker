import 'package:beautymaker/const/drawerItems.dart';
import 'package:beautymaker/controllers/animController.dart';
import 'package:flutter/material.dart';
import 'package:getxfire/getxfire.dart';

class DrawerView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AnimatedController _animatedController = Get.put(AnimatedController());

    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(left: 30, top: 40, bottom: 20),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      print("back");
                      _animatedController.onClickBeauty();
                      print('${_animatedController.test.value}');
                    },
                    icon: Icon(
                      Icons.arrow_back_ios_new,
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  CircleAvatar(
                      radius: 23,
                      backgroundImage: NetworkImage(
                          "https://learnyzen.com/wp-content/uploads/2017/08/test1-481x385.png")),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    "John Doe",
                    style: TextStyle(fontSize: 23),
                  ),
                ],
              ),
            ),
            _buildDrawerItems(context),
          ],
        ),
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
}
