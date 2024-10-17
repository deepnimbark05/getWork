import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/Auth_Controller.dart';
import 'CreateAccount_View.dart'; // Import the create account page

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final AuthController authController = Get.find();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool rememberMe = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
      ),
      extendBodyBehindAppBar: true, // This ensures the body extends behind the app bar
      body: Stack(
        children: [
          // Background image
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/background2.jpg"), // Replace with your background image path
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Main content
          Center(
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Logo
                    Image.asset(
                      'assets/images/logo/logo.png', // Replace with your logo
                      height: 200,
                    ),
                    Text(
                      'Login To Your Account',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 20),
                    // Email TextField
                    SizedBox(
                      height: 50,
                      child: TextField(
                        controller: emailController,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.email),
                          labelText: 'Email',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(2),
                            borderSide: BorderSide(color: Colors.transparent),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 15),
                    // Password TextField
                    SizedBox(
                      height: 50,
                      child: TextField(
                        controller: passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.lock),
                          labelText: 'Password',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(2),
                            borderSide: BorderSide(color: Colors.transparent),
                          ),
                          suffixIcon: Icon(Icons.visibility_off),
                        ),
                      ),
                    ),
                    // Remember Me checkbox
                    Row(
                      children: [
                        Checkbox(
                          value: rememberMe,
                          onChanged: (bool? value) {
                            setState(() {
                              rememberMe = value ?? false;
                            });
                          },
                        ),
                        Text('Remember me'),
                      ],
                    ),
                    SizedBox(height: 10),
                    // Sign in button
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          authController.login(emailController.text, passwordController.text);
                        },
                        child: Text(
                          'Sign In',
                          style: TextStyle(color: Colors.white, fontSize: 17),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange[700],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      ),
                    ),
                    // Forgot password
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: TextButton(
                          onPressed: () {
                            // Handle forgot password logic
                          },
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.zero, // Remove default padding
                            minimumSize: Size(0, 0), // Remove minimum size
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap, // Shrink tap target size
                            alignment: Alignment.centerLeft, // Align text to the left
                          ),
                          child: Center(
                            child: Text(
                              'Forgot Password',
                              style: TextStyle(color: Colors.blue, fontSize: 17),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 5),
                    // Continue with social login
                    Text('-------------------- or continue with --------------------'),
                    SizedBox(height: 20),
                    // Social login buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SocialLoginButton(
                          imagePath: 'assets/images/logo/linkedin.png', // Replace with your LinkedIn logo path
                          onTap: () {
                            // Handle LinkedIn login
                          },
                        ),
                        SizedBox(width: 20),
                        SocialLoginButton(
                          imagePath: 'assets/images/logo/google.png', // Replace with your Google logo path
                          onTap: () {
                            // Handle Google login
                          },
                        ),
                        SizedBox(width: 20),
                        SocialLoginButton(
                          imagePath: 'assets/images/logo/github.png', // Replace with your GitHub logo path
                          onTap: () {
                            // Handle GitHub login
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    // Create account navigation
                    GestureDetector(
                      onTap: () {
                        Get.to(CreateAccountPage()); // Navigate to the Create Account page
                      },
                      child: Text(
                        'Already have an account? Sign in',
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Social login button widget
class SocialLoginButton extends StatelessWidget {
  final String imagePath;
  final VoidCallback onTap;

  const SocialLoginButton({
    required this.imagePath,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Image.asset(
            imagePath,
            width: 30,
            height: 30,
          ),
        ),
      ),
    );
  }
}
