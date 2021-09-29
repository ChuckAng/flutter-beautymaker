import 'package:beautymaker/utils/services/user_info_firebase.dart';
import 'package:flutter/material.dart';
import 'package:getxfire/getxfire.dart';

/* **********************************

  Show number of item in cart real time

************************************** */

class CartItemCountBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    UserInfoFirebase _getCartItemRef = Get.put(UserInfoFirebase());

    return StreamBuilder<QuerySnapshot>(
        stream: _getCartItemRef.cartStream,
        builder: (context, snapshot) {
          return Container(
            height: 15,
            width: 15,
            decoration: BoxDecoration(
                color: snapshot.data?.docs.length == 0 
                    ? Colors.transparent
                    : Colors.black,
                borderRadius: BorderRadius.circular(3)),
            child: Center(
              child: Text(
                "${snapshot.data?.docs.length}",
                style: TextStyle(
                    fontSize: 12,
                    color: snapshot.data?.docs.length == 0
                        ? Colors.transparent
                        : Colors.white),
              ),
            ),
          );
        });
  }
}
