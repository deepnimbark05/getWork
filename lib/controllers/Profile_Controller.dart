import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import '../models/user_model.dart';
import '../controllers/choices_controller.dart';
import '../views/login/login_view.dart';

class ProfileController extends GetxController {
  // Observables for user data
  var userModel = UserModel().obs;
  var isGenderSelected = false.obs;
  var isJobTypeSelected = false.obs;
  var profileImageUrl = ''.obs; // URL of the profile image
  final emailController = TextEditingController();
  final ChoicesController choicesController = Get.put(ChoicesController());

  @override
  void onInit() {
    super.onInit();
    // Load user profile on app startup
    fetchUserProfile();

    // Listen for changes in job selection and update the job label
    ever(choicesController.selectedJob, (job) {
      updateJobLabel(job);
    });

    // Set email from Firebase Auth to the emailController
    final User? currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      emailController.text = currentUser.email ?? '';  // Auto-fill email
    }
  }

  // Update methods for user fields
  void updateNickName(String value) => userModel.update((user) => user?.nickName = value);
  void updateDOB(String value) => userModel.update((user) => user?.dob = value);
  void updatePhoneNumber(String value) => userModel.update((user) => user?.phoneNumber = value);
  void updateEmail(String value) => userModel.update((user) => user?.email = value);

  void updateGender(String gender) {
    userModel.update((user) => user?.gender = gender);
    isGenderSelected.value = true;
  }

  void updateJobType(String jobType) {
    userModel.update((user) => user?.jobType = jobType);
    isJobTypeSelected.value = true;
  }

  void updateAbout(String value) => userModel.update((user) => user?.about = value);
  void updateExperienceYear(int value) => userModel.update((user) => user?.experienceYear = value);
  void updateChargesMin(int value) => userModel.update((user) => user?.chargesMin = value);
  void updateChargesMax(int value) => userModel.update((user) => user?.chargesMax = value);
  void updateJobLabel(String value) => userModel.update((user) => user?.jobLabel = value);

  // Method to upload profile image
  Future<void> uploadProfileImage() async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        File file = File(pickedFile.path);
        String fileName = 'profile_images/${DateTime.now().millisecondsSinceEpoch}.jpg';
        Reference storageRef = FirebaseStorage.instance.ref().child(fileName);

        // Upload the image to Firebase Storage
        UploadTask uploadTask = storageRef.putFile(file);
        TaskSnapshot snapshot = await uploadTask;

        // Get the download URL and update the profileImageUrl observable
        profileImageUrl.value = await snapshot.ref.getDownloadURL();

        // Update the userModel's profile image URL
        userModel.update((user) => user?.profileImageUrl = profileImageUrl.value);

        // Show success message
        Get.snackbar('Success', 'Profile image uploaded successfully!',
            snackPosition: SnackPosition.BOTTOM);
      } else {
        Get.snackbar('No Image Selected', 'Please select an image to upload.',
            snackPosition: SnackPosition.BOTTOM);
      }
    } catch (e) {
      // Handle errors during image upload
      Get.snackbar('Error', 'Failed to upload image: $e', snackPosition: SnackPosition.BOTTOM);
    }
  }

  // Method to save user profile data to Firestore
  Future<void> saveUserProfile() async {
    try {
      final userData = userModel.value.toJson();
      userData['profileImageUrl'] = profileImageUrl.value; // Include profile image URL
      userData['selectedJob'] = choicesController.selectedJob.value; // Include job label
      userData['timestamp'] = FieldValue.serverTimestamp(); // Add timestamp

      // Save to Firestore
      await FirebaseFirestore.instance.collection('users').add(userData);

      // Show success message
      Get.snackbar('Success', 'Profile saved successfully!',
          snackPosition: SnackPosition.BOTTOM);
    } catch (e) {
      // Handle errors while saving the profile
      Get.snackbar('Error', 'Failed to save profile: $e', snackPosition: SnackPosition.BOTTOM);
    }
  }

  // Method to fetch user profile data sorted by time
  Future<void> fetchUserProfile() async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('users')
          .orderBy('timestamp', descending: true) // Order by timestamp
          .get();

      if (snapshot.docs.isNotEmpty) {
        final userData = snapshot.docs.first.data();
        userModel.value = UserModel.fromJson(userData);
        profileImageUrl.value = userModel.value.profileImageUrl ?? ''; // Load saved profile image URL
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to load profile: $e', snackPosition: SnackPosition.BOTTOM);
    }
  }

  // Logout method
  Future<void> logoutUser() async {
    try {
      // Sign out from Firebase Auth
      await FirebaseAuth.instance.signOut();

      // Print confirmation for debugging
      print("User logged out successfully");

      // Navigate to LoginView
      Get.offAll(() => LoginPage());
    } catch (e) {
      Get.snackbar("Error", "Logout failed. Please try again.",
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  @override
  void onClose() {
    // Dispose of controllers to free up resources
    emailController.dispose();
    super.onClose();
  }
}
