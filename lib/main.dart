import 'package:beautymaker/controllers/drawerControl.dart';
import 'package:beautymaker/views/stackHomePage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:getxfire/getxfire.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => DrawerControl(),
        )
      ],
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        home: const Home(),
      ),
    );
  }
}
