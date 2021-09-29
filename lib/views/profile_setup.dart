import 'package:beautymaker/utils/ui/user_info_form.dart';
import 'package:flutter/material.dart';
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
          automaticallyImplyLeading: false,
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
