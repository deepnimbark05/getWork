import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/profile_controller.dart';
import '../login/login_view.dart';
import '../../worker/profile/profile.dart';

class Profilepage extends StatefulWidget {
  const Profilepage({super.key});

  @override
  State<Profilepage> createState() => _ProfilepageState();
}

class _ProfilepageState extends State<Profilepage> {
  final ProfileController controller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Profile',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Profile Header Section
          Container(
            padding: const EdgeInsets.all(16.0),
            color: Colors.grey[200],
            child: InkWell(
              onTap: () {
                Get.to(() => const Profile()); // Navigate to the Profile screen
              },
              child: Row(
                children: [
                  // Profile Image
                  Obx(() {
                    return CircleAvatar(
                      radius: 30,
                      backgroundImage: controller.profileImageUrl.value.isNotEmpty
                          ? NetworkImage(controller.profileImageUrl.value)
                          : const AssetImage('assets/profile_placeholder.png') as ImageProvider,
                    );
                  }),
                  const SizedBox(width: 16),
                  // Profile Name and Job Label
                  Obx(() {
                    final user = controller.userModel.value;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          user.nickName ?? "User Name",
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold, color: Colors.orange),
                        ),
                        Text(
                          user.jobLabel ?? 'Job Label',
                          style: const TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                      ],
                    );
                  }),
                  const Spacer(),
                  const Icon(Icons.arrow_forward_ios, color: Colors.grey),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          // Settings List
          Expanded(
            child: ListView(
              children: [
                const ListTile(
                  leading: Icon(Icons.brightness_6_outlined, color: Colors.orange),
                  title: Text('Mode'),
                  subtitle: Text('Dark & Light'),
                ),
                ListTile(
                  leading: const Icon(Icons.location_on_outlined, color: Colors.orange),
                  title: const Text('Manage addresses'),
                  trailing: const Icon(Icons.arrow_forward_ios, color: Colors.grey),
                  onTap: () {
                    // Navigate to Manage Addresses screen
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.info_outline, color: Colors.orange),
                  title: const Text('About'),
                  trailing: const Icon(Icons.arrow_forward_ios, color: Colors.grey),
                  onTap: () {
                    // Navigate to About screen
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.article_outlined, color: Colors.orange),
                  title: const Text('Terms & Conditions'),
                  trailing: const Icon(Icons.arrow_forward_ios, color: Colors.grey),
                  onTap: () {
                    // Navigate to Terms & Conditions screen
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.lock_outline, color: Colors.orange),
                  title: const Text('Privacy Policy'),
                  trailing: const Icon(Icons.arrow_forward_ios, color: Colors.grey),
                  onTap: () {
                    // Navigate to Privacy Policy screen
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.star_border, color: Colors.orange),
                  title: const Text('Rate This App'),
                  trailing: const Icon(Icons.arrow_forward_ios, color: Colors.grey),
                  onTap: () {
                    // Navigate to Rate This App screen
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.share_outlined, color: Colors.orange),
                  title: const Text('Share This App'),
                  trailing: const Icon(Icons.arrow_forward_ios, color: Colors.grey),
                  onTap: () {
                    // Navigate to Share This App screen
                  },
                ),
              ],
            ),
          ),
          // Log out button
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                padding: const EdgeInsets.symmetric(vertical: 15),
              ),
              onPressed: () async {
                await controller.logoutUser(); // Call the logout function
              },
              child: const Center(
                  child: Text("Log Out", style: TextStyle(fontSize: 16, color: Colors.white))),
            ),
          ),
        ],
      ),
    );
  }
}



