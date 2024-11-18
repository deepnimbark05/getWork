import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/doctor_model.dart';

class UserController extends GetxController {
  var usersList = <Doctor>[].obs; // Observable list of users

  @override
  void onInit() {
    super.onInit();
    fetchDoctors();
  }

  void fetchDoctors() {
    try {
      // Listen to Firestore changes in real-time
      FirebaseFirestore.instance.collection('users').snapshots().listen((snapshot) {
        final doctors = snapshot.docs.map((doc) {
          try {
            return Doctor.fromDocument(doc); // Parse Firestore data
          } catch (e) {
            print("Error parsing doctor document: $e");
            return null; // Return null if parsing fails
          }
        }).where((doctor) => doctor != null).cast<Doctor>().toList();

        // Assign the parsed doctors to the observable list
        usersList.assignAll(doctors);
      });
    } catch (e) {
      // Display error in a snackbar
      Get.snackbar("Error", "Failed to fetch users: $e", snackPosition: SnackPosition.BOTTOM);
    }
  }
}
