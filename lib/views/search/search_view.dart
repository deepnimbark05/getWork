import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/User_Controller.dart';
import '../card/UserCard.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final UserController doctorController = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Search...',
              prefixIcon: Icon(Icons.search),
              filled: true,
              fillColor: Colors.grey[200],
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.sort),
            onPressed: () {},
            color: Colors.orange,
          ),
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () {},
            color: Colors.orange,
          ),
        ],
      ),
      body: Column(
        children: [
          SizedBox(height: 10),
          // Horizontal Categories List
          Container(
            height: 70,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                CategoryIcon(icon: Icons.group, label: 'Family'),
                CategoryIcon(icon: Icons.spa, label: 'Physio'),
                CategoryIcon(icon: Icons.home, label: 'Home Care'),
                CategoryIcon(icon: Icons.child_care, label: 'Baby Care'),
              ],
            ),
          ),
          SizedBox(height: 10),
          // Doctors List
          Expanded(
            child: Obx(() {
              if (doctorController.usersList.isEmpty) {
                return const Center(child: Text("No doctors available"));
              }
              return ListView.builder(
                itemCount: doctorController.usersList.length,
                itemBuilder: (context, index) {
                  final doctor = doctorController.usersList[index];
                  return DoctorCard(
                    nickName: doctor.nickName.value,
                    selectedJob: doctor.selectedJob.value,
                    imageUrl: doctor.imageUrl.value,
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}

class CategoryIcon extends StatelessWidget {
  final IconData icon;
  final String label;

  CategoryIcon({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Column(
        children: [
          Icon(icon, color: Colors.orange, size: 40),
          SizedBox(height: 5),
          Text(
            label,
            style: TextStyle(fontSize: 12, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
