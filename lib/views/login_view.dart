import 'dart:math' as math;

import 'package:beautymaker/components/login_form.dart';
import 'package:beautymaker/components/sign_up_form.dart';
import 'package:beautymaker/components/login_tab.dart';
import 'package:beautymaker/components/page_header.dart';
import 'package:beautymaker/controllers/animated_controller.dart';
import 'package:beautymaker/controllers/login_controller.dart';
import 'package:beautymaker/controllers/logout_controller.dart';
import 'package:flutter/material.dart';
import 'package:getxfire/getxfire.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LoginController _loginAnimationController = Get.put(LoginController());
    LogoutController _logoutController = Get.put(LogoutController());
    AnimatedController _wordFadeController = Get.put(AnimatedController());

    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Obx(
          () => Scaffold(
            backgroundColor:
                _loginAnimationController.haveAccount.value == true 
                    ? Colors.grey[200]
                    : Colors.grey[900],
            resizeToAvoidBottomInset: false,
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 100,
                ),
                Padding(
                    padding: EdgeInsets.only(left: 30, bottom: 50),
                    child: const PageHeader()),
                Obx(
                  () => FadeTransition(
                      opacity: _wordFadeController.wordFadingController,
                      child: _loginAnimationController.haveAccount.value == true
                          ? const LoginForm()
                          : const SignUpForm()),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 70, top: 50),
                  child: const LoginTab(),
                ),
                Spacer(
                  flex: 2,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
