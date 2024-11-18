import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/profile_controller.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    final ProfileController controller = Get.find<ProfileController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Profile"),
        backgroundColor: Colors.orange,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
      ),
      body: Obx(() {
        final user = controller.userModel.value;
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                // Profile Image and Edit Button
                Stack(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: controller.profileImageUrl.value.isNotEmpty
                          ? NetworkImage(controller.profileImageUrl.value)
                          : const AssetImage('assets/profile_placeholder.png') as ImageProvider,
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: IconButton(
                        icon: const Icon(Icons.camera_alt, color: Colors.orange),
                        onPressed: () {
                          // Call the upload image method to update profile picture
                          controller.uploadProfileImage();
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                // Display User Information
                Text(
                  user.nickName ?? "User Name",
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text(
                  user.jobLabel ?? 'Job Label',  // Display job label
                  style: const TextStyle(fontSize: 16),
                ),
                Text(user.email ?? "user@example.com", style: const TextStyle(color: Colors.grey)),
                const SizedBox(height: 24),

                // Portfolio Information
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      buildPortfolioRow(Icons.star, "Rating", "4.9 (Available)"),
                      const Divider(),
                      buildPortfolioRow(Icons.attach_money, "Earning", "INR 30,000"),
                      const Divider(),
                      buildPortfolioRow(Icons.trending_up, "Richest", "50 Popularity"),
                      const Divider(),
                      const SizedBox(height: 16),
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: const [BoxShadow(color: Colors.grey, blurRadius: 4)],
                        ),
                        child: Row(
                          children: [
                            const CircleAvatar(
                              radius: 20,
                              backgroundImage: AssetImage('assets/active_work_placeholder.png'),
                            ),
                            const SizedBox(width: 16),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text("Manish Ramani", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                                Text("Active Work", style: TextStyle(color: Colors.blue)),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // Additional User Details
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      buildDetailRow(Icons.person, "Name", user.nickName ?? "N/A"),
                      buildDetailRow(Icons.phone, "Phone", user.phoneNumber ?? "N/A"),
                      buildDetailRow(Icons.calendar_today, "Experience", "${user.experienceYear ?? 0} Years"),
                      buildDetailRow(Icons.school, "Job Type", user.jobType ?? "N/A"),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // Edit Button
                ElevatedButton(
                  onPressed: () {
                    // Navigate to edit screen
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                  ),
                  child: const Text("Edit"),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  // Portfolio Information Row
  Widget buildPortfolioRow(IconData icon, String title, String value) {
    return Row(
      children: [
        Icon(icon, color: Colors.orange),
        const SizedBox(width: 8),
        Text(title, style: const TextStyle(fontSize: 16)),
        const Spacer(),
        Text(value, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      ],
    );
  }

  // User Detail Row
  Widget buildDetailRow(IconData icon, String title, String value) {
    return Row(
      children: [
        Icon(icon, color: Colors.orange),
        const SizedBox(width: 8),
        Text(title, style: const TextStyle(fontSize: 16)),
        const Spacer(),
        Text(value, style: const TextStyle(fontSize: 16)),
      ],
    );
  }
}
