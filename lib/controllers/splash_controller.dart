import 'package:get/get.dart';
import '../firebase_services/splash_services.dart';

class SplashController extends GetxController {
  final SplashService splashService = SplashService();

  @override
  void onInit() {
    super.onInit();
    splashService.checkLoginStatus();
  }
}
