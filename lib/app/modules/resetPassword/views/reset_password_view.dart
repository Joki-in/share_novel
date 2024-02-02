import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_novel/app/modules/utils/color_constant.dart';

import '../controllers/reset_password_controller.dart';

class ResetPasswordView extends GetView<ResetPasswordController> {
  const ResetPasswordView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ResetPasswordController controller =
        Get.put(ResetPasswordController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Reset Password'),
        centerTitle: true,
        backgroundColor: ColorConstant.Primary,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Obx(() => TextFormField(
                    obscureText: !controller.showPassword.value,
                    onChanged: (value) => controller.password.value = value,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: ColorConstant.Primary),
                      ),
                    ),
                  )),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Obx(() => TextFormField(
                    obscureText: !controller.showPassword.value,
                    onChanged: (value) =>
                        controller.confirmPassword.value = value,
                    decoration: InputDecoration(
                      labelText: 'Confirm Password',
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: ColorConstant.Primary),
                      ),
                    ),
                    controller: controller.passwordController,
                  )),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Show/Hide Password",
                  style: TextStyle(
                    fontSize: 15,
                    color: ColorConstant.Primary,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    controller.toggleShowPassword();
                  },
                  icon: Obx(
                    () => Icon(
                      controller.showPassword.value
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: ColorConstant.Primary,
                    ),
                  ),
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () {
                if (controller.arePasswordsMatching()) {
                  controller.changePassword();
                } else {
                  controller.showPasswordMismatchSnackbar();
                }
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                backgroundColor: ColorConstant.Primary,
              ),
              child: const Text(
                'Reset Password',
                style: TextStyle(color: ColorConstant.WhiteColor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
