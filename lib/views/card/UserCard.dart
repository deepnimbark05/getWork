import 'package:flutter/material.dart';

class DoctorCard extends StatelessWidget {
  final String nickName; // Name of the user
  final String selectedJob; // Job or role
  final String? imageUrl; // Profile image URL

  const DoctorCard({
    required this.nickName,
    required this.selectedJob,
    this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      elevation: 3,
      child: ListTile(
        leading: CircleAvatar(
          radius: 25,
          backgroundImage: imageUrl != null && imageUrl!.isNotEmpty
              ? NetworkImage(imageUrl!) // Fetching image from URL
              : const AssetImage('assets/images/default_avatar.png') as ImageProvider,
          child: imageUrl == null || imageUrl!.isEmpty
              ? const Icon(Icons.person, size: 30, color: Colors.white) // Placeholder icon
              : null,
        ),
        title: Text(
          nickName,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.orange,
          ),
        ),
        subtitle: Text(
          selectedJob,
          style: const TextStyle(fontSize: 14, color: Colors.grey),
        ),
      ),
    );
  }
}
