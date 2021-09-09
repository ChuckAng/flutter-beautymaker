import 'package:beautymaker/components/user_info_form.dart';
import 'package:beautymaker/services/user_info_firebase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:getxfire/getxfire.dart';

String avatarUrl =
    'https://e7.pngegg.com/pngimages/84/165/png-clipart-united-states-avatar-organization-information-user-avatar-service-computer-wallpaper.png';
late final dynamic email = Get.arguments;

class ProfileSetup extends StatelessWidget {
  const ProfileSetup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.brown[50],
          title: Text(
            "Profile Setup",
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
        ),
        body: InkWell(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Container(
            height: size.height,
            width: size.width,
            color: Colors.brown[50],
            child: Column(
              children: [
                _profilePhoto(),
                UserInfoForm(
                  email: email,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _profilePhoto extends StatelessWidget {
  const _profilePhoto({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserInfoFirebase _imagePicker = Get.put(UserInfoFirebase());

    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Center(
        child: InkWell(
          onTap: () {
            _imagePicker.selectImage();
          },
          child: CircleAvatar(
            backgroundImage: NetworkImage(avatarUrl),
            radius: 70,
          ),
        ),
      ),
    );
  }
}
