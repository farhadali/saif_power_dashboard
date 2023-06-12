import 'dart:convert';

import "package:flutter/material.dart";
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:user_login/api_connection/api_connection.dart';
import 'package:user_login/constants/images_ling.dart';
import 'package:user_login/constants/text_string.dart';
import 'package:user_login/users/authentication/singup_screen.dart';
import "package:http/http.dart" as http;
import 'package:user_login/users/fragments/dashboard_of_fregments.dart';
import 'package:user_login/users/model/user.dart';
import 'package:user_login/users/userPreferances/user_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var isObsecure = true.obs;

  userLoginNow() async {
    try {
      var res = await http.post(
        Uri.parse(API.apiLogin),
        body: {
          'email': emailController.text.trim(),
          'password': passwordController.text.trim(),
        },
      );
      if (res.statusCode == 200) {
        Map<String, dynamic> resBody = json.decode(res.body);
        print(resBody);
        User userInfo = User.fromJson(resBody["user"]);

        await RememberUserPrefs.storeUserInfo(userInfo);
        Fluttertoast.showToast(
          msg: resBody['message'].toString(),
          fontSize: 16.0,
        );
        Future.delayed(
          Duration(
            milliseconds: 2000,
          ),
        );
        Get.to(DashboardOfFragments());
      }
    } catch (errorMsg) {
      print(errorMsg.toString());
      Fluttertoast.showToast(msg: errorMsg.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
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
                          borderSide: BorderSide(color: Colors.white60),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(color: Colors.white60),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(color: Colors.white60),
                        ),
                        disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(color: Colors.white60),
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
                    Obx(
                      () => TextFormField(
                        obscureText: isObsecure.value,
                        controller: passwordController,
                        validator: (val) =>
                            val == "" ? "Please write password" : null,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(
                            Icons.vpn_key_sharp,
                            color: Colors.black,
                          ),
                          suffixIcon: Obx(() => GestureDetector(
                                onTap: () {
                                  isObsecure.value = !isObsecure.value;
                                },
                                child: Icon(
                                  isObsecure.value
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color: Colors.black,
                                ),
                              )),
                          hintText: "Password....",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide(color: Colors.white60),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide(color: Colors.white60),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide(color: Colors.white60),
                          ),
                          disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide(color: Colors.white60),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 6,
                          ),
                          fillColor: Colors.white,
                          filled: true,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 18,
                    ),
                    Material(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(30),
                      child: InkWell(
                        onTap: () {
                          if (formKey.currentState!.validate()) {
                            userLoginNow();
                          }
                        },
                        borderRadius: BorderRadius.circular(30),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 28),
                          child: Text(
                            fLogin,
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Don't have an account",
                ),
                TextButton(
                  onPressed: () {
                    Get.to(SingUpScreen());
                  },
                  child: Text(
                    "Register Here",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
            Text(
              "Or",
              style: TextStyle(
                color: Colors.grey,
                fontSize: 16,
              ),
            ),
            //admin Text button
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Are you an admin?",
                ),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    "Click Here",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 16,
            ),
          ],
        );
        return ConstrainedBox(
          constraints: BoxConstraints(maxHeight: cons.maxHeight),
          child: SingleChildScrollView(
              child: Column(
            children: [
              //Login Screen Header
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 285.0,
                child: Image.asset(fLoginImage),
              ),
              const SizedBox(
                height: 18,
              ),
              //Login Screen Sing In Form
              Container(
                decoration: BoxDecoration(
                    color: Colors.white24,
                    borderRadius: BorderRadius.all(
                      Radius.circular(60),
                    ),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 8,
                        color: Colors.black26,
                        offset: Offset(0, -3),
                      )
                    ]),
                child: column,
              ),
            ],
          )),
        );
      }),
    );
  }
}
