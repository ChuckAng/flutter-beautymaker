import 'dart:ui';

import 'package:beautymaker/controllers/product_controller.dart';
import 'package:beautymaker/models/carousel_model.dart';
import 'package:beautymaker/views/list_view.dart';
import 'package:flutter/material.dart';
import 'package:getxfire/getxfire.dart';
import "package:flutter_feather_icons/flutter_feather_icons.dart";
import 'package:beautymaker/utils/ui/cart_item_box.dart';
import 'package:beautymaker/controllers/animated_controller.dart';
import 'package:beautymaker/views/cart_view.dart';
import 'package:beautymaker/views/grid_view.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.height;

    final _productController = Get.put(ProductController());
    AnimatedController _listController = Get.put(AnimatedController());
    AnimatedController _wordFadeController = Get.put(AnimatedController());

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
                              Positioned(
                                  right: 3, top: 4, child: CartItemCountBox()),
                              IconButton(
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                icon: Icon(
                                  FeatherIcons.shoppingCart,
                                  size: 27,
                                ),
                                onPressed: () {
                                  Get.to(
                                    () => Cart(),
                                  );
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                CarouselSlider(
                  options: CarouselOptions(
                    autoPlay: true,
                    enlargeCenterPage: true,
                    autoPlayInterval: Duration(seconds: 2),
                    viewportFraction: 0.75,
                    autoPlayCurve: Curves.fastOutSlowIn,
                    scrollDirection: Axis.horizontal,
                  ),
                  items: featuredImages.map((_images) {
                    return Container(
                      height: size * .25,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(_images.url))),
                    );
                  }).toList(),
                ),
                SizedBox(height: 15),
                Expanded(
                  child: Obx(
                    () {
                      if (_productController.isLoading.value == true) {
                        return Center(
                          child: CircularProgressIndicator(
                              color: Colors.black, strokeWidth: 1.5),
                        );
                      } else {
                        if (_listController.isGrid.value) {
                          return const BuildListView();
                        }

                        return const BuildGridView();
                      }
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
