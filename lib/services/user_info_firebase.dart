import 'dart:io';

import 'package:beautymaker/views/login_view.dart';
import 'package:path/path.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:getxfire/getxfire.dart';

/* ***********************************************

 Retrieve user info and add user info to firebase
 e.g. select images, display name,etc.

*************************************************** */

class UserInfoFirebase extends GetxController {
  late final File? _imageFile;
  RxBool hasUpload = false.obs;
  late String fileName;
  String displayName = "";
  RxBool doneReset = false.obs;
  String emailUid = "";
  String productId = "";

  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final User? user = FirebaseAuth.instance.currentUser;

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

  void getProductId() async {
    final QuerySnapshot querySnapshot = await cartData.get();
    final List<DocumentSnapshot> documents = querySnapshot.docs;
    documents.forEach((data)=> print(data.id));
    

  }

  void getEmailUid(String email) {
    emailUid = email.trim();
    print('emailUid: $emailUid');
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

  Future selectImage() async {
    final pickedImage =
        await ImagePicker.platform.pickImage(source: ImageSource.gallery);

    if (pickedImage == null) {
      hasUpload(false);
      return;
    }

    _imageFile = File(pickedImage.path);

    hasUpload(true);
    update();
  }

  Future uploadToFirebase() async {
    try {
      fileName = basename(_imageFile!.path);

      String uid = user!.uid;
      final storageRef =
          FirebaseStorage.instance.ref('Users/$uid/Images/$fileName');
      final uploadTask = storageRef.putFile(_imageFile!);
      return uploadTask;
    } on FirebaseException catch (e) {
      return null;
    }
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }
}
