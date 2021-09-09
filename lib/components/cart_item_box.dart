import 'package:beautymaker/controllers/product_controller.dart';
import 'package:flutter/material.dart';
import 'package:getxfire/getxfire.dart';
import 'package:hexcolor/hexcolor.dart';

class CartItemBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ProductController _productController = Get.put(ProductController());
    return CartIemCountBox(_productController);
  }
}

Widget CartIemCountBox(ProductController _productController) {
  var backgroundColor = HexColor('edebeb');
  return Container(
    height: 14,
    width: 14,
    decoration: BoxDecoration(
        color: _productController.cartItem.value == 0
            ? Colors.transparent
            : Colors.black,
        borderRadius: BorderRadius.circular(3)),
    child: Center(
      child: Text(
        "${_productController.cartItem.value}",
        style: TextStyle(
            fontSize: 12,
            color: _productController.cartItem.value == 0
                ? Colors.transparent
                : Colors.white),
      ),
    ),
  );
}
