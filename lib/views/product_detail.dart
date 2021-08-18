import 'package:beautymaker/controllers/animController.dart';
import 'package:beautymaker/controllers/productcontroller.dart';
import 'package:beautymaker/views/cart_view.dart';
import 'package:beautymaker/const/ratingBar.dart';
import 'package:flutter/material.dart';
import 'package:getxfire/getxfire.dart';
import 'package:hexcolor/hexcolor.dart';

class ProductDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    ProductController _productController = Get.put(ProductController());
    AnimatedController _addToCartController = Get.put(AnimatedController());
    int index;
    index = Get.arguments;
    String rating = _productController.productList[index]["rating"].toString();
    if (rating == "null") {
      rating = "N/A";
    }
    var backgroundColor = HexColor('cccccc');
    //c3bec0
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[300],
        body: Stack(
          children: [
            Container(),
            Positioned(
              right: 0,
              width: size.width * .8,
              top: 0,
              height: size.height * .84,
              child: ClipRRect(
                borderRadius:
                    BorderRadius.only(bottomLeft: Radius.circular(40)),
                child: Container(
                  child: ColoredBox(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            GestureDetector(
                onTap: () => Get.back(),
                child: Padding(
                  padding: const EdgeInsets.only(left: 35, top: 50),
                  child: Icon(
                    Icons.arrow_back_ios,
                    size: 30,
                  ),
                )),
            Positioned(
              right: size.width * -.08,
              top: 30,
              height: size.height * .45,
              child: Hero(
                tag: _productController.productList[index]["name"],
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Image(
                    image: NetworkImage(
                        _productController.productList[index]["image_link"]),
                    height: size.height * .4,
                    width: size.width,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
            Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.only(top: 90, right: 25, left: 25),
                  child: Text(
                    "${_productController.productList[index]["name"]}",
                    textAlign: TextAlign.end,
                    style: TextStyle(fontSize: 24, fontFamily: 'Synemono'),
                  ),
                )),
            Column(
              children: [
                Spacer(
                  flex: 3,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 180, bottom: 25),
                  child: Row(
                    children: [
                      Text(
                        rating,
                        textAlign: TextAlign.end,
                        style: TextStyle(fontSize: 25, fontFamily: 'Synemono'),
                      ),
                      SizedBox(
                        width: 25,
                      ),
                      BuildStarWidget(index),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 35.0),
                      child: Text(
                        "\$${_productController.productList[index]["price"]}",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 26,
                            fontFamily: 'Synemono'),
                      ),
                    ),
                    Row(
                      children: [
                        Container(
                          alignment: Alignment.center,
                          height: 40,
                          width: 85,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(width: 0.5, color: Colors.black),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              InkWell(
                                  onTap: () => print("minus!"),
                                  child: Icon(
                                    Icons.remove,
                                    size: 18,
                                    color: Colors.black87,
                                  )),
                              Text("1"),
                              InkWell(
                                  onTap: () => print("plus!"),
                                  child: Icon(
                                    Icons.add,
                                    size: 18,
                                    color: Colors.black87,
                                  )),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 25.0),
                          child: Tooltip(
                            message: 'Add to cart',
                            child: Container(
                              alignment: Alignment.center,
                              height: 40,
                              width: 80,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: Colors.black),
                              child: Text("Cart",
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: Tooltip(
                    message: 'Drag to read more!',
                    verticalOffset: 80,
                    height: 30,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: Text(
                          _productController.productList[index]['description'],
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 32,
                              wordSpacing: 5,
                              letterSpacing: 1,
                              fontFamily: 'Amatic',
                              fontWeight: FontWeight.w900),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
