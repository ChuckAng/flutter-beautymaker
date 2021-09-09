import 'package:beautymaker/controllers/animated_controller.dart';
import 'package:beautymaker/controllers/login_controller.dart';
import 'package:beautymaker/controllers/logout_controller.dart';
import 'package:flutter/material.dart';
import 'package:getxfire/getxfire.dart';

class PageHeader extends StatelessWidget {
  const PageHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AnimatedController _wordFadeController = Get.put(AnimatedController());
    LoginController _loginAnimationController = Get.put(LoginController());
    LogoutController _logoutController = Get.put(LogoutController());

    return Column(
      children: [
        Row(
          children: [
            FadeTransition(
              opacity: _wordFadeController.wordFadingController,
              child: Obx(
                () => Text(
                  "Beauty",
                  style: TextStyle(
                    color:
                        _loginAnimationController.haveAccount.value == true 
                        
                            ? Colors.black87
                            : Colors.white,
                    fontWeight: FontWeight.w300,
                    fontSize: 22,
                    letterSpacing: 5,
                  ),
                ),
              ),
            ),
            FadeTransition(
              opacity: _wordFadeController.wordFadingController,
              child: Obx(
                () => Text(
                  "Maker",
                  style: TextStyle(
                      color:
                          _loginAnimationController.haveAccount.value == true 
                          
                              ? Colors.black87
                              : Colors.white,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 4,
                      fontSize: 22,
                      fontFamily: 'Synemono'),
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 20,
        ),
        FadeTransition(
          opacity: _wordFadeController.wordFadingController,
          child: Obx(
            () => Text(
              "Unleash Your Beauty.",
              style: TextStyle(
                  color: _loginAnimationController.haveAccount.value == true 
                  
                      ? Colors.black87
                      : Colors.white,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 4,
                  fontSize: 18,
                  fontFamily: 'Synemono'),
            ),
          ),
        ),
      ],
    );
  }
}
