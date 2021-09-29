import 'package:beautymaker/views/login_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:getxfire/getxfire.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setEnabledSystemUIOverlays([]);
  Stripe.publishableKey =
      'pk_test_51JaILJGoQgjB4dmz3ozHc3ssOOLmu7L7PjWiX0pFSw7z9kBD1P16ZOH1AMnlNTFSNO8vzW4LvQ3OUlSkNcFw2AOb00fnt0IUkc';
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    ),
  );
}
