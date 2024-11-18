import 'package:get/get.dart';

class ChoicesController extends GetxController {
  var selectedJob = ''.obs;

  void selectJob(String job) {
    selectedJob.value = job;
  }
}
