import 'package:beautymaker/utils/ui/text_const.dart';
import 'package:beautymaker/utils/services/user_info_firebase.dart';
import 'package:beautymaker/views/cart_item_list.dart';
import 'package:beautymaker/views/payment_view.dart';
import 'package:flutter/material.dart';
import 'package:getxfire/getxfire.dart';
import 'package:collection/collection.dart';

class Cart extends StatelessWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserInfoFirebase _getCartRef = Get.put(UserInfoFirebase());
    Size size = MediaQuery.of(context).size;

    return StreamBuilder<QuerySnapshot>(
        stream: _getCartRef.countItemSelected,
        builder: (context, snapshot) {
          int? totalSelectedItem = snapshot.data?.docs.length.toInt();
          if (totalSelectedItem == null) {
            totalSelectedItem = 0;
          }
          List totalPrice = [];
          double totalPayment = 0;
          double? subtotal = 0;
          bool isSelected = false;

          snapshot.data?.docs.forEachIndexed((index, element) {
            double price = element.get('price');

            int quantity = element.get('quantity');
            isSelected = snapshot.data?.docs[index]['is_selected'];

            subtotal = (quantity * price);
            totalPrice.addIf(isSelected, subtotal);
          });

          totalPayment = totalPrice.fold(
              0, (previousValue, element) => previousValue + element);
          String totalPay = totalPayment.toStringAsFixed(2);

          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              title: Text(
                "Cart",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w600),
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
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Selected Item ($totalSelectedItem)',
                              style: TextConsts(size: 18),
                            ),
                            Text(
                              '\$$totalPay',
                              style: TextConsts(),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                        style: ButtonStyle(
                            elevation: MaterialStateProperty.all(0),
                            fixedSize:
                                MaterialStateProperty.all<Size>(Size(200, 50)),
                            backgroundColor: snapshot.data?.docs.length == 0 ||
                                    isSelected == false
                                ? MaterialStateProperty.all<Color>(
                                    Colors.grey[350]!)
                                : MaterialStateProperty.all<Color>(
                                    Colors.brown[300]!),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ))),
                        onPressed: () {
                          debugPrint('Check out');
                          if (snapshot.data?.docs.length == 0) {
                            Get.snackbar("Empty cart",
                                "Please add something to your cart",
                                colorText: Colors.white,
                                margin: EdgeInsets.symmetric(
                                    horizontal: 50, vertical: 20),
                                backgroundColor: Colors.black,
                                snackPosition: SnackPosition.BOTTOM,
                                duration: 2.5.seconds);
                          } else {
                            Get.to(
                              () => PaymentView(),
                            );
                          }
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
        });
  }
}
