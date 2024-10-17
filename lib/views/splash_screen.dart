import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/Splash_Controller.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SplashController splashController = Get.put(SplashController());

    return Scaffold(
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("get",style: TextStyle(fontSize: 47,color: Colors.black),),
            Text("W",style: TextStyle(fontSize: 57,color: Colors.orange[700]),),
            Text("ork",style: TextStyle(fontSize: 57,color: Colors.black),),
          ],
        ),
      ),
    );
  }
}
