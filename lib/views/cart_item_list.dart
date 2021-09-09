import 'package:beautymaker/components/add_remove_item_box.dart';
import 'package:beautymaker/components/text_const.dart';
import 'package:beautymaker/controllers/cart_controller.dart';
import 'package:beautymaker/controllers/product_controller.dart';
import 'package:beautymaker/services/user_info_firebase.dart';
import 'package:flutter/material.dart';
import 'package:getxfire/getxfire.dart';

class CartItemList extends StatelessWidget {
  const CartItemList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    ProductController _productController = Get.put(ProductController());
    UserInfoFirebase _getCartItemRef = Get.put(UserInfoFirebase());

    return FutureBuilder<QuerySnapshot>(
        future: _getCartItemRef.cartData.get(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          var document = snapshot.data?.docs;

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          if (snapshot.hasData) {
            if (snapshot.connectionState == ConnectionState.done) {
              return _buildProductCard(
                  document: document!,
                  size: size,
                  productController: _productController);
            }
          }

          return CircularProgressIndicator();
        });
  }
}

class _buildProductCard extends StatelessWidget {
  const _buildProductCard({
    Key? key,
    required this.document,
    required this.size,
    required ProductController productController,
  })  : _productController = productController,
        super(key: key);

  final List<QueryDocumentSnapshot<Object?>> document;
  final Size size;

  final ProductController _productController;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: document.length,
        itemExtent: 140,
        itemBuilder: (context, index) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 120,
                width: size.width * .82,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.brown[50],
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 10.0,
                  ),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                            height: 100,
                            child: FittedBox(
                              fit: BoxFit.fill,
                              child: Image.network(document[index]['image']),
                            )),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "${document[index]['name']}",
                                  style: TextConsts(
                                      size: 16, fontWeight: FontWeight.w700),
                                ),
                                Obx(
                                  () => InkWell(
                                    onTap: () {
                                      _productController.isTicked.value =
                                          !_productController.isTicked.value;
                                    },
                                    child: Container(
                                      margin:
                                          EdgeInsets.only(top: 10, right: 10),
                                      height: 30,
                                      width: 30,
                                      decoration: BoxDecoration(
                                          border: Border.all(width: 1.0),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: _productController
                                                      .isTicked.value ==
                                                  true
                                              ? Colors.brown[100]!
                                                  .withOpacity(0.5)
                                              : Colors.transparent),
                                      child: Icon(
                                        Icons.check,
                                        color:
                                            _productController.isTicked.value ==
                                                    true
                                                ? Colors.black
                                                : Colors.transparent,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              "${document[index]['category']}",
                              style: TextConsts(
                                  size: 14, fontWeight: FontWeight.w200),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "\$${document[index]['price']}",
                                  textAlign: TextAlign.left,
                                  softWrap: true,
                                  style: TextConsts(
                                      size: 16, fontWeight: FontWeight.w600),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 10.0),
                                  child: AddRemoveItemBox(
                                      productController: _productController,
                                      height: 30,
                                      width: 85),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        });
  }
}
