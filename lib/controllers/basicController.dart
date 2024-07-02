import 'package:dekhlo/controllers/authController.dart';
import 'package:dekhlo/models/basicDetailsModel.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

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
      final createBuyerRequest = {
        "mobile": "1234554321",
        "your_name": fullNameController.text,
        "email": emailAddressController.text,
        "gender": gender.value,
        "age": int.parse(ageController.text),
        "otp": 123456,
        "verified": false,
        "FCM": fcmToken
      };

      await restClient.postBuyer(createBuyerRequest).then((value) {
        isLoading.value = false;
        isSuccessRegister.value = true;
      }).catchError((error) {
        isLoading.value = true;
        Fluttertoast.showToast(
            msg: "user either registerd already or invalid details provided");
        isLoading.value = false;
      });
    } catch (error) {
      isLoading.value = true;
      Fluttertoast.showToast(msg: "$error");
      isLoading.value = false;
    }
  }
}
