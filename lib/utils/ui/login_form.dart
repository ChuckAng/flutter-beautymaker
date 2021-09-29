import 'dart:async';

import 'package:beautymaker/controllers/login_controller.dart';
import 'package:beautymaker/views/forgot_pass_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:getxfire/getxfire.dart';
import 'package:hexcolor/hexcolor.dart';

final TextEditingController _emailController = TextEditingController();
final TextEditingController _passwordController = TextEditingController();

class LoginForm extends StatelessWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      width: size.width * .75,
      height: size.height * .47,
      decoration: BoxDecoration(
          color: Colors.grey[900], borderRadius: BorderRadius.circular(30)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Welcome Back,",
              style: TextStyle(
                  fontSize: 22, color: Colors.white, fontFamily: 'Synemono'),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Have A Great Day.",
              style: TextStyle(
                  fontSize: 18, color: Colors.white, fontFamily: 'Synemono'),
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
            Center(
              child: TextButton(
                onPressed: () {
                  Get.to(() => const ForgotPasswordPage());
                },
                child: Text("Forgot Password",
                    style: TextStyle(color: Colors.white)),
              ),
            ),
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
    LoginController _loginController = Get.put(LoginController());

    return Center(
      child: Obx(
        () => _loginController.isLoading.value == true
            ? CircularProgressIndicator(
                color: Colors.white,
                strokeWidth: 2.0,
              )
            : ElevatedButton(
                style: ButtonStyle(
                    elevation: MaterialStateProperty.all(0),
                    fixedSize: MaterialStateProperty.all<Size>(Size(200, 50)),
                    backgroundColor:
                        MaterialStateProperty.all<Color>(HexColor('ff212121')),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            side:
                                BorderSide(color: Colors.white, width: 1.5)))),
                onPressed: () {
                  FocusScope.of(context).unfocus();
                  _loginController.isLoading(true);

                  Timer(3.seconds, () {
                    _loginController.signIn(
                        _emailController.text, _passwordController.text);

                    _loginController.isLoading(false);
                  });
                },
                child: Obx(
                  () => Text(
                    _loginController.isLoading.value == false
                        ? "Login"
                        : "Welcome Back",
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
        style: TextStyle(color: Colors.white),
        autovalidateMode: AutovalidateMode.onUserInteraction,
        obscureText:
            _loginController.revealPassword.value == true ? false : true,
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.lock,
            color: Colors.white,
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
                color: Colors.white,
                size: 18,
              ),
            ),
          ),
          labelText: 'Password',
          labelStyle: TextStyle(color: Colors.white),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.white,
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
      style: TextStyle(color: Colors.white),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        prefixIcon: Icon(
          Icons.mail,
          color: Colors.white,
          size: 20,
        ),
        labelText: 'Email',
        labelStyle: TextStyle(color: Colors.white),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(15)),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: HexColor('#c4a484'), width: 1.5),
            borderRadius: BorderRadius.circular(25)),
      ),
    );
  }
}
