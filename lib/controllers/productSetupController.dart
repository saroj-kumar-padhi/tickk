import 'package:dekhlo/services/injection.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/web.dart';

class ProductSetUpController extends GetxController {
  RxBool isLoading = false.obs;

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
  final TextEditingController instagram = TextEditingController();
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
  var pinCodeController = TextEditingController().obs;
  var colonyController = TextEditingController().obs;
  var landMarkController = TextEditingController().obs;
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
        pinCodeController.value.text.isNotEmpty &&
        colonyController.value.text.isNotEmpty &&
        landMarkController.value.text.isNotEmpty &&
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

  Future<void> setupStrore(
      List<String> imagePath,
      List<dynamic> category,
      List<dynamic> subcategories,
      List<dynamic> subSubCategory,
      List<String> brands) async {
    final data = {
      "mobile": contactEditingController.text,
      "StoreName": nameEditingController.text,
      "storeCategory": category,
      "storeSubCategory": subcategories,
      "storeSubSubCategory": subSubCategory,
      "Brands": brands,
      "About_the_store": discriptionController.text,
      "timings": {
        "Sunday": {
          "open": sundayOpenTimeEditingController.text,
          "close": sundayCloseEditingController.text
        },
        "Monday": {
          "open": mondayOpenTimeEditingController.text,
          "close": mondayCloseEditingController.text
        },
        "Tuesday": {
          "open": tuesdayOpenTimeEditingController.text,
          "close": tuesdayCloseEditingController.text
        },
        "Wednesday": {
          "open": wednesdayOpenTimeEditingController.text,
          "close": wednesdayCloseEditingController.text
        },
        "Thursday": {
          "open": thursdayOpenTimeEditingController.text,
          "close": thursdayCloseEditingController.text
        },
        "Friday": {
          "open": fridayOpenTimeEditingController.text,
          "close": fridayCloseEditingController.text
        },
        "Saturday": {
          "open": saturdayOpenTimeEditingController.text,
          "close": saturdayCloseEditingController.text
        }
      },
      "youtubelink": youTubeEditingController.text,
      "instagarmlink": instagram.text,
      "languages": "english",
      "BuildingNo": int.parse(buildingController.text),
      "Pincode": int.parse(pinCodeController.value.text),
      "ColonyName": colonyController.value.text,
      "Location": "Sample City, Sample State, Sample Country",
      "AddImage": imagePath,
      "Landmark": landMarkController.value.text,
      "stared": 3
    };

    try {
      await restClient.setupStrore(data);
    } catch (e) {
      Logger().d(e);
    }
  }
}
