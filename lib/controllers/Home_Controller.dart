// controllers/home_controller.dart
import 'package:get/get.dart';


import '../models/doctor_model.dart';
import 'User_Controller.dart';

class HomeController extends GetxController {
  var selectedIndex = 0.obs;
  var doctorList = <Doctor>[].obs;

  void onItemTapped(int index) {
    selectedIndex.value = index;
  }

}
