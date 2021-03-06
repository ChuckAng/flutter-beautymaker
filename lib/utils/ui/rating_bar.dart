import 'package:beautymaker/controllers/product_controller.dart';
import 'package:flutter/material.dart';
import 'package:getxfire/getxfire.dart';

class BuildStarWidget extends StatelessWidget {
  ProductController _productController = Get.put(ProductController());
  final int maxRating = 5;
  final int _productIndex;
  BuildStarWidget(this._productIndex);

  Widget _buildBody() {
    final stars = List<Widget>.generate(maxRating, (index) {
      if (_productController.productList[_productIndex]["rating"] == null) {
        return Icon(Icons.star_border_outlined);
      } else if (_productController.productList[_productIndex]["rating"] <=
          index) {
        return Icon(Icons.star_border_outlined);
      } else if (_productController.productList[_productIndex]["rating"] ==
          index + 0.5) {
        return Icon(Icons.star_half_outlined);
      } else if (_productController.productList[_productIndex]["rating"] >= 4 &&
          index == 4) {
        if (_productController.productList[_productIndex]["rating"] == 5 &&
            index == 4) {
          return Icon(Icons.star);
        }
        if (_productController.productList[_productIndex]["rating"] == 4 &&
            index == 4) {
          return Icon(Icons.star_border_outlined);
        }
        return Icon(Icons.star_half_outlined);
      }

      return Icon(Icons.star);
    });

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: stars,
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildBody();
  }
}
