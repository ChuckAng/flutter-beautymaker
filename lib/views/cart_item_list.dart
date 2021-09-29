import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:beautymaker/utils/ui/build_lottie_animation.dart';
import 'package:beautymaker/utils/ui/text_const.dart';
import 'package:beautymaker/controllers/cart_controller.dart';
import 'package:beautymaker/utils/services/user_info_firebase.dart';
import 'package:flutter/material.dart';
import 'package:getxfire/getxfire.dart';

String url = 'https://assets7.lottiefiles.com/packages/lf20_HwRTPu.json';

class CartItemList extends StatelessWidget {
  const CartItemList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    UserInfoFirebase _getCartItemRef = Get.put(UserInfoFirebase());

    return StreamBuilder<QuerySnapshot>(
        stream: _getCartItemRef.cartDocStream,
        builder: (context, snapshot) {
          var document = snapshot.data;

          if (snapshot.connectionState == ConnectionState.waiting) {
            return _buildProductCard(
              document: document,
              size: size,
            );
          }

          if (snapshot.hasData && snapshot.data?.docs.length != 0) {
            return _buildProductCard(
              document: document,
              size: size,
            );
          } else if (!snapshot.hasData || snapshot.data?.docs.length == 0) {
            return Scaffold(
              body: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Your cart is empty\n',
                    textAlign: TextAlign.center,
                    style: TextConsts(
                        size: 26,
                        color: Colors.grey[600]!,
                        fontWeight: FontWeight.w400),
                  ),
                  Text(
                    'Add something into your cart now ',
                    style: TextConsts(
                        size: 18,
                        fontWeight: FontWeight.w200,
                        color: Colors.grey[600]!),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      BuildLottieAnimation(
                        borderRadius: 0,
                        backgroundColor: Colors.transparent,
                        height: 150,
                        width: 200,
                        lottieUrl: url,
                      ),
                    ],
                  ),
                ],
              ),
            );
          } else {
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(
                  strokeWidth: 2.0,
                  color: Colors.black,
                ),
              ),
            );
          }
        });
  }
}

class _buildProductCard extends StatelessWidget {
  const _buildProductCard({
    Key? key,
    required this.document,
    required this.size,
  }) : super(key: key);

  final QuerySnapshot? document;
  final Size size;

  @override
  Widget build(BuildContext context) {
    CartController _cartController = Get.put(CartController(), permanent: true);

    return SizedBox(
      height: size.height,
      width: size.width,
      child: ListView.builder(
          itemCount: document == null ? 0 : document!.docs.length,
          itemExtent: 140,
          itemBuilder: (context, index) {
            int itemQuantity = document?.docs[index]['quantity'];
            String productId = document?.docs[index]['id'];

            return SizedBox(
              height: size.height,
              width: size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 120,
                      width: size.width,
                      child: Center(
                        child: Dismissible(
                          key: UniqueKey(),
                          secondaryBackground: Container(
                            decoration: BoxDecoration(
                              color: Colors.green[100],
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(right: 35.0),
                              child: Align(
                                  alignment: AlignmentDirectional.centerEnd,
                                  child: Icon(
                                    Icons.favorite_rounded,
                                    size: 26,
                                    color: Colors.pink[700],
                                  )),
                            ),
                          ),
                          background: Container(
                            decoration: BoxDecoration(
                              color: Colors.red[200],
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 35.0),
                              child: Align(
                                  alignment: AlignmentDirectional.centerStart,
                                  child: Icon(Icons.cancel, size: 26)),
                            ),
                          ),
                          direction: DismissDirection.startToEnd,
                          confirmDismiss: (DismissDirection direction) async {
                            if (direction == DismissDirection.startToEnd) {
                              return await showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                        elevation: 0,
                                        backgroundColor:
                                            Colors.black.withOpacity(0.2),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        title: const Text(
                                            'Delete to remove item',
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold)),
                                        content: const Text(
                                            'Remove this item from your cart ?',
                                            style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.white,
                                            )),
                                        actions: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              TextButton(
                                                  onPressed: () {
                                                    Navigator.pop(
                                                        context, false);
                                                  },
                                                  child: Text(
                                                    'Cancel',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 18),
                                                  )),
                                              ElevatedButton(
                                                style: ButtonStyle(
                                                    elevation:
                                                        MaterialStateProperty.all(
                                                            0),
                                                    fixedSize:
                                                        MaterialStateProperty
                                                            .all<Size>(
                                                                Size(100, 50)),
                                                    backgroundColor:
                                                        MaterialStateProperty.all<
                                                                Color>(
                                                            Colors.red[300]!),
                                                    shape: MaterialStateProperty
                                                        .all<RoundedRectangleBorder>(
                                                            RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15.0),
                                                    ))),
                                                onPressed: () {
                                                  Navigator.pop(context, true);
                                                },
                                                child: Text(
                                                  "Delete",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white,
                                                    fontSize: 18,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ]);
                                  });
                            }
                          },
                          onDismissed: (direction) {
                            if (direction == DismissDirection.startToEnd) {
                              _cartController.removeFromCart(
                                  document!.docs[index]['id'].toString());
                              document!.docs.removeAt(index);
                            }
                          },
                          child: Container(
                            height: 120,
                            width: size.width * .83,
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
                                      child: Image.network(
                                          document?.docs[index]['image']),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "${document?.docs[index]['name']}",
                                              style: TextConsts(
                                                  size: 16,
                                                  fontWeight: FontWeight.w700),
                                            ),
                                            InkWell(
                                              onTap: () {
                                                _cartController.selectItem();
                                                _cartController
                                                    .isItemSelected(productId);
                                              },
                                              child: Container(
                                                margin: EdgeInsets.only(
                                                    top: 10, right: 10),
                                                height: 30,
                                                width: 30,
                                                decoration: BoxDecoration(
                                                    border:
                                                        Border.all(width: 1.0),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    color: document?.docs[index]
                                                                [
                                                                'is_selected'] ==
                                                            true
                                                        ? Colors.brown[100]!
                                                            .withOpacity(0.5)
                                                        : Colors.transparent),
                                                child: Icon(Icons.check,
                                                    color: document?.docs[index]
                                                                [
                                                                'is_selected'] ==
                                                            true
                                                        ? Colors.black
                                                        : Colors.transparent),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          "${document?.docs[index]['category']}" ==
                                                  "null"
                                              ? ""
                                              : "${document?.docs[index]['category']}",
                                          style: TextConsts(
                                              size: 14,
                                              fontWeight: FontWeight.w200),
                                        ),
                                        SizedBox(
                                          height: 30,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "\$${document?.docs[index]['price']}",
                                              textAlign: TextAlign.left,
                                              softWrap: true,
                                              style: TextConsts(
                                                  size: 16,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 10.0),
                                              child: Container(
                                                alignment: Alignment.center,
                                                height: 30,
                                                width: 85,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  children: [
                                                    InkWell(
                                                      onLongPress: () {
                                                        return;
                                                      },
                                                      onTap: () {
                                                        itemQuantity--;
                                                        if (itemQuantity < 1) {
                                                          AwesomeDialog(
                                                            context: context,
                                                            animType: AnimType
                                                                .TOPSLIDE,
                                                            dialogType:
                                                                DialogType
                                                                    .WARNING,
                                                            buttonsTextStyle:
                                                                TextStyle(
                                                                    fontSize:
                                                                        20),
                                                            dialogBackgroundColor:
                                                                Colors.black
                                                                    .withOpacity(
                                                                        0.2),
                                                            body: Center(
                                                                child: Text(
                                                                    '\nYou have reached your minimum item capacity\n',
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            16,
                                                                        color: Colors
                                                                            .white))),
                                                            headerAnimationLoop:
                                                                true,
                                                            autoHide: 3.seconds,
                                                            dialogBorderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20),
                                                          )..show();
                                                        } else {
                                                          _cartController
                                                              .modifyItemQuantity(
                                                                  productId,
                                                                  itemQuantity);
                                                        }
                                                      },
                                                      child: Container(
                                                        height: 25,
                                                        width: 25,
                                                        decoration: BoxDecoration(
                                                            color: document?.docs[
                                                                            index]
                                                                        [
                                                                        'quantity'] ==
                                                                    1
                                                                ? Colors
                                                                    .transparent
                                                                : Colors
                                                                    .grey[800],
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8)),
                                                        child: Icon(
                                                          Icons.remove,
                                                          size: 20,
                                                          color: document?.docs[
                                                                          index]
                                                                      [
                                                                      'quantity'] ==
                                                                  1
                                                              ? Colors.grey
                                                              : Colors.white,
                                                        ),
                                                      ),
                                                    ),
                                                    Text(
                                                      "${document?.docs[index]['quantity']}",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    InkWell(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(50),
                                                        onLongPress: () {
                                                          return;
                                                        },
                                                        onTap: () {
                                                          itemQuantity++;
                                                          if (itemQuantity >
                                                              999) {
                                                            AwesomeDialog(
                                                              context: context,
                                                              animType: AnimType
                                                                  .TOPSLIDE,
                                                              dialogType:
                                                                  DialogType
                                                                      .WARNING,
                                                              buttonsTextStyle:
                                                                  TextStyle(
                                                                      fontSize:
                                                                          20),
                                                              dialogBackgroundColor:
                                                                  Colors.black
                                                                      .withOpacity(
                                                                          0.2),
                                                              body: Center(
                                                                  child: Text(
                                                                      '\nYou have reached your maximum item capacity\n',
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              16,
                                                                          color:
                                                                              Colors.white))),
                                                              headerAnimationLoop:
                                                                  true,
                                                              autoHide:
                                                                  3.seconds,
                                                              dialogBorderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20),
                                                            )..show();
                                                          } else {
                                                            _cartController
                                                                .modifyItemQuantity(
                                                                    productId,
                                                                    itemQuantity);
                                                          }
                                                        },
                                                        splashColor: Colors
                                                            .black
                                                            .withOpacity(0.3),
                                                        child: Container(
                                                          height: 25,
                                                          width: 25,
                                                          decoration: BoxDecoration(
                                                              color: Colors
                                                                  .brown[300]!
                                                                  .withOpacity(
                                                                      0.8),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8)),
                                                          child: Icon(
                                                            Icons.add,
                                                            size: 20,
                                                            color: Colors.white,
                                                          ),
                                                        )),
                                                  ],
                                                ),
                                              ),
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
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }
}
