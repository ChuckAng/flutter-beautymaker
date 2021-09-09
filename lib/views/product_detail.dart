import 'package:beautymaker/components/add_remove_item_box.dart';
import 'package:beautymaker/components/text_const.dart';
import 'package:beautymaker/controllers/animated_controller.dart';
import 'package:beautymaker/controllers/cart_controller.dart';
import 'package:beautymaker/controllers/product_controller.dart';
import 'package:beautymaker/services/user_info_firebase.dart';
import 'package:beautymaker/views/cart_view.dart';
import 'package:beautymaker/components/rating_bar.dart';
import 'package:flutter/material.dart';
import 'package:getxfire/getxfire.dart';
import 'package:hexcolor/hexcolor.dart';

class ProductDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    ProductController _productController = Get.put(ProductController());
    AnimatedController _addToCartController = Get.put(AnimatedController());

    dynamic index;
    index = Get.arguments;
    String rating =
        _productController.productList[index[0]]["rating"].toString();
    String productId =
        _productController.productList[index[0]]['id'].toString();
    print(index);
    print(productId);
    if (rating == "null") {
      rating = "N/A";
    }
    var backgroundColor = HexColor('e8e8e8');
    CartController _cartController =
        Get.put(CartController(data: productId, index: index));
    UserInfoFirebase _userInfo = Get.put(UserInfoFirebase());

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.blueGrey[100],
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
                onTap: () {
                  Get.back();
                  _productController.resetItemCount();
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 35, top: 50),
                  child: const Icon(
                    Icons.arrow_back_ios,
                    size: 30,
                  ),
                )),
            Positioned(
              right: size.width * -.08,
              top: 30,
              height: size.height * .45,
              child: Hero(
                tag: _productController.productList[index[0]]["name"],
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Image(
                    image: NetworkImage(
                        _productController.productList[index[0]]["image_link"]),
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
                    "${_productController.productList[index[0]]["name"]}",
                    textAlign: TextAlign.end,
                    style: TextStyle(fontSize: 24, fontFamily: 'Synemono'),
                  ),
                )),
            Positioned(
              bottom: size.height * .34,
              right: 20,
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
                  BuildStarWidget(index[0]),
                ],
              ),
            ),
            Positioned(
              bottom: size.height * .27,
              child: Container(
                width: size.width,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Row(
                    children: [
                      Text(
                        "\$${_productController.productList[index[0]]["price"]}",
                        textAlign: TextAlign.left,
                        softWrap: true,
                        style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 26,
                            fontFamily: 'Synemono'),
                      ),
                      Spacer(
                        flex: 2,
                      ),
                      AddRemoveItemBox(
                        productController: _productController,
                        height: 33,
                        width: 85,
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      InkWell(
                        splashColor: Colors.red.withOpacity(0.3),
                        onTap: () async {
                          print("add to cart!");
                          await _cartController.addToCart();
                          _userInfo.getProductId();
                          Get.back(result: [index]);
                          print(index);
                          _productController.addIntoCart();
                        },
                        child: Container(
                          alignment: Alignment.center,
                          height: 38,
                          width: 80,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.black),
                          child: const Text("Cart",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            _buildItemDescription(
                productController: _productController, index: index),
          ],
        ),
      ),
    );
  }
}

class _buildItemDescription extends StatelessWidget {
  const _buildItemDescription({
    Key? key,
    required ProductController productController,
    required this.index,
  })  : _productController = productController,
        super(key: key);

  final ProductController _productController;
  final List<int> index;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Spacer(
          flex: 3,
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: SingleChildScrollView(
              child: Theme(
                data: ThemeData(accentColor: Colors.black),
                child: ExpansionTile(
                  onExpansionChanged: (_) {
                    GestureDetector(
                      onTap: () {},
                    );
                  },
                  initiallyExpanded: true,
                  title: Text(
                    'Description',
                    style: TextConsts(fontWeight: FontWeight.w400),
                  ),
                  children: [
                    SingleChildScrollView(
                      child: Text(
                          _productController.productList[index[0]]
                              ['description'],
                          textAlign: TextAlign.center,
                          softWrap: true,
                          style: TextStyle(
                              fontSize: 31,
                              wordSpacing: 8,
                              letterSpacing: 1.5,
                              fontFamily: 'Amatic',
                              fontWeight: FontWeight.w900)),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
