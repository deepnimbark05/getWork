import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import '../routes/app_routes.dart';

class SplashService {
  FirebaseAuth _auth = FirebaseAuth.instance;

  void checkLoginStatus() {
    Future.delayed(Duration(seconds: 5), () {
      User? user = _auth.currentUser;
    });
  }
}

