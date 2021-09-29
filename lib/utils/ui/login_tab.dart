import 'package:beautymaker/controllers/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:getxfire/getxfire.dart';

class LoginTab extends StatelessWidget {
  const LoginTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String haveAccount = "Already have an account?";
    String noAccount = "Don't have an account?";
    String signIn = "Sign In";
    String signUp = "Sign Up";
    LoginController _loginController = Get.put(LoginController());

    return Container(
        child: Row(
      children: [
        Obx(
          () => Text(
            _loginController.haveAccount.value == true
                ? noAccount
                : haveAccount,
            style: TextStyle(
                color: _loginController.haveAccount.value == true
                    ? Colors.black
                    : Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w300),
          ),
        ),
        SizedBox(
          width: 5,
        ),
        InkWell(
          onTap: () {
            _loginController.swap();
          },
          child: Obx(
            () => Container(
              child: Text(
                _loginController.haveAccount.value == true ? signUp : signIn,
                style: TextStyle(
                    color: _loginController.haveAccount.value == true
                        ? Colors.black
                        : Colors.white,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Synemono'),
              ),
            ),
          ),
        ),
      ],
    ));
  }
}
