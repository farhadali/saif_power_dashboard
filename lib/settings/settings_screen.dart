import 'dart:convert';
import 'dart:developer' as dev;

import "package:flutter/material.dart";
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:user_login/api_connection/api_connection.dart';
import 'package:user_login/common_widgets/app_bar.dart';
import 'package:user_login/constants/images_ling.dart';
import 'package:user_login/constants/text_string.dart';
import 'package:user_login/users/authentication/login_screen.dart';
import 'package:http/http.dart' as http;
import 'package:user_login/users/fragments/dashboard_of_fregments.dart';
import 'package:user_login/users/userPreferances/current_user.dart';
import 'package:user_login/users/userPreferances/user_preferences.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  int _selectedIndex = 0;
  final CurrentUser _currentUser = Get.put(CurrentUser());

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      print(index);
      if (index == 0) {
        Get.to(DashboardOfFragments());
      }
      if (index == 1) {
        RememberUserPrefs.removeUserInfo().then((value) {
          Fluttertoast.showToast(msg: "Log out Successfully");
          Get.off(LoginScreen());
        });
      }
    });
  }

  var formKey = GlobalKey<FormState>();
  var isObsecure = true.obs;
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  void initState() {
    setState(() {
      nameController.text = _currentUser.user.name;
      emailController.text = _currentUser.user.email;
      passwordController.text = '';
    });
    super.initState();
  }

  validateUserEmail() async {
    try {
      var res = await http.post(
        Uri.parse(API.apiSingup),
        body: {
          'email': emailController.text.trim(),
          'name': nameController.text.trim(),
          'password': passwordController.text.trim(),
        },
      );

      if (res.statusCode == 200) {
        Map<String, dynamic> resBody = json.decode(res.body);
        print(resBody);
        if (resBody["status"] == 500) {
          Fluttertoast.showToast(
            msg: resBody['message'].toString(),
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.red,
            fontSize: 16.0,
          );
        }
        if (resBody["status"] == 200) {
          Fluttertoast.showToast(
            msg: resBody['message'].toString(),
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0,
          );
          Get.to(LoginScreen());
        }
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar:
          PreferredSize(child: getAppBar(), preferredSize: Size.fromHeight(60)),
      body: LayoutBuilder(builder: (context, cons) {
        var column = Column(
          children: [
            Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(30, 30, 30, 8),
                child: Column(
                  children: [
                    TextFormField(
                      controller: nameController,
                      validator: (val) =>
                          val == "" ? "Please write name" : null,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(
                          Icons.person,
                          color: Colors.black,
                        ),
                        hintText: "Name....",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 6,
                        ),
                        fillColor: Colors.white,
                        filled: true,
                      ),
                    ),
                    const SizedBox(
                      height: 18,
                    ),
                    TextFormField(
                      controller: emailController,
                      validator: (val) =>
                          val == "" ? "Please write email" : null,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(
                          Icons.email,
                          color: Colors.black,
                        ),
                        hintText: "Email....",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 6,
                        ),
                        fillColor: Colors.white,
                        filled: true,
                      ),
                    ),
                    const SizedBox(
                      height: 18,
                    ),
                    const SizedBox(
                      height: 18,
                    ),
                    Material(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(30),
                      child: InkWell(
                        onTap: () {
                          validateUserEmail();
                        },
                        borderRadius: BorderRadius.circular(30),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 28),
                          child: Text(
                            fSingup,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 16,
            ),
            //Don't have an account text area
          ],
        );
        return ConstrainedBox(
          constraints: BoxConstraints(maxHeight: cons.maxHeight),
          child: SingleChildScrollView(
              child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                    color: Colors.white24,
                    borderRadius: BorderRadius.all(
                      Radius.circular(60),
                    ),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 0,
                        color: Colors.white70,
                        offset: Offset(0, -3),
                      )
                    ]),
                child: column,
              ),
            ],
          )),
        );
      }),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Go To Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Logout',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
