import 'package:beautymaker/utils/services/user_info_firebase.dart';
import 'package:beautymaker/utils/ui/text_const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:getxfire/getxfire.dart';
import 'package:hexcolor/hexcolor.dart';

final TextEditingController _displayNameController = TextEditingController();
final TextEditingController _nameController = TextEditingController();
final TextEditingController _birthdateController = TextEditingController();
final TextEditingController _phoneController = TextEditingController();
final TextEditingController _addressController = TextEditingController();

late String phoneNo;

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _getUserProfileData = Get.put(UserInfoFirebase());

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        leadingWidth: 80,
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios_new,
              size: 18,
            ),
            color: Colors.black,
            onPressed: () {
              Get.back();
            }),
        centerTitle: true,
        title: Text(
          'My Profile',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      backgroundColor: Colors.blueGrey[50],
      body: StreamBuilder<QuerySnapshot>(
          stream: _getUserProfileData.userProfileStream,
          builder: (context, snapshot) {
            if (snapshot.data?.docs == null) {
              return Scaffold(
                  body: Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.black,
                  strokeWidth: 2.0,
                ),
              ));
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Scaffold(
                  body: Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.black,
                  strokeWidth: 2.0,
                ),
              ));
            }

            if (snapshot.hasData && snapshot.data?.docs.length != 0) {
              var doc = snapshot.data!.docs[0];
              _displayNameController.text = doc['display_name'];
              _nameController.text = doc['name'];
              _phoneController.text = doc['phone_number'];
              _addressController.text = doc['address'];
              _birthdateController.text = doc['birthdate'];

              return SingleChildScrollView(
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 30,
                        ),
                        _buildDisplayName(),
                        const SizedBox(
                          height: 20,
                        ),
                        _buildName(),
                        const SizedBox(
                          height: 20,
                        ),
                        _buildBirthdate(),
                        const SizedBox(
                          height: 20,
                        ),
                        _buildPhoneNo(),
                        const SizedBox(
                          height: 20,
                        ),
                        _buildAddress(),
                        const SizedBox(
                          height: 65,
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: ElevatedButton(
                            style: ButtonStyle(
                                elevation: MaterialStateProperty.all(0),
                                fixedSize: MaterialStateProperty.all<Size>(
                                    Size(200, 50)),
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.black),
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                ))),
                            onPressed: () {
                              FocusScope.of(context).unfocus();
                              Map map = Map();
                              _getUserProfileData.addUserDetails(map = {
                                'display_name': _displayNameController.text,
                                'name': _nameController.text,
                                'birthdate': _birthdateController.text,
                                'phoneNumber': _phoneController.text,
                                'address': _addressController.text
                              });
                            },
                            child: Text(
                              "Update",
                              style: TextConsts(
                                color: Colors.white,
                                size: 16,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }

            return Scaffold(
                body: Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.black,
                strokeWidth: 2.0,
              ),
            ));
          }),
    );
  }
}

class _buildPhoneNo extends StatelessWidget {
  _buildPhoneNo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: HexColor('#c4a484'),
      controller: _phoneController,
      onChanged: (text) {
        if (FocusScope.of(context).hasFocus == false) {
          _phoneController.text = text;
        }
      },
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
  _buildAddress({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: HexColor('#c4a484'),
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

class _buildName extends StatelessWidget {
  _buildName({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: HexColor('#c4a484'),
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

class _buildDisplayName extends StatelessWidget {
  _buildDisplayName({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: HexColor('#c4a484'),
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

class _buildBirthdate extends StatelessWidget {
  const _buildBirthdate({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLength: 10,
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
        hintText: 'YYYY-MM-DD',
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
