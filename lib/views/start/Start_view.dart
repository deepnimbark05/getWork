import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_work/views/login/CreateAccount_View.dart';
import '../../controllers/Start_Controller.dart';
 // Import the controller

class Startpage extends StatelessWidget {
  final StartController controller = Get.put(StartController()); // Inject the controller

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // PageView
          PageView.builder(
            controller: controller.pageController,
            itemCount: controller.backgroundImages.length,
            itemBuilder: (context, index) {
              return Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(
                    controller.backgroundImages[index],
                    fit: BoxFit.cover,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 280, left: 20, right: 20),
                    child: Center(
                      child: Text(
                        controller.imageTexts[index],
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.orange[700],
                          fontSize: 35,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 580, left: 40, right: 40),
                    child: Text(
                      controller.texTexts[index],
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ],
              );
            },
          ),

          // "Get Started" Button
          Padding(
            padding: const EdgeInsets.only(bottom: 45.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  width: 320,
                  height: 60,
                  child: ElevatedButton(
                    child: Text(
                      'GET STARTED',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange[700],
                      shape: BeveledRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(2)),
                      ),
                    ),
                    onPressed: () {
                      Get.to(CreateAccountPage()); // Navigation using GetX
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
