import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class StartController extends GetxController {
  // List of images and text for the slides
  final List<String> backgroundImages = [
    'assets/images/intro/1.jpg',
    'assets/images/intro/2.jpg',
    'assets/images/intro/3.jpg',
  ];

  final List<String> imageTexts = [
    'We are the best job portal platform',
    'The place where work finds you',
    "Let's start your career with us now!",
  ];

  final List<String> texTexts = [
    'All of Netflix, starting at just ₹149',
    'Always have something to watch',
    'Join today, no reason to wait.',
  ];

  RxInt currentPage = 0.obs; // Observable for page index
  late PageController pageController;
  late Timer timer;

  @override
  void onInit() {
    super.onInit();
    pageController = PageController(initialPage: 0);
    startSliderTimer();
  }

  void startSliderTimer() {
    timer = Timer.periodic(Duration(seconds: 3), (Timer timer) {
      if (currentPage.value < backgroundImages.length - 1) {
        currentPage.value++;
      } else {
        currentPage.value = 0;
      }

      pageController.animateToPage(
        currentPage.value,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    });
  }

  @override
  void onClose() {
    timer.cancel();
    pageController.dispose();
    super.onClose();
  }
}
