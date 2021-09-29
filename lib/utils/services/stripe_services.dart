import 'dart:convert';

import 'package:beautymaker/controllers/cart_controller.dart';
import 'package:beautymaker/views/home_drawer_swap.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:getxfire/getxfire.dart';
import 'package:http/http.dart' as http;

/* ******************************

Process payment method with stripe


****************************** */

class StripePaymentServices extends GetxController {
  Map<String, dynamic>? paymentIntentData;
  RxBool paymentLoading = false.obs;

  final _cartController = Get.put(CartController(), permanent: true);

  Future<void> makePayment(double amount) async {
    paymentLoading(true);

    final url =
        'https://us-central1-beautymaker-e8180.cloudfunctions.net/stripePayment';

    final response = await http.post(Uri.parse('$url?amount=$amount'),
        headers: {'Content-Type': 'application/json'});

    paymentIntentData = json.decode(response.body);
    await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
            paymentIntentClientSecret: paymentIntentData!['paymentIntent'],
            googlePay: true,
            applePay: true,
            style: ThemeMode.dark,
            merchantDisplayName: 'Beauty Maker',
            merchantCountryCode: 'SG'));
    
    displayPaymentSheet();
  }

  Future<void> displayPaymentSheet() async {
    try {
      await Stripe.instance.presentPaymentSheet(
          parameters: PresentPaymentSheetParameters(
        clientSecret: paymentIntentData!['paymentIntent'],
        confirmPayment: true,
      ));

      paymentIntentData = null;
      update();
      _cartController.createOrder();
      Get.snackbar("Paid successfully", "Enjoy your next shopping",
          margin: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
          backgroundColor: Colors.black,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
          duration: 3.seconds);

      paymentLoading(false);

      Get.offAll(() => HomeDrawerSwap());
    } catch (e) {
      Get.snackbar("Invalid payment", "Please try again",
          margin: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
          backgroundColor: Colors.black,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
          duration: 3.seconds);

      paymentLoading(false);
    }
  }
}
