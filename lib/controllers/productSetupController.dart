import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductSetUpController extends GetxController {
  final TextEditingController nameEditingController = TextEditingController();
  final TextEditingController contactEditingController =
      TextEditingController();
  final TextEditingController storeEditingController = TextEditingController();
  final TextEditingController subCategoryEditingController =
      TextEditingController();
  final TextEditingController brandsController = TextEditingController();
  final TextEditingController discriptionController = TextEditingController();
  final TextEditingController youTubeEditingController =
      TextEditingController();
  //day controllers
  final TextEditingController sundayOpenTimeEditingController =
      TextEditingController();
  final TextEditingController sundayCloseEditingController =
      TextEditingController();
  final TextEditingController mondayOpenTimeEditingController =
      TextEditingController();
  final TextEditingController mondayCloseEditingController =
      TextEditingController();
  final TextEditingController tuesdayOpenTimeEditingController =
      TextEditingController();
  final TextEditingController tuesdayCloseEditingController =
      TextEditingController();
  final TextEditingController wednesdayOpenTimeEditingController =
      TextEditingController();
  final TextEditingController wednesdayCloseEditingController =
      TextEditingController();
  final TextEditingController thursdayOpenTimeEditingController =
      TextEditingController();
  final TextEditingController thursdayCloseEditingController =
      TextEditingController();
  final TextEditingController fridayOpenTimeEditingController =
      TextEditingController();
  final TextEditingController fridayCloseEditingController =
      TextEditingController();
  final TextEditingController saturdayOpenTimeEditingController =
      TextEditingController();
  final TextEditingController saturdayCloseEditingController =
      TextEditingController();

  //location controller
  final TextEditingController buildingController = TextEditingController();
  final TextEditingController pinCodeController = TextEditingController();
  final TextEditingController colonyController = TextEditingController();
  final TextEditingController landMarkController = TextEditingController();
  final TextEditingController locationController = TextEditingController();

  List<String> dayList = ["S", "M", "T", "W", "T", "F", "S"];
  RxList<int> selectedIndices = <int>[].obs;

  // Map to store timings for each day
  Map<String, List<String>> dayTimings = {
    "S": ["", ""],
    "M": ["", ""],
    "T": ["", ""],
    "W": ["", ""],
    "Th": ["", ""],
    "F": ["", ""],
    "Sa": ["", ""],
  }.obs;

  void updateButtonState() {
    bool fieldsFilled = buildingController.text.isNotEmpty &&
        pinCodeController.text.isNotEmpty &&
        colonyController.text.isNotEmpty &&
        landMarkController.text.isNotEmpty &&
        sundayOpenTimeEditingController.text.isNotEmpty &&
        sundayCloseEditingController.text.isNotEmpty &&
        mondayOpenTimeEditingController.text.isNotEmpty &&
        mondayCloseEditingController.text.isNotEmpty &&
        tuesdayOpenTimeEditingController.text.isNotEmpty &&
        tuesdayCloseEditingController.text.isNotEmpty &&
        wednesdayOpenTimeEditingController.text.isNotEmpty &&
        wednesdayCloseEditingController.text.isNotEmpty &&
        thursdayOpenTimeEditingController.text.isNotEmpty &&
        thursdayCloseEditingController.text.isNotEmpty &&
        fridayOpenTimeEditingController.text.isNotEmpty &&
        fridayCloseEditingController.text.isNotEmpty &&
        saturdayOpenTimeEditingController.text.isNotEmpty &&
        saturdayCloseEditingController.text.isNotEmpty;

    isButtonEnabled.value = fieldsFilled;
  }

  var isButtonEnabled = false.obs;

  void toggleSelection(int index) {
    if (selectedIndices.contains(index)) {
      selectedIndices.remove(index);
    } else {
      selectedIndices.add(index);
    }
  }

  void setDayTiming(String day, String openTime, String closeTime) {
    dayTimings[day] = [openTime, closeTime];
  }
}
