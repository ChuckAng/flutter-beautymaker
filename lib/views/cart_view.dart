import 'package:beautymaker/components/text_const.dart';
import 'package:beautymaker/controllers/product_controller.dart';
import 'package:beautymaker/views/cart_item_list.dart';
import 'package:flutter/material.dart';
import 'package:getxfire/getxfire.dart';
import 'package:hexcolor/hexcolor.dart';

class Cart extends StatelessWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ProductController _productController = Get.put(ProductController());
    Size size = MediaQuery.of(context).size;
    // int index = [] as int;
    // index = Get.arguments;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          "Cart",
          style: TextStyle(
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.w600),
        ),
        toolbarHeight: 70,
        leadingWidth: 80,
        centerTitle: true,
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios_new,
              size: 18,
            ),
            color: Colors.black,
            onPressed: () {
              Get.back();
            }),
        elevation: 0,
      ),
      backgroundColor: Colors.grey[50],
      body: Column(
        children: [
          Expanded(child: CartItemList()),
          Container(
            height: 130,
            width: size.width,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Selected Item (1)',
                        style: TextConsts(size: 18),
                      ),
                      Text(
                        '\$38.67',
                        style: TextConsts(),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    elevation: MaterialStateProperty.all(0),
                      fixedSize: MaterialStateProperty.all<Size>(Size(200, 50)),
                      backgroundColor: MaterialStateProperty.all<Color>(
                          HexColor('ff212121')),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ))),
                  onPressed: () {
                    debugPrint('Check out');
                  },
                  child: Text(
                    "Check Out",
                    style: TextConsts(
                      color: Colors.white,
                      size: 16,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
