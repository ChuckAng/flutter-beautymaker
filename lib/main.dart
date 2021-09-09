import 'package:beautymaker/components/sign_up_form.dart';
import 'package:beautymaker/components/login_tab.dart';
import 'package:beautymaker/views/cart_item_list.dart';
import 'package:beautymaker/views/forgot_pass_view.dart';
import 'package:beautymaker/views/home_drawer_swap.dart';
import 'package:beautymaker/views/landing_page.dart';
import 'package:beautymaker/views/login_view.dart';
import 'package:beautymaker/views/product_detail.dart';
import 'package:beautymaker/views/profile_setup.dart';
import 'package:beautymaker/views/reset_pass_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:getxfire/getxfire.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return GetMaterialApp(
        debugShowCheckedModeBanner: false, home: LoginPage() //LandingPage(),
        );
  }
}
