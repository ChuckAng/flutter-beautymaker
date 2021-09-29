import 'dart:async';

import 'package:beautymaker/controllers/login_controller.dart';
import 'package:beautymaker/controllers/logout_controller.dart';
import 'package:beautymaker/utils/services/create_user_firebase.dart';
import 'package:beautymaker/views/profile_setup.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:getxfire/getxfire.dart';
import 'package:hexcolor/hexcolor.dart';

final TextEditingController _emailController = TextEditingController();
final TextEditingController _passwordController = TextEditingController();
final CreateUserFirebase _firebaseController = Get.put(CreateUserFirebase());

class SignUpForm extends StatelessWidget {
  const SignUpForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      width: size.width * .75,
      height: size.height * .47,
      decoration: BoxDecoration(
          color: Colors.grey[200], borderRadius: BorderRadius.circular(30)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Aloha.",
              style: TextStyle(
                  fontSize: 22, color: Colors.black, fontFamily: 'Synemono'),
            ),
            Text(
              "\nCreate User Account\nTo Login Now",
              style: TextStyle(
                  fontSize: 18, color: Colors.black, fontFamily: 'Synemono'),
            ),
            Spacer(),
            const _buildEmailForm(),
            SizedBox(
              height: 20,
            ),
            const _buildPasswordForm(),
            SizedBox(
              height: 30,
            ),
            const _buildSubmitButton(),
          ],
        ),
      ),
    );
  }
}

class _buildSubmitButton extends StatelessWidget {
  const _buildSubmitButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LogoutController _logoutController = Get.put(LogoutController());

    return Center(
      child: Obx(
        () => _firebaseController.isLoading.value == true
            ? CircularProgressIndicator(
                strokeWidth: 2,
                color: Colors.black,
              )
            : ElevatedButton(
                style: ButtonStyle(
                    elevation: MaterialStateProperty.all(0),
                    fixedSize: MaterialStateProperty.all<Size>(Size(200, 50)),
                    backgroundColor: MaterialStateProperty.all<Color>(
                      HexColor('ff212121'),
                    ),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            side: BorderSide(width: 1.5)))),
                onPressed: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                  _firebaseController.isLoading(true);

                  _firebaseController.createUser(
                      _emailController.text, _passwordController.text);

                  Timer(3.seconds, () {
                    _firebaseController.isLoading(false);
                    _firebaseController.finishedLoading(true);
                  });

                  Timer(4.5.seconds, () {
                    Get.to(() => ProfileSetup(),
                        arguments: _emailController.text);
                  });
                },
                child: Obx(
                  () => Text(
                    _firebaseController.finishedLoading.value == false ||
                            _logoutController.isLoggedOut.value == true
                        ? "Create Account"
                        : "Registered",
                    style: TextStyle(
                        fontFamily: 'Synemono',
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
      ),
    );
  }
}

class _buildPasswordForm extends StatelessWidget {
  const _buildPasswordForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LoginController _loginController = Get.put(LoginController());

    return Obx(
      () => TextFormField(
        controller: _passwordController,
        cursorColor: HexColor('#c4a484'),
        keyboardType: TextInputType.text,
        style: TextStyle(
          color: _loginController.haveAccount.value == true
              ? Colors.white
              : Colors.black,
        ),
        autovalidateMode: AutovalidateMode.onUserInteraction,
        obscureText: _loginController.revealPassword.value == true ? false : true,
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.lock,
            color: _loginController.haveAccount.value == true
                ? Colors.white
                : Colors.black,
            size: 20,
          ),
          suffixIcon: Obx(
            () => InkWell(
              onTap: () {
                _loginController.reveal();
              },
              child: Icon(
                _loginController.revealPassword.value == false
                    ? FeatherIcons.eyeOff
                    : FeatherIcons.eye,
                color: _loginController.haveAccount.value == true
                    ? Colors.white
                    : Colors.black,
                size: 18,
              ),
            ),
          ),
          labelText: 'Password',
          labelStyle: TextStyle(
            color: _loginController.haveAccount.value == true
                ? Colors.white
                : Colors.black,
          ),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: _loginController.haveAccount.value == true
                    ? Colors.white
                    : Colors.black,
              ),
              borderRadius: BorderRadius.circular(15)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: HexColor('#c4a484'), width: 1.5),
              borderRadius: BorderRadius.circular(25)),
        ),
      ),
    );
  }
}

class _buildEmailForm extends StatelessWidget {
  const _buildEmailForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _emailController,
      cursorColor: HexColor('#c4a484'),
      keyboardType: TextInputType.emailAddress,
      style: TextStyle(
        color: Colors.black,
      ),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        prefixIcon: Icon(
          Icons.mail,
          color: Colors.black,
          size: 20,
        ),
        labelText: 'Email',
        labelStyle: TextStyle(
          color: Colors.black,
        ),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.black,
            ),
            borderRadius: BorderRadius.circular(15)),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: HexColor('#c4a484'), width: 1.5),
            borderRadius: BorderRadius.circular(25)),
      ),
    );
  }
}
