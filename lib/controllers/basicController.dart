import 'package:dekhlo/controllers/authController.dart';
import 'package:dekhlo/models/basicDetailsModel.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart' show ByteData, rootBundle;
import 'package:path_provider/path_provider.dart';
import 'dart:io';

import '../services/injection.dart';

class BasicDetailsController extends GetxController {
  RxBool isButtonEnabled = false.obs;
  RxString gender = ''.obs;
  RxBool isSuccessRegister = false.obs;
  AuthController authController = Get.put(AuthController());

  void updateButtonOpacity(bool isFilled) {
    isButtonEnabled.value = isFilled;
  }

  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailAddressController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  RxBool isLoading = false.obs;

  void updateButtonState() {
    String fullName = fullNameController.text;
    String age = ageController.text;
    String selectedGender = gender.value;
    bool isFilled =
        fullName.isNotEmpty && age.isNotEmpty && selectedGender != '';

    updateButtonOpacity(isFilled);
  }

  Future<void> postToApi() async {
    try {
      String? fcmToken = await FirebaseMessaging.instance.getToken();
      isLoading.value = true;

      // Use the relative path directly
      String imagePath = 'task/assets/men.png';

      final createBuyerRequest = {
        "mobile": authController.phoneAuthController.text,
        "your_name": fullNameController.text,
        "email": emailAddressController.text,
        "gender": gender.value,
        "profileImage": imagePath, // Use the relative path
        "age": int.parse(ageController.text),
        "otp": 123456,
        "verified": false,
        "FCM": fcmToken
      };

      await restClient.postBuyer(createBuyerRequest).then((value) {
        isLoading.value = false;
        isSuccessRegister.value = true;
      }).catchError((error) {
        isLoading.value = false;
        Fluttertoast.showToast(
            msg: "User either registered already or invalid details provided");
      });
    } catch (error) {
      isLoading.value = false;
      Fluttertoast.showToast(msg: "$error");
    }
  }
}
