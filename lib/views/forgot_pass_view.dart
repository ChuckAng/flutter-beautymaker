import 'dart:async';

import 'package:beautymaker/utils/ui/build_lottie_animation.dart';
import 'package:beautymaker/utils/ui/text_const.dart';
import 'package:beautymaker/controllers/animated_controller.dart';
import 'package:beautymaker/controllers/login_controller.dart';
import 'package:beautymaker/views/otp_verify_view.dart';
import 'package:flutter/material.dart';
import 'package:getxfire/getxfire.dart';
import 'package:hexcolor/hexcolor.dart';

final TextEditingController _emailController = TextEditingController();

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  final String lottieUrl =
      'https://assets9.lottiefiles.com/private_files/lf30_GjhcdO.json';

  final String description =
      'Enter your email address associated\nwith your account';

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SafeArea(
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
            backgroundColor: Colors.grey[200],
            resizeToAvoidBottomInset: false,
            body:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Padding(
                  padding: const EdgeInsets.only(top: 35, left: 45),
                  child: Icon(Icons.arrow_back_ios),
                ),
              ),
              BuildLottieAnimation(
                  height: size.height * .3,
                  width: size.width * .6,
                  borderRadius: 130,
                  backgroundColor: Colors.brown[100]!.withOpacity(0.8),
                  lottieUrl: lottieUrl),
              SizedBox(
                height: size.height * .06,
              ),
              _buildDescription(size: size, description: description),
              const _buildEmailForm(),
              SizedBox(
                height: size.height * .05,
              ),
              const _buildSubmitButton(),
            ])),
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
            'Forgot Password?',
            style: TextConsts(size: 32),
          ),
          SizedBox(
            height: size.height * .02,
          ),
          Text(
            description,
            textAlign: TextAlign.center,
            style: TextConsts(size: 15, fontWeight: FontWeight.w200),
          ),
          SizedBox(
            height: size.height * .04,
          ),
        ],
      )),
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
    AnimatedController _timerController = Get.put(AnimatedController());

    return Center(
      child: Obx(
        () => _loginController.startVerify.value == true
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
                    _loginController.sendOTP(_emailController.text);
                  });

                  Timer(2.5.seconds, () {
                    _timerController.startTimer();
                    Get.offAll(() => OtpVerificationPage(),
                        arguments: _emailController.text);
                  });
                },
                child: Obx(
                  () => Text(
                    _loginController.startVerify.value == false ? "Submit" : "",
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

class _buildEmailForm extends StatelessWidget {
  const _buildEmailForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    LoginController _loginController = Get.put(LoginController());

    return Center(
      child: Container(
        width: size.width * .7,
        child: Obx(
          () => Focus(
            onFocusChange: (focus) {
              _loginController.isFocused.value = focus;
            },
            child: TextFormField(
              controller: _emailController,
              cursorColor: HexColor('#c4a484'),
              keyboardType: TextInputType.emailAddress,
              style: TextStyle(color: Colors.black),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.mail,
                  color: Colors.black,
                  size: 20,
                ),
                labelText: 'Email',
                labelStyle: TextStyle(
                    color: _loginController.isFocused.value == true
                        ? Colors.black
                        : Colors.black26),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.circular(15)),
                focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: HexColor('#c4a484'), width: 1.5),
                    borderRadius: BorderRadius.circular(25)),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
