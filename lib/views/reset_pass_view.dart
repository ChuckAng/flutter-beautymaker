import 'dart:async';

import 'package:beautymaker/components/build_lottie_animation.dart';
import 'package:beautymaker/components/text_const.dart';
import 'package:beautymaker/controllers/login_controller.dart';
import 'package:beautymaker/services/user_info_firebase.dart';
import 'package:beautymaker/views/login_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:getxfire/getxfire.dart';
import 'package:hexcolor/hexcolor.dart';

late final dynamic email = Get.arguments;
final String lottieUrl =
    "https://assets4.lottiefiles.com/packages/lf20_4yofoa5q.json";

final TextEditingController _passwordController = TextEditingController();
final TextEditingController _confirmPasswordController =
    TextEditingController();

class ResetPasswordPage extends StatelessWidget {
  const ResetPasswordPage({Key? key}) : super(key: key);
  final String description =
      "Your new password must be\n different from old password";

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    UserInfoFirebase _resetPasswordController = Get.put(UserInfoFirebase());

    return SafeArea(
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          backgroundColor: Colors.grey[200],
          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 50,
                ),
                BuildLottieAnimation(
                    height: size.height * .3,
                    width: size.width * .6,
                    backgroundColor: Colors.transparent,
                    borderRadius: 0,
                    lottieUrl: lottieUrl),
                SizedBox(
                  height: 15,
                ),
                _buildDescription(size: size, description: description),
                SizedBox(
                  height: 20,
                ),
                SizedBox(width: size.width * .7, child: _buildPasswordForm()),
                SizedBox(height: 20),
                SizedBox(
                    width: size.width * .7, child: _buildConfirmPasswordForm()),
                SizedBox(height: 30),
                _buildSubmitButton(),
              ],
            ),
          ),
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
    UserInfoFirebase _resetPasswordController = Get.put(UserInfoFirebase());

    return Center(
      child: Obx(
        () => _resetPasswordController.doneReset.value == true
            ? CircularProgressIndicator(
                color: Colors.black,
                strokeWidth: 2.0,
              )
            : ElevatedButton(
                style: ButtonStyle(
                    fixedSize: MaterialStateProperty.all<Size>(Size(200, 50)),
                    backgroundColor:
                        MaterialStateProperty.all<Color>(HexColor('ff212121')),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            side:
                                BorderSide(color: Colors.black, width: 1.5)))),
                onPressed: () {
                  FocusScope.of(context).unfocus();

                  Timer(1.seconds, () {
                    _resetPasswordController.getEmailUid(email);
                    _resetPasswordController.resetUserPassword(
                        email,
                        _passwordController.text,
                        _confirmPasswordController.text);
                  });
                },
                child: Obx(
                  () => Text(
                    _resetPasswordController.doneReset.value == false
                        ? "Confirm"
                        : "",
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

    return TextFormField(
      controller: _passwordController,
      cursorColor: HexColor('#c4a484'),
      keyboardType: TextInputType.text,
      style: TextStyle(color: Colors.black),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      obscureText: _loginController.revealPassword == true ? false : true,
      decoration: InputDecoration(
        prefixIcon: Icon(
          Icons.lock,
          color: Colors.black,
          size: 20,
        ),
        suffixIcon: Obx(
          () => InkWell(
            onTap: () {
              _loginController.reveal();
            },
            child: Icon(
              _loginController.revealPassword == false
                  ? FeatherIcons.eyeOff
                  : FeatherIcons.eye,
              color: Colors.black,
              size: 18,
            ),
          ),
        ),
        labelText: 'Password',
        labelStyle: TextStyle(color: Colors.black),
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

class _buildConfirmPasswordForm extends StatelessWidget {
  const _buildConfirmPasswordForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LoginController _loginController = Get.put(LoginController());

    return Obx(
      () => Focus(
        onFocusChange: (focus) {
          _loginController.isFocused.value = focus;
        },
        child: TextFormField(
          controller: _confirmPasswordController,
          cursorColor: HexColor('#c4a484'),
          keyboardType: TextInputType.text,
          style: TextStyle(color: Colors.black),
          autovalidateMode: AutovalidateMode.onUserInteraction,
          obscureText:
              _loginController.revealPassword.value == true ? false : true,
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.lock,
              color: Colors.transparent,
              size: 20,
            ),
            labelText: 'Confirm Password',
            labelStyle: TextStyle(
                color: (_loginController.isFocused.value == true ||
                        _confirmPasswordController.text.isNotEmpty)
                    ? Colors.black
                    : Colors.black26),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.black,
                ),
                borderRadius: BorderRadius.circular(15)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: HexColor('#c4a484'), width: 1.5),
                borderRadius: BorderRadius.circular(25)),
          ),
        ),
      ),
    );
  }
}

class _buildDescription extends StatelessWidget {
  const _buildDescription({
    Key? key,
    required this.size,
    required this.description,
  }) : super(key: key);

  final Size size;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
          child: Column(
        children: [
          Text(
            'Create New Password',
            style: TextConsts(size: 28),
          ),
          SizedBox(
            height: size.height * .02,
          ),
          Text(
            description,
            textAlign: TextAlign.center,
            style: TextConsts(
              size: 15,
              fontWeight: FontWeight.w200,
            ),
          ),
          SizedBox(
            height: size.height * .04,
          ),
        ],
      )),
    );
  }
}
