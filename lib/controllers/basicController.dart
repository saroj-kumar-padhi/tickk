import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BasicDetailsController extends GetxController {
  RxBool isButtonEnabled = false.obs;

  void updateButtonOpacity(bool isFilled) {
    isButtonEnabled.value = isFilled;
  }

  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailAddressController = TextEditingController();
  TextEditingController ageController = TextEditingController();

  void updateButtonState() {
    String fullName = fullNameController.text;
    String emailAddress = emailAddressController.text;
    String age = ageController.text;
    bool isFilled = fullName.isNotEmpty &&
        age.isNotEmpty; // Update this condition based on your text fields

    updateButtonOpacity(isFilled);
  }
}
