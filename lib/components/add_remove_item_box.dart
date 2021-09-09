import 'package:beautymaker/controllers/product_controller.dart';
import 'package:flutter/material.dart';
import 'package:getxfire/getxfire.dart';

class AddRemoveItemBox extends StatelessWidget {
  AddRemoveItemBox({
    Key? key,
    required ProductController productController,
    required this.height,
    required this.width,
  })  : _productController = productController,
        super(key: key);

  final ProductController _productController;
  double height = 33;
  double width = 85;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: height,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          InkWell(
              onTap: () {
                _productController.removeItem();
              },
              child: Obx(
                () => Container(
                  height: 25,
                  width: 25,
                  decoration: BoxDecoration(
                      color: _productController.itemCount.value == 1
                          ? Colors.transparent
                          : Colors.grey[800],
                      borderRadius: BorderRadius.circular(8)),
                  child: Icon(
                    Icons.remove,
                    size: 20,
                    color: _productController.itemCount.value == 1
                        ? Colors.grey
                        : Colors.white,
                  ),
                ),
              )),
          Obx(() => Text(
                "${_productController.itemCount.value}",
                style: TextStyle(fontWeight: FontWeight.bold),
              )),
          InkWell(
              borderRadius: BorderRadius.circular(50),
              onTap: () => _productController.addItem(),
              splashColor: Colors.black.withOpacity(0.3),
              child: Container(
                height: 25,
                width: 25,
                decoration: BoxDecoration(
                    color: Colors.brown[300]!.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(8)),
                child: Icon(
                  Icons.add,
                  size: 20,
                  color: Colors.white,
                ),
              )),
        ],
      ),
    );
  }
}
