import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/choices_controller.dart'; // Ensure correct path
import '../form/form_view.dart';
import '../image/Upload_Image.dart';
import 'button_view.dart';


class ChoicesPage extends StatelessWidget {
  final ChoicesController choicesController = Get.put(ChoicesController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset(
              'assets/images/background2.jpg',
              fit: BoxFit.cover,
            ),
          ),
          // Main Content
          SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.only(top: 30),
                  child: Image.asset(
                    'assets/images/logo/logo.png',
                    height: 150,
                  ),
                ),
                Text(
                  'Hello, Deep Nimbark',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  'Choose Your Job Type',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white70,
                  ),
                ),
                SizedBox(height: 20),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: GridView.count(
                      crossAxisCount: 2, // 2 buttons per row
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20,
                      children: [
                        Obx(() => JobTypeButton(
                          icon: Icons.elderly,
                          label: 'Old Care',
                          isSelected: choicesController.selectedJob.value == 'Old Care',
                          onPressed: () {
                            choicesController.selectJob('Old Care');
                          },
                        )),
                        Obx(() => JobTypeButton(
                          icon: Icons.healing,
                          label: 'Physical Therapy',
                          isSelected: choicesController.selectedJob.value == 'Physical Therapy',
                          onPressed: () {
                            choicesController.selectJob('Physical Therapy');
                          },
                        )),
                        Obx(() => JobTypeButton(
                          icon: Icons.cleaning_services,
                          label: 'House Cleaning',
                          isSelected: choicesController.selectedJob.value == 'House Cleaning',
                          onPressed: () {
                            choicesController.selectJob('House Cleaning');
                          },
                        )),
                        Obx(() => JobTypeButton(
                          icon: Icons.child_care,
                          label: 'Baby Sitting',
                          isSelected: choicesController.selectedJob.value == 'Baby Sitting',
                          onPressed: () {
                            choicesController.selectJob('Baby Sitting');
                          },
                        )),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 37.0),
                  child: Obx(() => SizedBox(
                    width: 320,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: choicesController.selectedJob.value.isNotEmpty
                          ? () {
                        // Pass the selected job type to ProfileScreen
                        Get.to(ProfileScreen(), arguments: choicesController.selectedJob.value);
                        // Get.to(UploadImage(),);
                      }
                          : null, // Disable the button if no job is selected
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange[700],
                        shape: BeveledRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(2)),
                        ),
                      ),
                      child: Text(
                        'Continue',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                  )),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
