import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_novel/app/modules/utils/color_constant.dart';
import '../controllers/register_controller.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final RegisterController controller = Get.put(RegisterController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
        backgroundColor: ColorConstant.Primary,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
            ),
            Container(
              margin: EdgeInsets.only(top: 20.0, left: 20, right: 20),
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
                mainAxisAlignment:
                    MainAxisAlignment.end, // Ikon ditempatkan di sebelah kanan
                children: [
                  Expanded(
                    child: TextField(
                      controller: controller
                          .usernameController, // Controller untuk username
                      decoration: InputDecoration(
                        hintText: 'Enter Username',
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 20.0),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Icon(Icons.person), // Ikon di sebelah kanan
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20.0, left: 20, right: 20),
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
                mainAxisAlignment:
                    MainAxisAlignment.end, // Ikon ditempatkan di sebelah kanan
                children: [
                  Expanded(
                    child: TextField(
                      controller: controller
                          .alamatController, // Controller untuk alamat
                      decoration: InputDecoration(
                        hintText: 'Alamat',
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 20.0),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child:
                        Icon(Icons.add_location_alt), // Ikon di sebelah kanan
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20.0, left: 20, right: 20),
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
                mainAxisAlignment:
                    MainAxisAlignment.end, // Ikon ditempatkan di sebelah kanan
                children: [
                  Expanded(
                    child: TextField(
                      controller:
                          controller.emailController, // Controller untuk email
                      decoration: InputDecoration(
                        hintText: 'Email',
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 20.0),
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
                        controller: controller
                            .passwordController, // Controller untuk password
                        keyboardType: TextInputType.text,
                        obscureText: controller.obscureText.value,
                        decoration: InputDecoration(
                          hintText: 'Password',
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
            const SizedBox(
              height: 20,
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
                  minimumSize: Size(
                      double.infinity, 50), // Menentukan ukuran minimum tombol
                ),
                onPressed: () {
                  controller.registerUser();
                },
                child: const Text(
                  "Register",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
