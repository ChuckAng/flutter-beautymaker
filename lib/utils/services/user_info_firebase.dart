import 'package:beautymaker/models/product_repo.dart';
import 'package:beautymaker/views/login_view.dart';
import 'package:flutter/material.dart';
import 'package:getxfire/getxfire.dart';

/* ***********************************************

 Retrieve user info and add user info to firebase
 e.g. select images, display name,etc.

*************************************************** */

class UserInfoFirebase extends GetxController {
  String displayName = "";
  RxBool doneReset = false.obs;
  String emailUid = "";
  String productId = "";
  ProductsRepo _productsRepo = ProductsRepo();

  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final User? user = FirebaseAuth.instance.currentUser;
  RxBool isDataReady = false.obs;
  bool isLiked = true;
  List productDataList = [].obs;

  @override
  void onInit() async {
    super.onInit();
    productDataList = await _productsRepo.loadProductsFromApi();
    update();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  late final Stream<QuerySnapshot> countItemSelected = FirebaseFirestore
      .instance
      .collection('UserData')
      .doc(emailUid)
      .collection('Cart')
      .where('is_selected', isEqualTo: true)
      .snapshots();

  late final Stream<QuerySnapshot> checkoutItem = FirebaseFirestore.instance
      .collection('UserData')
      .doc(emailUid)
      .collection('Cart')
      .where('is_selected', isEqualTo: true)
      .snapshots();

  late final Stream<QuerySnapshot> userOrderStream = FirebaseFirestore.instance
      .collection('UserData')
      .doc(emailUid)
      .collection('UserOrder')
      .snapshots();

  late final Stream<QuerySnapshot> userOrders = FirebaseFirestore.instance
      .collection('UserData')
      .doc(emailUid)
      .collection('UserOrder')
      .orderBy('order_created', descending: true)
      .snapshots();

  late final Stream<QuerySnapshot> getUserInfo = FirebaseFirestore.instance
      .collection('UserData')
      .doc(emailUid)
      .collection('UserDetails')
      .where('address')
      .snapshots();

  // Ensure cart list is ordered chronologically
  late Stream<QuerySnapshot> cartDocStream = FirebaseFirestore.instance
      .collection('UserData')
      .doc(emailUid)
      .collection('Cart')
      .orderBy('timestamp', descending: true)
      .snapshots();

  // Get item number in cart
  late final Stream<QuerySnapshot> cartStream = FirebaseFirestore.instance
      .collection('UserData')
      .doc(emailUid)
      .collection('Cart')
      .snapshots();

  late Stream<QuerySnapshot> userProfileStream = FirebaseFirestore.instance
      .collection('UserData')
      .doc(emailUid)
      .collection('UserDetails')
      .snapshots();

  late final CollectionReference orderData = FirebaseFirestore.instance
      .collection('UserData')
      .doc(emailUid)
      .collection('UserOrder');

  late final Stream<QuerySnapshot> orderDone = FirebaseFirestore.instance
      .collection('UserData')
      .doc(emailUid)
      .collection('Cart')
      .where('is_selected', isEqualTo: true)
      .snapshots();

  late final CollectionReference cartData = FirebaseFirestore.instance
      .collection('UserData')
      .doc(emailUid)
      .collection('Cart');

  late final DocumentReference userDetailsRef = FirebaseFirestore.instance
      .collection('UserData')
      .doc(emailUid)
      .collection('UserDetails')
      .doc('PersonalInfo');

  String getUserId() {
    return firebaseAuth.currentUser!.uid;
  }

  void getEmailUid(String email) {
    emailUid = email.trim();
  }

  void resetUserPassword(
      String email, String password, String confirmPassword) async {
    if (password.trim() == confirmPassword.trim()) {
      print('pass: $password');
      await FirebaseFirestore.instance
          .collection('UserData')
          .doc(email.trim())
          .update({
        'password': password,
      });
      doneReset(true);
      Future.delayed(2.seconds, () {
        Get.offAll(() => LoginPage());
      });
    } else {
      doneReset(true);

      Future.delayed(2.seconds, () {
        doneReset(false);
        Get.snackbar(
            "Error resetting password", "Password may not be identical",
            margin: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
            backgroundColor: Colors.white,
            snackPosition: SnackPosition.BOTTOM,
            duration: 2.seconds);
      });
    }
  }

  void addUserDetails(Map map) async {
    await userDetailsRef.set({
      'display_name': map['display_name'],
      'name': map['name'],
      'birthdate': map['birthdate'],
      'phone_number': map['phoneNumber'],
      'address': map['address'],
    });
    SetOptions(merge: true);
  }

  Future<String?> getUserData() async {
    final DocumentSnapshot userDoc = await userDetailsRef.get();

    displayName = userDoc.get('display_name');
    if (displayName.isEmpty) {
      return "";
    } else {
      return displayName;
    }
  }
}
