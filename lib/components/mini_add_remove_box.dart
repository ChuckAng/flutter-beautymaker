import 'package:beautymaker/controllers/product_controller.dart';
import 'package:flutter/material.dart';
import 'package:getxfire/getxfire.dart';

class MiniAddRemoveItemBox extends StatelessWidget {
  const MiniAddRemoveItemBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ProductController _productController = Get.put(ProductController());
    return Container(
      height: 50,
      width: 50,
      child: Row(
        children: [
          Text("x"),
          
        ],
      ),
    );
  }
}
