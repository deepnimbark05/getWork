import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/profile_controller.dart';
import '../../controllers/choices_controller.dart';
import '../../views/home/home_view.dart';
import '../../views/profile/profile_view.dart';

class ProfileScreen extends StatelessWidget {
  final ProfileController controller = Get.put(ProfileController());
  final ChoicesController choicesController = Get.put(ChoicesController());

  @override
  Widget build(BuildContext context) {
    final String? selectedJobType = Get.arguments;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (selectedJobType != null) {
        controller.updateJobType(selectedJobType);
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: Text("Fill Your Profile"),
        backgroundColor: Colors.orange,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Obx(() {
                return Stack(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: controller
                          .profileImageUrl.value.isNotEmpty
                          ? NetworkImage(controller.profileImageUrl.value)
                          : const AssetImage('assets/profile_placeholder.png')
                      as ImageProvider,
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: IconButton(
                        icon: const Icon(Icons.camera_alt, color: Colors.white),
                        onPressed: () => controller.uploadProfileImage(),
                      ),
                    ),
                  ],
                );
              }),
              SizedBox(height: 16),
              buildTextField(Icons.person, "NickName",
                      (value) => controller.updateNickName(value)),
              buildTextField(Icons.phone, "+91 Mobile Number",
                      (value) => controller.updatePhoneNumber(value)),
              buildTextField(Icons.email, "Email",
                      (value) => controller.updateEmail(value),
                  controller: controller.emailController),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  buildGenderButton("Male", "Male"),
                  buildGenderButton("Female", "Female"),
                  buildGenderButton("Others", "Others"),
                ],
              ),
              SizedBox(height: 16),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Job Type",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  buildJobTypeButton("Part Time", "Part Time"),
                  buildJobTypeButton("Full Time", "Full Time"),
                ],
              ),
              SizedBox(height: 16),
              buildTextField(Icons.info, "About",
                      (value) => controller.updateAbout(value)),
              buildTextField(
                  Icons.work,
                  "Experience Year",
                      (value) => controller
                      .updateExperienceYear(int.tryParse(value) ?? 0)),
              Row(
                children: [
                  Expanded(
                      child: buildTextField(
                          Icons.attach_money,
                          "Charges INR (Min)",
                              (value) => controller
                              .updateChargesMin(int.tryParse(value) ?? 0))),
                  SizedBox(width: 10),
                  Expanded(
                      child: buildTextField(
                          Icons.attach_money,
                          "Charges INR (Max)",
                              (value) => controller
                              .updateChargesMax(int.tryParse(value) ?? 0))),
                ],
              ),
              SizedBox(height: 16),
              // Job Label Field
              Obx(() => buildTextField(
                Icons.label,
                "Job Label",
                    (value) => controller.updateJobLabel(value), // Corrected the method call
                controller: TextEditingController(text: choicesController.selectedJob.value),
              )),
              SizedBox(height: 16),
              Obx(() {
                bool isNextButtonActive = controller.isGenderSelected.value &&
                    controller.isJobTypeSelected.value;
                return ElevatedButton(
                  onPressed: isNextButtonActive
                      ? () {
                    controller.saveUserProfile();
                    Get.to(Profilepage());
                  }
                      : null,
                  child: Text("Next"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                    isNextButtonActive ? Colors.orange : Colors.grey,
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextField(
      IconData icon, String hintText, Function(String) onChanged,
      {TextEditingController? controller}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          prefixIcon: Icon(icon),
          hintText: hintText,
          border: OutlineInputBorder(),
        ),
        onChanged: onChanged,
      ),
    );
  }

  Widget buildGenderButton(String label, String gender) {
    return Obx(() {
      return ElevatedButton(
        onPressed: () {
          controller.updateGender(gender);
        },
        child: Text(label),
        style: ElevatedButton.styleFrom(
          backgroundColor: controller.userModel.value.gender == gender
              ? Colors.orange
              : Colors.grey,
        ),
      );
    });
  }

  Widget buildJobTypeButton(String label, String jobType) {
    return Obx(() {
      return ElevatedButton(
        onPressed: () {
          controller.updateJobType(jobType);
        },
        child: Text(label),
        style: ElevatedButton.styleFrom(
          backgroundColor: controller.userModel.value.jobType == jobType
              ? Colors.orange
              : Colors.grey,
        ),
      );
    });
  }
}
extension on ProfileController {
  updateJobLabel(String value) {}
}