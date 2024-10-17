import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapController extends GetxController {
  var currentAddress = 'Unknown Location'.obs;
  var currentPosition = Rxn<Position>();
  var isLoading = false.obs;
  final initialPosition = LatLng(37.77483, -122.41942); // San Francisco coordinates
  late GoogleMapController mapController;

  @override
  void onInit() {
    super.onInit();
    getCurrentLocation();
  }

  Future<void> getCurrentLocation() async {
    isLoading.value = true;

    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      Get.snackbar('Error', 'Location services are disabled.');
      isLoading.value = false;
      return;
    }

    // Check and request permissions if necessary
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        Get.snackbar('Error', 'Location permissions are denied.');
        isLoading.value = false;
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      Get.snackbar('Error', 'Location permissions are permanently denied.');
      isLoading.value = false;
      return;
    }

    // Get the current position
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      currentPosition.value = position;
      getAddressFromLatLng(position);
    } catch (e) {
      Get.snackbar('Error', 'Failed to get current location: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> getAddressFromLatLng(Position position) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      Placemark place = placemarks[0];
      currentAddress.value =
      "${place.name}, ${place.locality}, ${place.administrativeArea}, ${place.country}";
    } catch (e) {
      Get.snackbar('Error', 'Error retrieving address: $e');
    }
  }

  void onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }
}
