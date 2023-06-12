import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:user_login/constants/images_ling.dart';
import 'package:user_login/constants/text_string.dart';
import 'package:user_login/users/authentication/login_screen.dart';
import 'package:user_login/users/userPreferances/current_user.dart';
import 'package:user_login/users/userPreferances/user_preferences.dart';

class ProfileFragementScreen extends StatelessWidget {
  final CurrentUser _currentUser = Get.put(CurrentUser());

  signOutUser() async {
    var resultResponse = await Get.dialog(AlertDialog(
      backgroundColor: Colors.grey,
      title: Text(
        "Logout",
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      content: Text(
        "Are you sure?\nYou want to logout from app?",
      ),
      actions: [
        TextButton(
          onPressed: () {
            Get.back();
          },
          child: Text(
            'No',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
        TextButton(
          onPressed: () {
            Get.back(result: "loggedOut");
          },
          child: Text(
            'Yes',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
      ],
    ));

    if (resultResponse == 'loggedOut') {
      //Delete -remove user data from local storage
      RememberUserPrefs.removeUserInfo().then((value) {
        Fluttertoast.showToast(msg: "Log out Successfully");
        Get.off(LoginScreen());
      });
    }
  }

  Widget userInfoItemProfile(IconData iconData, String userData) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.grey,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      child: Row(
        children: [
          Icon(
            iconData,
            size: 30,
            color: Colors.black,
          ),
          const SizedBox(
            height: 16,
          ),
          Text(
            userData,
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Center(
          child: Image.asset(
            fWomenImage,
            width: 240,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        userInfoItemProfile(
          Icons.person,
          _currentUser.user.name,
        ),
        const SizedBox(
          height: 20,
        ),
        userInfoItemProfile(
          Icons.email,
          _currentUser.user.email,
        ),
        const SizedBox(
          height: 20,
        ),
        Center(
          child: Material(
            color: Colors.redAccent,
            borderRadius: BorderRadius.circular(8),
            child: InkWell(
              onTap: () {
                signOutUser();
              },
              borderRadius: BorderRadius.circular(32),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 30,
                  vertical: 12,
                ),
                child: Text(
                  fLogOut,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
