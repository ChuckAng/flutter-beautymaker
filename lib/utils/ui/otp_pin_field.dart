import 'package:beautymaker/controllers/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:getxfire/getxfire.dart';
import 'package:hexcolor/hexcolor.dart';

late List<TextEditingController?> _textControllers;
late List<FocusNode?> _focusNodes;
late List<Widget> _textFields;
late List<String> _otp;

class OtpPinField extends StatelessWidget {
  OtpPinField({
    Key? key,
    required this.otpLength,
    required this.email,
  }) : super(key: key);

  String email;
  int otpLength = 4;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    _focusNodes = List<FocusNode?>.filled(otpLength, null, growable: false);
    _textControllers =
        List<TextEditingController?>.filled(otpLength, null, growable: false);
    _textFields = List.generate(otpLength, (i) {
      return _buildTextField(
        index: i,
        otpLength: otpLength,
        email: email,
      );
    });

    _otp = List.generate(otpLength, (index) {
      return '';
    });

    return Container(
      width: size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: _textFields,
      ),
    );
  }
}

class _buildTextField extends StatelessWidget {
  _buildTextField(
      {Key? key,
      required this.index,
      required this.otpLength,
      required this.email})
      : super(key: key);

  int index;
  int otpLength;
  String email;

  @override
  Widget build(BuildContext context) {
    if (_focusNodes[index] == null) _focusNodes[index] = FocusNode();

    if (_textControllers[index] == null)
      _textControllers[index] = TextEditingController();

    return Container(
      height: 85,
      child: AspectRatio(
        aspectRatio: 0.55,
        child: TextField(
          onChanged: (value) {
            if (value.isEmpty) {
              if (index == 0) {
                return;
              } else {
                _focusNodes[index]!.unfocus();
                FocusScope.of(context).previousFocus();
              }
            }

            StringBuffer _newOtp = StringBuffer();
            if (value.isNotEmpty) {
              FocusScope.of(context).unfocus();
              _otp[index] += _textControllers[index]!.text;
              print("otp: $_otp");

              _otp.forEach((code) {
                _newOtp.write(code);
              });
            }

            if (value.isNotEmpty && index + 1 == otpLength) {
              Get.find<LoginController>().verifyOTP(email, _newOtp.toString());
            }

            if (value.isNotEmpty && index + 1 != otpLength) {
              FocusScope.of(context).nextFocus();
            }
          },
          controller: _textControllers[index],
          autofocus: false,
          showCursor: false,
          textAlign: TextAlign.center,
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          maxLength: 1,
          decoration: InputDecoration(
              counter: Offstage(),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(13),
                borderSide: BorderSide(width: 2, color: Colors.black12),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(13),
                borderSide: BorderSide(width: 2, color: HexColor('#c4a484')),
              )),
        ),
      ),
    );
  }
}
