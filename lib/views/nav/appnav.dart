// views/main_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_work/views/profile/profile_view.dart';
import 'package:get_work/views/search/search_view.dart';
import '../../controllers/Home_Controller.dart';
import '../chat/chat_view.dart';
import '../home/home_view.dart';

class AppNav extends StatelessWidget {
  final HomeController homeController = Get.put(HomeController());

  final List<Widget> _pages = [
    HomePage(),
    ChatScreen(),
    SearchPage(),
    Profilepage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
      body: _pages[homeController.selectedIndex.value],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: homeController.selectedIndex.value,
        selectedItemColor: Colors.orange,
        unselectedItemColor: Colors.grey,
        onTap: homeController.onItemTapped,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'Chat',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Profile',
          ),
        ],
      ),
    ));
  }
}
