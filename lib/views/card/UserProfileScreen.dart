import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/Profile_Controller.dart';

class UserProfileScreen extends StatelessWidget {
  final ProfileController profileController = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Profile'),
        backgroundColor: Colors.orange,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Profile Image Section
            Obx(() {
              return CircleAvatar(
                radius: 50,
                backgroundImage: profileController.profileImageUrl.value.isNotEmpty
                    ? NetworkImage(profileController.profileImageUrl.value)
                    : const AssetImage('assets/images/avatar_placeholder.png') as ImageProvider,
                child: profileController.profileImageUrl.value.isEmpty
                    ? const Icon(Icons.person, size: 40, color: Colors.white)
                    : null,
              );
            }),
            const SizedBox(height: 16),

            // User Information
            Obx(() {
              return Text(
                profileController.userModel.value.nickName ?? 'No Name',
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              );
            }),
            const SizedBox(height: 8),
            Obx(() {
              return Text(
                profileController.userModel.value.jobType ?? 'No Job',
                style: const TextStyle(fontSize: 16, color: Colors.grey),
              );
            }),
          ],
        ),
      ),
    );
  }
}
