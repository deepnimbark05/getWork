import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:get/get.dart';
import '../../controllers/Map_Controller.dart';
import '../../controllers/User_Controller.dart';
import '../../controllers/profile_controller.dart';
import '../../worker/choices/choices_view.dart';
import '../card/UserCard.dart';

class HomePage extends StatelessWidget {
  final MapController mapController = Get.find<MapController>();
  final UserController doctorController = Get.put(UserController());
  final ProfileController profileController = Get.put(ProfileController());

  final List<String> imageList = [
    'assets/images/ad/slider3.webp',
    'assets/images/ad/slider1.jpeg',
    'assets/images/ad/slider2.jpeg',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: GestureDetector(
          onTap: () {
            // Show the modal bottom sheet with options
            showModalBottomSheet(
              context: context,
              builder: (BuildContext context) {
                return Container(
                  height: 100,
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10),
                      ListTile(
                        leading: const Icon(Icons.person),
                        title: const Text('On Work'),
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ChoicesPage()),
                          );
                        },
                      ),
                    ],
                  ),
                );
              },
            );
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Obx(() {
                        final userName =
                            profileController.userModel.value.nickName ??
                                "User";
                        return Text(
                          "Hello, $userName",
                          style: TextStyle(color: Colors.orange, fontSize: 20),
                        );
                      }),
                      const Icon(
                        Icons.arrow_drop_down,
                        color: Colors.grey,
                      ),
                    ],
                  ),
                  Obx(() {
                    return Text(
                      "📍${mapController.currentAddress.value}",
                      style: const TextStyle(color: Colors.grey, fontSize: 14),
                    );
                  }),
                ],
              ),
            ],
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications, color: Colors.orange),
            onPressed: () {
              // Handle notifications
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Image slider
            CarouselSlider(
              options: CarouselOptions(
                height: 180.0,
                autoPlay: true,
                enlargeCenterPage: true,
                viewportFraction: 0.9,
                aspectRatio: 16 / 9,
                autoPlayInterval: const Duration(seconds: 3),
              ),
              items: imageList.map((imagePath) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 5.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        image: DecorationImage(
                          image: AssetImage(imagePath),
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
            // Search bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Categories
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CategoryIcon(icon: Icons.people, label: 'General'),
                  CategoryIcon(icon: Icons.healing, label: 'Physiotherapy'),
                  CategoryIcon(icon: Icons.home, label: 'Home Care'),
                  CategoryIcon(
                      icon: Icons.baby_changing_station, label: 'Baby Care'),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // List of Users (Doctors)
            Obx(() {
              if (doctorController.usersList.isEmpty) {
                return const Center(child: Text("No doctors available"));
              }
              return ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
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
          ],
        ),
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
    return Column(
      children: [
        CircleAvatar(
          radius: 30,
          backgroundColor: Colors.orange.withOpacity(0.2),
          child: Icon(icon, color: Colors.orange, size: 35),
        ),
        const SizedBox(height: 8),
        Text(label, style: const TextStyle(fontSize: 14)),
      ],
    );
  }
}
