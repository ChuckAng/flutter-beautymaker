import 'package:beautymaker/views/home_drawer_swap.dart';
import 'package:beautymaker/views/login_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:getxfire/getxfire.dart';

class LandingPage extends StatelessWidget {
  LandingPage({Key? key}) : super(key: key);

  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    FirebaseAuth _auth = FirebaseAuth.instance;

    return FutureBuilder(
        future: _initialization,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Scaffold(
                body: Center(
              child: Text("error!"),
            ));
          }
          if (snapshot.connectionState == ConnectionState.done) {
            return StreamBuilder(
                stream: _auth.authStateChanges(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.active) {
                    return HomeDrawerSwap();
                  }
                  return LoginPage();
                });
          }

          return Scaffold(
              body: Center(
            child: Text("Still connecting to the app...."),
          ));
        });
  }
}
