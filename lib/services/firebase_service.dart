import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user_model.dart';

class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Save user profile data to Firestore
  Future<void> saveUserProfile(UserModel userModel) async {
    try {
      if (userModel.email == null || userModel.email!.isEmpty) {
        throw Exception('User email cannot be null or empty.');
      }

      await _firestore
          .collection('users')
          .doc(userModel.email) // Use email as the document ID
          .set(userModel.toMap()); // Assuming UserModel has toMap() method

      print("User profile saved successfully.");
    } catch (e) {
      print("Error saving user profile: $e");
      rethrow; // Optionally, propagate the error for further handling
    }
  }

  /// Fetch all user profiles from Firestore
  Future<List<UserModel>> fetchAllProfiles() async {
    try {
      final querySnapshot = await _firestore.collection('users').get();
      return querySnapshot.docs
          .map((doc) => UserModel.fromMap(doc.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      print("Error fetching profiles: $e");
      return [];
    }
  }
}
