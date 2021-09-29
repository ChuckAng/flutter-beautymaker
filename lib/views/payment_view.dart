import 'package:beautymaker/utils/services/stripe_services.dart';
import 'package:beautymaker/utils/ui/text_const.dart';
import 'package:beautymaker/utils/services/user_info_firebase.dart';
import 'package:beautymaker/views/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:getxfire/getxfire.dart';
import 'package:collection/collection.dart';

class PaymentView extends StatelessWidget {
  const PaymentView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    UserInfoFirebase _getCartRef = Get.put(UserInfoFirebase());
    final _paymentController =
        Get.put(StripePaymentServices(), permanent: true);

    return StreamBuilder<QuerySnapshot>(
        stream: _getCartRef.checkoutItem,
        builder: (context, snapshot) {
          List totalPrice = [];
          double totalPayment = 0;
          var id;
          double? subtotal = 0;

          snapshot.data?.docs.forEachIndexed((index, element) {
            double price = element.get('price');

            int quantity = element.get('quantity');
            bool isSelected = snapshot.data?.docs[index]['is_selected'];

            if (isSelected == true) {
              id = element.get('id');
            }

            subtotal = (quantity * price);
            totalPrice.addIf(isSelected, subtotal);
          });

          totalPayment = totalPrice.fold(
              0, (previousValue, element) => previousValue + element);
          String totalPay = totalPayment.toStringAsFixed(2);
          String totalPayIncludeDelivery =
              (totalPayment + 6).toStringAsFixed(2);

          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              title: Text(
                "Checkout",
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
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: StreamBuilder<QuerySnapshot>(
                      stream: _getCartRef.getUserInfo,
                      builder: (context, snapshot) {
                        String userAddress = "";
                        String userName = "";
                        String userPhone = "";
                        snapshot.data?.docs.forEach((element) {
                          userAddress = element.get('address');
                          userName = element.get('name');
                          userPhone = element.get('phone_number');
                        });

                        return Container(
                          height: size.height * .22,
                          width: size.width * .9,
                          decoration: BoxDecoration(
                            color: Colors.brown[100],
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 15, left: 15, right: 15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      FeatherIcons.mapPin,
                                      size: 20,
                                    ),
                                    SizedBox(width: 10),
                                    Text(
                                      'Default Address:',
                                      textAlign: TextAlign.start,
                                      style: TextConsts(
                                          size: 20,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10),
                                Row(
                                  children: [
                                    Text(
                                      '$userName | ',
                                      style: TextStyle(fontSize: 16),
                                    ),
                                    Text(
                                      '$userPhone',
                                      style: TextStyle(fontSize: 16),
                                    )
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    top: 10.0,
                                  ),
                                  child: Text(
                                    '$userAddress',
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ),
                                Align(
                                    alignment: Alignment.bottomRight,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 5.0, right: 10),
                                      child: TextButton(
                                          onPressed: () {
                                            Get.to(() => Profile());
                                          },
                                          child: Text(
                                            'Edit',
                                            style: TextConsts(size: 16),
                                          )),
                                    )),
                              ],
                            ),
                          ),
                        );
                      }),
                ),
                SizedBox(
                  height: 15,
                ),
                _checkoutList(getCartRef: _getCartRef, size: size),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Merchandise subtotal:',
                            style: TextConsts(
                                size: 18, fontWeight: FontWeight.bold),
                          ),
                          Text('\$$totalPay',
                              style: TextConsts(
                                  size: 18, fontWeight: FontWeight.bold)),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Shipping fee:',
                              style: TextConsts(
                                  size: 18, fontWeight: FontWeight.bold)),
                          Text(totalPayment == 0 ? '-' : ' \$6.00',
                              style: TextConsts(
                                  size: 18, fontWeight: FontWeight.bold)),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Total amount:',
                              style: TextConsts(
                                  size: 18, fontWeight: FontWeight.bold)),
                          Text('\$$totalPayIncludeDelivery',
                              style: TextConsts(
                                  size: 18, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 15.0, top: 15),
                  child: Center(
                    child: Obx(() =>
                        _paymentController.paymentLoading.value == false
                            ? ElevatedButton(
                                style: ButtonStyle(
                                    elevation: MaterialStateProperty.all(0),
                                    fixedSize: MaterialStateProperty.all<Size>(
                                        Size(200, 50)),
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.brown[300]!),
                                    shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                    ))),
                                onPressed: () async {
                                  _paymentController.makePayment(
                                      double.parse(totalPayIncludeDelivery));
                                },
                                child: Text(
                                  "Place Order",
                                  style: TextConsts(
                                    color: Colors.white,
                                    size: 16,
                                  ),
                                ),
                              )
                            : CircularProgressIndicator(
                                color: Colors.black, strokeWidth: 1.5)),
                  ),
                ),
              ],
            ),
          );
        });
  }
}

class _checkoutList extends StatelessWidget {
  const _checkoutList({
    Key? key,
    required UserInfoFirebase getCartRef,
    required this.size,
  })  : _getCartRef = getCartRef,
        super(key: key);

  final UserInfoFirebase _getCartRef;
  final Size size;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: StreamBuilder<QuerySnapshot>(
          stream: _getCartRef.checkoutItem,
          builder: (context, snapshot) {
            return ListView.builder(
                itemCount: snapshot.data?.docs.length == null
                    ? 0
                    : snapshot.data!.docs.length,
                itemExtent: 140,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Container(
                        height: size.height * .15,
                        width: size.width * .9,
                        decoration: BoxDecoration(
                            color: Colors.brown[50],
                            borderRadius: BorderRadius.circular(20)),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Container(
                                    height: 100,
                                    child: Image.network(
                                        snapshot.data?.docs[index]['image'])),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 25.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    'Item: ${snapshot.data?.docs[index]['name']}',
                                    style: TextConsts(
                                        size: 15,
                                        fontWeight: FontWeight.normal),
                                  ),
                                  Text(
                                    'Quantity: ${snapshot.data?.docs[index]['quantity']}',
                                    style: TextConsts(
                                        size: 15,
                                        fontWeight: FontWeight.normal),
                                  ),
                                  Text(
                                    'Unit Price: ${snapshot.data?.docs[index]['price']}',
                                    style: TextConsts(
                                        size: 15,
                                        fontWeight: FontWeight.normal),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                });
          }),
    );
  }
}
