import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:share_novel/app/modules/utils/color_constant.dart';

import '../controllers/login_controller.dart';

class LoginView extends StatelessWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final loginController = Get.find<LoginController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Login', style: TextStyle(color: Colors.white)),
        backgroundColor: ColorConstant.Primary,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).size.height * 0.1,
          ),
          child: Column(
            children: [
              Lottie.asset('assets/booklogin.json',
                  width: MediaQuery.of(context).size.width / 1.5,
                  height: MediaQuery.of(context).size.height / 5),
              Container(
                margin: EdgeInsets.all(20.0),
                padding: EdgeInsets.all(5.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Expanded(
                      child: TextField(
                        controller: loginController.emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          enabledBorder: InputBorder.none, // Remove underline
                          focusedBorder: InputBorder.none,
                          hintText: 'Enter your email',
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Icon(Icons.email),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.all(20.0),
                padding: EdgeInsets.all(5.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Obx(() => TextField(
                            controller: loginController.passwordController,
                            obscureText: loginController.obscureText.value,
                            decoration: InputDecoration(
                              enabledBorder:
                                  InputBorder.none, // Remove underline
                              focusedBorder: InputBorder.none,
                              hintText: 'Enter your password',
                            ),
                          )),
                    ),
                    IconButton(
                      onPressed: () {
                        loginController.togglePasswordVisibility();
                      },
                      icon: Icon(loginController.obscureText.value
                          ? Icons.visibility
                          : Icons.visibility_off),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width / 1.3,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    backgroundColor: ColorConstant.Primary,
                    minimumSize: Size(double.infinity, 50),
                  ),
                  onPressed: () {
                    loginController.loginUser();
                  },
                  child: const Text(
                    "Login",
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Belum Punya Akun",
                    style: TextStyle(
                      fontSize: 15.0,
                    ),
                  ),
                  SizedBox(
                    width: 5.0,
                  ),
                  InkWell(
                    onTap: () {
                      Get.toNamed('/register');
                    },
                    child: Text(
                      "Register",
                      style: TextStyle(
                        fontSize: 15,
                        color: ColorConstant.Primary,
                      ),
                    ),
                  ),
                ],
              ),
              TextButton(
                onPressed: () {
                  Get.toNamed('/forgot-password');
                },
                child: const Text(
                  "Forgot Password?",
                  style: TextStyle(
                    fontSize: 15,
                    color: ColorConstant.DarkPrimary,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
