import 'package:beautymaker/controllers/animController.dart';
import 'package:beautymaker/views/drawer_view.dart';
import 'package:beautymaker/views/home.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:get/utils.dart';
import 'package:getxfire/getxfire.dart';
import 'package:beautymaker/controllers/drawerControl.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      //HexColor('c3bec0'),
      body: Stack(
        children: [
          const _buildDrawer(),
          _buildHomePage(),
        ],
      ),
    );
  }
}

class _buildDrawer extends StatelessWidget {
  const _buildDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DrawerView(),
    );
  }
}

class _buildHomePage extends StatelessWidget {
  _buildHomePage({
    Key? key,
  }) : super(key: key);

  
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }

  @override
  Widget build(BuildContext context) {
    final _drawerNotifier = DrawerControl();
    AnimatedController _animatedController = Get.put(AnimatedController());
    return AnimatedContainer(
        duration: 250.milliseconds,
        transform: Matrix4.translationValues(0, 0, 0)..scale(1),
        child: ClipRRect(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30), bottomLeft: Radius.circular(30)),
            child: HomePage(
              openDrawer: _drawerNotifier.openDrawer,
            )));
  }
}
