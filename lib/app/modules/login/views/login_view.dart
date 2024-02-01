import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:share_novel/app/modules/utils/color_constant.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Login', style: TextStyle(color: Colors.white)),
          backgroundColor: ColorConstant.Primary,
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.2,
            ),
            child: Column(
              children: [
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
                    // Menggunakan Row sebagai child
                    mainAxisAlignment: MainAxisAlignment
                        .end, // Ikon ditempatkan di sebelah kanan
                    children: [
                      Expanded(
                        child: TextField(
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            hintText: 'Enter your email',
                            border: InputBorder.none,
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 20.0),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Icon(Icons.email), // Ikon di sebelah kanan
                      ),
                    ],
                  ),
                ),
                Obx(
                  () => Container(
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
                          child: TextField(
                            keyboardType: TextInputType.text,
                            obscureText: controller.obscureText.value,
                            decoration: InputDecoration(
                              hintText: 'Enter your password',
                              border: InputBorder.none,
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 20.0),
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            controller.togglePasswordVisibility();
                          },
                          icon: Icon(controller.obscureText.value
                              ? Icons.visibility
                              : Icons.visibility_off),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 1.3,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            20.0), // Membuat tombol rada rounded
                      ),
                      backgroundColor: ColorConstant.Primary,
                      minimumSize: Size(double.infinity,
                          50), // Menentukan ukuran minimum tombol
                    ),
                    onPressed: () {},
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
                  onPressed: () {},
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
        ));
  }
}
