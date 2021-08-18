import 'dart:ui';

import 'package:beautymaker/const/drawerItems.dart';
import 'package:beautymaker/views/drawer_view.dart';
import 'package:flutter/material.dart';
import 'package:getxfire/getxfire.dart';
import 'package:hexcolor/hexcolor.dart';
import "package:flutter_feather_icons/flutter_feather_icons.dart";
import 'package:beautymaker/const/cartItemBox.dart';
import 'package:beautymaker/controllers/animController.dart';
import 'package:beautymaker/controllers/productcontroller.dart';
import 'package:beautymaker/views/cart_view.dart';
import 'package:beautymaker/views/grid_view.dart';

class HomePage extends StatelessWidget {
  final VoidCallback openDrawer;

  HomePage({Key? key, required this.openDrawer}) : super(key: key);

  String _cartTag = "";
  final backgroundColor = HexColor('edebeb');
  //edebeb
  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.height;
    AnimatedController _listController = Get.put(AnimatedController());
    ProductController _productController = Get.put(ProductController());
    return SafeArea(
      child: Scaffold(
        backgroundColor: backgroundColor,
        body: Stack(children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 15, right: 10),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          openDrawer();
                          print("tapped");
                        },
                        child: Text(
                          "Beauty",
                          style: TextStyle(
                            color: Colors.black54,
                            fontWeight: FontWeight.w300,
                            fontSize: 22,
                            letterSpacing: 5,
                          ),
                        ),
                      ),
                      Text(
                        "Maker",
                        style: TextStyle(
                            fontWeight: FontWeight.w800,
                            letterSpacing: 4,
                            fontSize: 22,
                            fontFamily: 'Synemono'),
                      ),
                      Spacer(),
                      Row(
                        children: [
                          IconButton(
                            padding: EdgeInsets.only(left: 30),
                            onPressed: () {
                              _listController.toggleIcon();
                            },
                            iconSize: 27,
                            icon: AnimatedIcon(
                                icon: AnimatedIcons.list_view,
                                progress: _listController.animationController),
                          ),
                          Stack(
                            children: [
                              Obx(
                                () => Positioned(
                                  right: 3,
                                  top: 4,
                                  child: CartIemCountBox(_productController),
                                ),
                              ),
                              IconButton(
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                icon: Icon(
                                  FeatherIcons.shoppingCart,
                                  size: 27,
                                ),
                                onPressed: () {
                                  Get.to(() => Cart());
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Obx(
                    () {
                      if (_productController.isLoading.value) {
                        return Center(
                          child: CircularProgressIndicator(
                            color: Colors.black,
                          ),
                        );
                      }
                      if (_listController.isGrid.value) {
                        return ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: 10,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  _productController.addIntoCart();
                                  print("listview is tapped!");
                                  _listController.onClickBeauty();
                                  print('${_listController.test.value}');
                                },
                                child: Card(
                                  child: Container(
                                    height: 50,
                                    width: 200,
                                    child: Image.network(_productController
                                        .productList[index]["image_link"]),
                                  ),
                                ),
                              );
                            });
                      }

                      return BuildGridView();
                    },
                  ),
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
