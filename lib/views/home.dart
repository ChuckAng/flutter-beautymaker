import 'dart:ui';

import 'package:beautymaker/components/favourite_button.dart';
import 'package:beautymaker/components/text_const.dart';
import 'package:beautymaker/views/list_view.dart';
import 'package:beautymaker/views/product_detail.dart';
import 'package:flutter/material.dart';
import 'package:getxfire/getxfire.dart';
import 'package:hexcolor/hexcolor.dart';
import "package:flutter_feather_icons/flutter_feather_icons.dart";
import 'package:beautymaker/components/cart_item_box.dart';
import 'package:beautymaker/controllers/animated_controller.dart';
import 'package:beautymaker/controllers/product_controller.dart';
import 'package:beautymaker/views/cart_view.dart';
import 'package:beautymaker/views/grid_view.dart';

class HomePage extends StatelessWidget {
  String _cartTag = "";

  //  List<int> data = Get.arguments;
  dynamic data = Get.arguments;

  final backgroundColor = HexColor('e8e8e8');
  //edebeb
  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.height;
    
    
    AnimatedController _listController = Get.put(AnimatedController());
    AnimatedController _scrollController = Get.put(AnimatedController());
    AnimatedController _wordFadeController = Get.put(AnimatedController());
    ProductController _productController = Get.put(ProductController());
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.blueGrey[50],
        body: Stack(children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      top: 15, left: 15, right: 10, bottom: 10),
                  child: Row(
                    children: [
                      FadeTransition(
                        opacity: _wordFadeController.wordFadingController,
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
                      FadeTransition(
                        opacity: _wordFadeController.wordFadingController,
                        child: Text(
                          "Maker",
                          style: TextStyle(
                              fontWeight: FontWeight.w800,
                              letterSpacing: 4,
                              fontSize: 22,
                              fontFamily: 'Synemono'),
                        ),
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
                                progress:
                                    _listController.listAnimationController),
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
                                  Get.to(() => Cart(), arguments: data);
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
                        return const BuildListView();
                      }

                      return const BuildGridView();
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
