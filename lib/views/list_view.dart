import 'package:beautymaker/components/favourite_button.dart';
import 'package:beautymaker/components/text_const.dart';
import 'package:beautymaker/controllers/product_controller.dart';
import 'package:beautymaker/views/product_detail.dart';
import 'package:flutter/material.dart';
import 'package:getxfire/getxfire.dart';

class BuildListView extends StatelessWidget {
  const BuildListView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ProductController _productController = Get.put(ProductController());
    Size size = MediaQuery.of(context).size;

    return ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: _productController.productList.length,
        itemExtent: 180,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Get.to(() => ProductDetail(),
                  arguments: [index, _productController.itemCount.value]);
            },
            child: Padding(
              padding: const EdgeInsets.only(bottom: 15),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(35),
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 18.0),
                    child: Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              scale: 1.6,
                              alignment: Alignment.centerLeft,
                              image: NetworkImage(_productController
                                  .productList[index]["image_link"]))),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 150.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 150,
                              width: 160,
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 5),
                                    child: Text(
                                      "${_productController.productList[index]["name"]}",
                                      textAlign: TextAlign.center,
                                      style: TextConsts(size: 16),
                                    ),
                                  ),
                                  Spacer(),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 5.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text(
                                          "\$${_productController.productList[index]["price"]}",
                                          textAlign: TextAlign.left,
                                          style: TextConsts(),
                                        ),
                                        SizedBox(
                                          width: 40,
                                        ),
                                        FavouriteButton(),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }
}
