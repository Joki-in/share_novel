import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset(
                'assets/booklogin.json',
                height: 200,
                width: 200,
              ),
              const SizedBox(height: 20),
              const Text(
                "Share Novel",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 30.0,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.bold,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
              const SizedBox(height: 40),
              const CircularProgressIndicator(),
              const SizedBox(height: 30),
              AnimatedTextKit(
                animatedTexts: [
                  TypewriterAnimatedText(
                    'Loading...',
                    textStyle: const TextStyle(
                      fontSize: 18.0,
                    ),
                    speed: const Duration(milliseconds: 300),
                  ),
                ],
                totalRepeatCount: 4,
                pause: const Duration(milliseconds: 100),
                displayFullTextOnTap: false,
                stopPauseOnTap: false,
              )
            ],
          ),
        ),
      ),
    );
  }
}
