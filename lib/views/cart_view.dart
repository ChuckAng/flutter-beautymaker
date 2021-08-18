import 'package:beautymaker/controllers/productcontroller.dart';
import 'package:flutter/material.dart';
import 'package:getxfire/getxfire.dart';

class Cart extends StatelessWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ProductController _productController = Get.put(ProductController());
    int index = [] as int;
    index = Get.arguments;
    
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back_ios_new),
                    onPressed: () {
                      Get.back();
                    },
                  ),
                  Spacer(
                    flex: 2,
                  ),
                  Text(
                    "Cart",
                    style: TextStyle(fontSize: 23, fontWeight: FontWeight.w600),
                  ),
                  Spacer(
                    flex: 3,
                  ),
                ],
              ),
            ),
          //  ...List.generate(10, generator)
          ],
        ),
      ),
    );
  }
}
