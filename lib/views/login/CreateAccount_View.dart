import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/auth_controller.dart';

class CreateAccountPage extends StatelessWidget {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final AuthController authController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Create Account")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Email input
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: "Email"),
            ),

            // Password input
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(labelText: "Password"),
            ),

            // Confirm Password input
            TextField(
              controller: confirmPasswordController,
              obscureText: true,
              decoration: InputDecoration(labelText: "Confirm Password"),
            ),
            SizedBox(height: 20),

            // Create Account button with password validation
            ElevatedButton(
              onPressed: () {
                if (passwordController.text.trim() ==
                    confirmPasswordController.text.trim()) {
                  // Register if passwords match
                  authController.register(
                    emailController.text.trim(),
                    passwordController.text.trim(),
                  );
                } else {
                  // Show error if passwords do not match
                  Get.snackbar(
                    "Password Error",
                    "Passwords do not match",
                    snackPosition: SnackPosition.BOTTOM,
                  );
                }
              },
              child: Text("Create Account"),
            ),
          ],
        ),
      ),
    );
  }
}
