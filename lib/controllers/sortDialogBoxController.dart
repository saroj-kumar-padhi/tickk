import 'package:dekhlo/controllers/productSetupController.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:logger/logger.dart';

class DialogBoxController extends GetxController {
  var selectedValue = 0.obs;
  var locacationController = TextEditingController().obs;
  var latitude = 0.0.obs;
  var longitude = 0.0.obs;
  var currentZoom = 14.0.obs;
  Logger logger = Logger();
  Rx<GoogleMapController?> mapController = Rx<GoogleMapController?>(null);

  final ProductSetUpController productSetUpController =
      Get.put(ProductSetUpController());

  void setSelectedValue(int value) {
    selectedValue.value = value;
  }

  void setMapController(GoogleMapController controller) {
    mapController.value = controller;
  }

  Future<void> moveCameraToLocation(double lat, double lng) async {
    if (mapController.value != null) {
      final CameraPosition newPosition = CameraPosition(
        target: LatLng(lat, lng),
        zoom: 14.0,
      );
      mapController.value!
          .animateCamera(CameraUpdate.newCameraPosition(newPosition));
    }
  }

  Future<void> updateLocationFromCoordinates(double lat, double lng) async {
    try {
      latitude.value = lat;
      longitude.value = lng;
      List<Placemark> placemarks = await placemarkFromCoordinates(lat, lng);
      if (placemarks.isNotEmpty) {
        Placemark place = placemarks.first;
        locacationController.update((val) {
          val?.text =
              "${place.name} ${place.street},${place.subLocality} ${place.locality}, ${place.administrativeArea}, ${place.country}";
        });
      }
      await moveCameraToLocation(lat, lng);
    } catch (e) {
      logger.e("Error updating location: $e");
    }
  }

  Future<void> getCurrentLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      logger.d("Location Denied");
      LocationPermission ask = await Geolocator.requestPermission();
    } else {
      Position currentLocation = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best);

      latitude.value = currentLocation.latitude;
      longitude.value = currentLocation.longitude;
      await updateLocationFromCoordinates(
          currentLocation.latitude, currentLocation.longitude);
    }
  }

  RxInt selectedTab = 0.obs;
}
