import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get_work/views/map/map_view.dart';

import '../views/home/home_view.dart';
import '../views/login/login_view.dart';
import '../views/splash_screen.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find(); // Singleton instance of the controller
  late Rx<User?> _user; // Observable user object

  FirebaseAuth auth = FirebaseAuth.instance; // Firebase Auth instance

  @override
  void onReady() {
    super.onReady();

    // Bind the current user to the _user stream to listen for changes
    _user = Rx<User?>(auth.currentUser);
    _user.bindStream(auth.userChanges());

    // Trigger _initialScreen whenever _user changes
    ever(_user, _initialScreen);
  }

  // Method to handle screen navigation based on user's authentication state
  _initialScreen(User? user) {
    // Show splash screen initially
    Get.offAll(() => SplashScreen());

    // After 2 seconds, navigate based on user's authentication state
    Future.delayed(Duration(seconds: 2), () {
      if (user == null) {
        // User is not signed in, navigate to the login page
        Get.offAll(() => LoginPage());
      } else {
        // User is signed in, navigate to the home page
        Get.offAll(() => MapPage());
      }
    });
  }

  // Register a new user using email and password
  void register(String email, String password) async {
    try {
      await auth.createUserWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      // Show error snackbar on failure
      Get.snackbar(
        "Registration Failed",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
    }
  }

  // Log in an existing user using email and password
  void login(String email, String password) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      // Show error snackbar on failure
      Get.snackbar(
        "Login Failed",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
    }
  }

  // Sign out the currently authenticated user
  void signOut() async {
    await auth.signOut();
  }
}
