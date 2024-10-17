import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:get/get.dart';
import '../../controllers/Map_Controller.dart'; // Import your controller
import '../home/home_view.dart';
 // Import the HomePage

class MapPage extends StatelessWidget {
  final MapController mapController = Get.put(MapController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Obx(() => GoogleMap(
            mapType: MapType.normal,
            initialCameraPosition: CameraPosition(
              target: mapController.initialPosition,
              zoom: 12.0,
            ),
            onMapCreated: mapController.onMapCreated,
            myLocationEnabled: true, // Enable current location
            myLocationButtonEnabled: true, // Add button for locating user
            markers: {
              if (mapController.currentPosition.value != null)
                Marker(
                  markerId: MarkerId('currentLocation'),
                  position: LatLng(
                      mapController.currentPosition.value!.latitude,
                      mapController.currentPosition.value!.longitude),
                  infoWindow:
                  InfoWindow(title: mapController.currentAddress.value),
                ),
            },
          )),
          Positioned(
            bottom: 50,
            left: 10,
            right: 10,
            child: Column(
              children: [
                Obx(() {
                  if (mapController.isLoading.value) {
                    return CircularProgressIndicator(); // Loading indicator
                  } else if (mapController.currentPosition.value != null &&
                      !mapController.isLoading.value) {
                    return Text(
                      mapController.currentAddress.value,
                      style:
                      TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    );
                  }
                  return Container();
                }),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: mapController.getCurrentLocation,
                  child: Text('Get Current Location'),
                ),
                SizedBox(height: 10), // Spacing between buttons
                ElevatedButton(
                  onPressed: () {
                    // Navigate to the home page when "Next" is pressed
                    Get.to(HomePage());
                  },
                  child: Text('Next'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
