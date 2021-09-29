import 'package:beautymaker/utils/services/user_info_firebase.dart';
import 'package:beautymaker/utils/ui/build_lottie_animation.dart';
import 'package:beautymaker/utils/ui/text_const.dart';
import 'package:flutter/material.dart';
import 'package:getxfire/getxfire.dart';
import 'package:intl/intl.dart';

String url = 'https://assets7.lottiefiles.com/packages/lf20_HwRTPu.json';

class UserOrderPage extends StatelessWidget {
  const UserOrderPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _getCartRef = Get.put(UserInfoFirebase());
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        leadingWidth: 80,
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios_new,
              size: 18,
            ),
            color: Colors.black,
            onPressed: () {
              Get.back();
            }),
        centerTitle: true,
        title: Text(
          'My Orders',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: _getCartRef.userOrders,
          builder: (context, snapshot) {
            if (!snapshot.hasData || snapshot.data?.docs.length == 0) {
              return Scaffold(
                body: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'You have no orders\n',
                      textAlign: TextAlign.center,
                      style: TextConsts(
                          size: 26,
                          color: Colors.grey[600]!,
                          fontWeight: FontWeight.w400),
                    ),
                    Text(
                      'Purchase something now ',
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
            }

            return ListView.builder(
                itemCount: snapshot.data?.docs.length == null
                    ? 0
                    : snapshot.data!.docs.length,
                itemExtent: 160,
                itemBuilder: (context, index) {
                  Timestamp _timestamp =
                      snapshot.data?.docs[index]['order_created'];
                  DateTime _dateTime =
                      DateTime.parse(_timestamp.toDate().toString());
                  String date = DateFormat("yyyy-MM-dd").format(_dateTime);

                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 30.0, bottom: 10),
                        child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text('Ordered on : $date')),
                      ),
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
