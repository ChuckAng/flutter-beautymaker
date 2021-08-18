import 'package:beautymaker/controllers/animController.dart';
import 'package:beautymaker/controllers/productcontroller.dart';
import 'package:beautymaker/views/product_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:getxfire/getxfire.dart';

class BuildGridView extends StatelessWidget {
  const BuildGridView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ProductController _productController = Get.put(ProductController());
    AnimatedController _listController = Get.put(AnimatedController());
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: StaggeredGridView.countBuilder(
            padding: EdgeInsets.zero,
            crossAxisCount: 2,
            crossAxisSpacing: 25,
            mainAxisSpacing: 35,
            itemCount: _productController.productList.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Get.to(() => ProductDetail(), arguments: index);
                },
                child: Container(
                  width: size.width,
                  height: size.height * 0.35,
                  decoration: BoxDecoration(
                      color: Colors.white, borderRadius: BorderRadius.circular(28)),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 25, vertical: 15),
                        child: AspectRatio(
                          aspectRatio: 1.2,
                          child: Hero(
                            tag: _productController.productList[index]["name"],
                            child: Container(
                              height: size.height * 0.35 * .5,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(30),
                                      topRight: Radius.circular(30)),
                                  image: DecorationImage(
                                      fit: BoxFit.scaleDown,
                                      image: NetworkImage(
                                        _productController.productList[index]
                                            ["image_link"],
                                      ))),
                            ),
                          ),
                        ),
                      ),
                      Flexible(
                        fit: FlexFit.tight,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                            "${_productController.productList[index]["name"]}",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 17,
                                fontFamily: 'Synemono'),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Expanded(
                              child: Text(
                                "\$${_productController.productList[index]["price"]}",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontWeight: FontWeight.w900,
                                    fontSize: 20,
                                    fontFamily: 'Synemono'),
                              ),
                            ),
                            CircleAvatar(
                              backgroundColor: Colors.black,
                              radius: 18,
                              child: IconButton(
                                alignment: Alignment.center,
                                icon: Icon(
                                  Icons.favorite_rounded,
                                  size: 18,
                                  color: Colors.white,
                                ),
                                onPressed: () {},
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
            staggeredTileBuilder: (index) =>
                StaggeredTile.count(1, index.isEven ? 2.0 : 1.7)),
      ),
    );
  }
}
