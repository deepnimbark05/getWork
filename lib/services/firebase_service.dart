import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class FirebaseService extends GetxService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Method to verify phone number
  Future<void> verifyPhoneNumber(String phoneNumber, Function(String) onCodeSent) async {
    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          // Auto-verification for Android
          await _auth.signInWithCredential(credential);
          Get.offAllNamed('/home'); // Navigate to home on success
        },
        verificationFailed: (FirebaseAuthException e) {
          // Handle null safety for message and display a fallback error if necessary
          final errorMessage = e.message ?? "Phone verification failed. Please try again.";
          Get.snackbar("Error", errorMessage); // Show error message
        },
        codeSent: (String verificationId, int? resendToken) {
          onCodeSent(verificationId); // Save verificationId for SMS code verification
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          // You could log a message here or inform the user about the timeout
          print("Code auto-retrieval timed out for verificationId: $verificationId");
        },
      );
    } catch (e) {
      Get.snackbar("Error", "An unexpected error occurred: ${e.toString()}");
    }
  }

  // Method to sign in using verification code
  Future<void> signInWithPhoneNumber(String verificationId, String smsCode) async {
    try {
      final credential = PhoneAuthProvider.credential(verificationId: verificationId, smsCode: smsCode);
      await _auth.signInWithCredential(credential); // Sign in with SMS code
      Get.offAllNamed('/home'); // Navigate to home on success
    } catch (e) {
      Get.snackbar("Error", "Failed to sign in: ${e.toString()}"); // Handle error safely
    }
  }

  // Get the currently authenticated user
  User? getCurrentUser() {
    return _auth.currentUser;
  }
}
