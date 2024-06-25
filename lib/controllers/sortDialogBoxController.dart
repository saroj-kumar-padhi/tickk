import 'package:dekhlo/controllers/productSetupController.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class DialogBoxController extends GetxController {
  var selectedValue = 0.obs;
  var locacationController = TextEditingController().obs;
  var latitude = 0.0.obs;
  var longitude = 0.0.obs;
  Logger logger = Logger();
  final ProductSetUpController productSetUpController =
      Get.put(ProductSetUpController());

  void setSelectedValue(int value) {
    selectedValue.value = value;
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
              "${place.name} ${place.street}, ${place.locality}, ${place.administrativeArea}, ${place.country}";
        });
        productSetUpController.pinCodeController.value.text =
            place.postalCode ?? "";
        productSetUpController.colonyController.value.text = place.street ?? "";
        productSetUpController.landMarkController.value.text = place.name ?? "";
      }
    } catch (e) {
      logger.e("Error updating location: $e");
    }
  }

  getCurrentLoaction() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      logger.d("Loaction Denied");
      LocationPermission ask = await Geolocator.requestPermission();
    } else {
      Position currentLocation = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best);
      // logger.d("floor${currentLocation.latitude}");
      // logger.d(currentLocation.longitude);

      latitude.value = currentLocation.latitude;
      longitude.value = currentLocation.longitude;
      List<Placemark> placemarks = await placemarkFromCoordinates(
          currentLocation.latitude, currentLocation.longitude);
      logger.d(placemarks.first);
      productSetUpController.pinCodeController.value.text =
          placemarks.first.postalCode ?? "";
      productSetUpController.colonyController.value.text =
          placemarks.first.street ?? "";
      productSetUpController.landMarkController.value.text =
          placemarks.first.name ?? "";
      locacationController.value.text =
          "${placemarks.first.name} ${placemarks.first.street}, ${placemarks.first.locality}, ${placemarks.first.administrativeArea}, ${placemarks.first.country}";
    }
  }

  RxInt selectedTab = 0.obs;
}
