import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/isinovel_controller.dart';

class IsinovelView extends GetView<IsinovelController> {
  const IsinovelView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('IsinovelView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'IsinovelView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
