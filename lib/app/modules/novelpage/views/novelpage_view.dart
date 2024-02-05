import 'package:carbon_icons/carbon_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_novel/app/modules/utils/color_constant.dart';
import '../controllers/novelpage_controller.dart';

class NovelpageView extends GetView<NovelpageController> {
  const NovelpageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.height / 3,
                  color: Colors.blue,
                  child: Image.network(
                    'https://d1csarkz8obe9u.cloudfront.net/posterpreviews/contemporary-fiction-night-time-book-cover-design-template-1be47835c3058eb42211574e0c4ed8bf_screen.jpg?ts=1698210220',
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * .20,
                  color: Colors.white,
                ),
                SizedBox(
                  height: 20.0,
                ),
                Container(
                  height: MediaQuery.of(context).size.height / 2,
                  width: double.infinity,
                  color: Colors.white,
                  child: const Column(
                    children: [
                      Text(
                        'Judul Novel',
                        style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                          color: ColorConstant.Primary,
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            CarbonIcons.favorite,
                            color: ColorConstant.Primary,
                            size: 24.0,
                          ),
                          SizedBox(
                            width: 5.0,
                          ),
                          Text("10000",
                              style: TextStyle(
                                  color: ColorConstant.Primary,
                                  fontWeight: FontWeight.bold)),
                          SizedBox(
                            width: 10.0,
                          ),
                          const Icon(
                            CarbonIcons.view,
                            color: ColorConstant.Primary,
                            size: 24.0,
                          ),
                          SizedBox(
                            width: 5.0,
                          ),
                          Text("10000",
                              style: TextStyle(
                                  color: ColorConstant.Primary,
                                  fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            // Card di atasnya dengan padding di atas
            Positioned(
              top: MediaQuery.of(context).size.height * .20,
              left: MediaQuery.of(context).size.width / 4,
              right: MediaQuery.of(context).size.width / 4,
              child: Container(
                height: MediaQuery.of(context).size.height * .35,
                width: MediaQuery.of(context).size.width - 40.0,
                child: Image.network(
                  'https://d1csarkz8obe9u.cloudfront.net/posterpreviews/contemporary-fiction-night-time-book-cover-design-template-1be47835c3058eb42211574e0c4ed8bf_screen.jpg?ts=1698210220',
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
