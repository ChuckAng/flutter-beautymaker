import 'package:beautymaker/utils/ui/build_lottie_animation.dart';
import 'package:beautymaker/utils/ui/otp_pin_field.dart';
import 'package:beautymaker/utils/ui/text_const.dart';
import 'package:beautymaker/controllers/animated_controller.dart';
import 'package:beautymaker/controllers/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:getxfire/getxfire.dart';
import 'package:hexcolor/hexcolor.dart';

late final dynamic email = Get.arguments;

class OtpVerificationPage extends StatelessWidget {
  OtpVerificationPage({Key? key}) : super(key: key);

  final String lottieUrl =
      'https://assets2.lottiefiles.com/datafiles/Bn3v9MQSL5CxM5a/data.json';

  final String description = 'Please enter 6 digit code sent\nto $email';

  late bool last, first;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    AnimatedController _timerController = Get.put(AnimatedController());
    LoginController _loginController = Get.put(LoginController());

    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.grey[200],
          body: SingleChildScrollView(
            child: GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
              },
              child: Column(children: [
                SizedBox(
                  height: size.height * .1,
                ),
                BuildLottieAnimation(
                    height: size.height * .3,
                    width: size.width * .6,
                    backgroundColor: Colors.transparent,
                    borderRadius: 0,
                    lottieUrl: lottieUrl),
                SizedBox(
                  height: size.height * .04,
                ),
                Container(
                    child: Column(
                  children: [
                    Text(
                      'Verification code sent',
                      style: TextConsts(size: 25),
                    ),
                    SizedBox(
                      height: size.height * .03,
                    ),
                    Text(
                      description,
                      textAlign: TextAlign.center,
                      style: TextConsts(size: 15, fontWeight: FontWeight.w200),
                    ),
                    SizedBox(
                      height: size.height * .03,
                    ),
                  ],
                )),
                OtpPinField(
                  otpLength: 6,
                  email: email,
                ),
                SizedBox(
                  height: size.height * .03,
                ),
                const _buildSubmitButton(),
                SizedBox(
                  height: size.height * .04,
                ),
                Text("Didn't receive the code?",
                    style: TextConsts(size: 15, fontWeight: FontWeight.w300)),
                _buildResendButton(
                    loginController: _loginController,
                    timerController: _timerController),
              ]),
            ),
          )),
    );
  }
}

class _buildResendButton extends StatelessWidget {
  const _buildResendButton({
    Key? key,
    required LoginController loginController,
    required AnimatedController timerController,
  })  : _loginController = loginController,
        _timerController = timerController,
        super(key: key);

  final LoginController _loginController;
  final AnimatedController _timerController;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Obx(
          () => _loginController.isButtonEnabled.value == true
              ? TextButton(
                  onPressed: () {
                    if (_loginController.isButtonEnabled.value == true) {
                      _loginController.resendCode(email);
                    } else {
                      return;
                    }
                  },
                  child: Obx(
                    () => Text(
                      "Resend code",
                      style: TextConsts(
                          size: 16,
                          fontWeight:
                              _loginController.isButtonEnabled.value == true
                                  ? FontWeight.bold
                                  : FontWeight.w300,
                          color: _loginController.isButtonEnabled.value == true
                              ? Colors.black
                              : Colors.black26),
                    ),
                  ))
              : Padding(
                  padding: const EdgeInsets.only(top: 25.0),
                  child: Text(
                    "Resend code",
                    style: TextConsts(
                        size: 16,
                        fontWeight: FontWeight.w300,
                        color: Colors.black26),
                  ),
                ),
        ),
        SizedBox(width: 10),
        Obx(() => _loginController.startVerify.value == true
            ? Padding(
                padding: const EdgeInsets.only(top: 25.0),
                child: Text("${_timerController.seconds.value}s"),
              )
            : Text("")),
      ],
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
                onPressed: () {},
                child: Obx(
                  () => Text(
                    _loginController.startVerify.value == false ? "Verify" : "",
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
