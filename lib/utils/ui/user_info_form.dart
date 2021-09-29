import 'dart:async';

import 'package:beautymaker/controllers/login_controller.dart';
import 'package:beautymaker/utils/services/user_info_firebase.dart';
import 'package:beautymaker/views/home_drawer_swap.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:getxfire/getxfire.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:beautymaker/utils/services/create_user_firebase.dart';
import 'package:beautymaker/views/profile_setup.dart';

final TextEditingController _displayNameController = TextEditingController();
final TextEditingController _nameController = TextEditingController();
final TextEditingController _birthdateController = TextEditingController();
final TextEditingController _phoneController = TextEditingController();
final TextEditingController _addressController = TextEditingController();

final CreateUserFirebase _firebaseController = Get.put(CreateUserFirebase());
final LoginController _formController = Get.put(LoginController());
final UserInfoFirebase _userInfoController = Get.put(UserInfoFirebase());

Map map = Map();

final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
final _requiredValidator =
    RequiredValidator(errorText: 'This field is required');

class UserInfoForm extends StatelessWidget {
  const UserInfoForm({
    Key? key,
    required this.email,
  }) : super(key: key);

  final String email;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Expanded(
      child: Container(
        width: size.width,
        height: size.height,
        decoration: BoxDecoration(
          color: Colors.brown[50],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 50,
                  ),
                  const _buildDisplayName(),
                  SizedBox(
                    height: 30,
                  ),
                  const _buildName(),
                  SizedBox(
                    height: 30,
                  ),
                  const _buildBirthdate(),
                  SizedBox(
                    height: 30,
                  ),
                  const _buildPhoneNo(),
                  SizedBox(
                    height: 30,
                  ),
                  const _buildAddress(),
                  SizedBox(
                    height: 45,
                  ),
                  const _buildSubmitButton(),
                ],
              ),
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
    return Center(
      child: Obx(
        () => _firebaseController.isLoading.value == true
            ? CircularProgressIndicator(
                strokeWidth: 2,
                color: Colors.black,
              )
            : ElevatedButton(
                style: ButtonStyle(
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
                  _userInfoController.getEmailUid(email);
                  _userInfoController.addUserDetails(map = {
                    'display_name': _displayNameController.text,
                    'name': _nameController.text,
                    'birthdate': _birthdateController.text,
                    'phoneNumber': _phoneController.text,
                    'address': _addressController.text
                  });

                  Timer(2.seconds, () {
                    if (_formKey.currentState!.validate()) {
                      _formController.allFilled(true);
                      _userInfoController.getUserData();
                    } else {
                      _formController.allFilled(false);
                    }
                  });
                  Timer(3.seconds, () {
                    _firebaseController.isLoading(false);
                  });

                  Timer(4.5.seconds, () {
                    if (_formKey.currentState!.validate()) {
                      Get.off(() => HomeDrawerSwap());
                    }
                  });
                },
                child: Obx(
                  () => Text(
                    _formController.allFilled.value == false
                        ? "Submit"
                        : "Saved",
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

class _buildDisplayName extends StatelessWidget {
  const _buildDisplayName({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: _requiredValidator,
      controller: _displayNameController,
      maxLength: 15,
      keyboardType: TextInputType.emailAddress,
      style: TextStyle(
        color: Colors.black,
      ),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        prefixIcon: Icon(
          FeatherIcons.user,
          color: Colors.black,
          size: 20,
        ),
        labelText: 'Display Name',
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

class _buildName extends StatelessWidget {
  const _buildName({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: _requiredValidator,
      controller: _nameController,
      maxLength: 20,
      keyboardType: TextInputType.text,
      style: TextStyle(
        color: Colors.black,
      ),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        prefixIcon: Icon(
          FeatherIcons.user,
          color: Colors.black,
          size: 20,
        ),
        labelText: 'Name',
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

class _buildBirthdate extends StatelessWidget {
  const _buildBirthdate({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final format = DateFormat("dd-MM-yyyy");
    return DateTimeField(
      format: format,
      onShowPicker: (BuildContext context, DateTime? currentValue) {
        return showDatePicker(
            context: context,
            initialDate: currentValue ?? DateTime.now(),
            firstDate: DateTime(1900),
            lastDate: DateTime(2100));
      },
      controller: _birthdateController,
      keyboardType: TextInputType.text,
      style: TextStyle(
        color: Colors.black,
      ),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        prefixIcon: Icon(
          FeatherIcons.calendar,
          color: Colors.black,
          size: 20,
        ),
        labelText: 'Birthdate',
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

class _buildPhoneNo extends StatelessWidget {
  const _buildPhoneNo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: _requiredValidator,
      controller: _phoneController,
      maxLength: 15,
      keyboardType: TextInputType.phone,
      style: TextStyle(
        color: Colors.black,
      ),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        prefixIcon: Icon(
          FeatherIcons.phone,
          color: Colors.black,
          size: 20,
        ),
        labelText: 'Phone Number',
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

class _buildAddress extends StatelessWidget {
  const _buildAddress({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: _requiredValidator,
      controller: _addressController,
      maxLines: 2,
      maxLength: 80,
      keyboardType: TextInputType.text,
      style: TextStyle(
        color: Colors.black,
      ),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        prefixIcon: Icon(
          FeatherIcons.home,
          color: Colors.black,
          size: 20,
        ),
        labelText: 'Address',
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
