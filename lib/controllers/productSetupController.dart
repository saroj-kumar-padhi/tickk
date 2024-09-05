import 'dart:convert';

import 'package:dekhlo/controllers/authController.dart';
import 'package:dekhlo/controllers/categoriesController.dart';
import 'package:dekhlo/controllers/sortDialogBoxController.dart';
import 'package:dekhlo/models/sellerInprocess.dart';
import 'package:dekhlo/services/injection.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:logger/web.dart';
import 'package:multi_dropdown/models/value_item.dart';
import 'package:path/path.dart' as path;
import 'package:dio/dio.dart' as dio;
import 'package:http_parser/http_parser.dart' show MediaType;
import '../utils/components/bottomSheets/sort.dart';
import '../views/seller_views/seller_home_screens/seller_home.dart';

class ProductSetUpController extends GetxController {
  RxBool isLoading = false.obs;
  RxInt staredImageIndex = (-1).obs;
  final RxList<String> staredImage = <String>[].obs;
  final isSetupCompleted = false.obs;
  final isProcessing = false.obs;
  RxInt count = 0.obs;
  final buttonText = "Next".obs;
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
  final TextEditingController website = TextEditingController();
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
    CategoriesController categoriesController = Get.put(CategoriesController());


  //location controller
  final TextEditingController buildingController = TextEditingController();
  var pinCodeController = TextEditingController().obs;
  var colonyController = TextEditingController().obs;
  var landMarkController = TextEditingController().obs;
  var cityController = TextEditingController().obs;
  final TextEditingController locationController = TextEditingController();
  final RxList<String> imagePaths = <String>[].obs;
  final RxList<String> selectedCategories  = <String>[].obs;

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
    DialogBoxController dialogBoxController = Get.put(DialogBoxController());
    bool fieldsFilled = buildingController.text.isNotEmpty &&
       selectedCategories.isNotEmpty &&
       nameEditingController.text.isNotEmpty &&
        pinCodeController.value.text.isNotEmpty &&
        imagePaths.value.isNotEmpty &&
        //here
        colonyController.value.text.isNotEmpty &&
        cityController.value.text.isNotEmpty &&
        dialogBoxController.locacationController.value.text.isNotEmpty;


    // landMarkController.value.text.isNotEmpty;

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
      List<String> imagePaths,
      List<dynamic> category,
      List<dynamic> subcategories,
      List<dynamic> subSubCategory,
      List<String> brands) async {
    try {
      isLoading.value = true;

      final DialogBoxController dialogBoxController =
          Get.find<DialogBoxController>();
      String address = dialogBoxController.locacationController.value.text;
      // Map<String, double> convertedAddressToLatLong =
      //     await convertAddressToLatLong(
      //         dialogBoxController);

      var formData = dio.FormData();
      final box = Hive.box('myBox');
      final String formattedPhoneNumber = box.get('phone') ?? "";

      // Add non-file fields
      formData.fields.addAll([
        MapEntry("mobile", formattedPhoneNumber),
        MapEntry("StoreName", nameEditingController.text),
        MapEntry("storeCategory", category.join(',')),
        MapEntry(
            "storeSubCategory",
            subcategories
                .map((item) => item is ValueItem ? item.label : item)
                .join(',')),
        MapEntry(
            "storeSubSubCategory",
            subSubCategory
                .map((item) => item is ValueItem ? item.label : item)
                .join(',')),
        MapEntry("Brands", brands.join(',')),
        MapEntry("About_the_store", discriptionController.text),
        MapEntry("timings", jsonEncode(getTimings())),
        MapEntry("youtubelink", youTubeEditingController.text),
        MapEntry("instagarmlink", instagram.text),
        MapEntry("Websitelink", website.text),
        const MapEntry("languages", "english"),
        MapEntry("StreetNo_BuildingName", buildingController.text),
        const MapEntry("Country", "India"),
        MapEntry("Postcode_ZIP", pinCodeController.value.text),
        MapEntry("StreetName_Area", colonyController.value.text),
        MapEntry(
            "sellerLocation",
            jsonEncode({
              "latitude": dialogBoxController.latitude.value,
              "longitude": dialogBoxController.longitude.value,
            })),
        const MapEntry("District_City", "Hyderabad"),
        MapEntry(
            "stared",
            staredImage.isEmpty
                ? "0"
                : imagePaths.indexOf(staredImage.first).toString()),
      ]);

      // Add image files
      for (int i = 0; i < imagePaths.length; i++) {
        String imagePath = imagePaths[i];
        String fileName = path.basename(imagePath);
        String? mimeType = getMimeType(fileName);

        formData.files.add(MapEntry(
          "AddImage",
          await dio.MultipartFile.fromFile(
            imagePath,
            filename: fileName,
            contentType: mimeType != null ? MediaType.parse(mimeType) : null,
          ),
        ));
      }

      // Send the request
      try {
        isLoading.value = true;
        try {
          isLoading.value = true;
          MessageOTP sellerInprocessResponseModel = await restClient
              .isAlreadyStoreSetup(int.parse(formattedPhoneNumber));

          if (sellerInprocessResponseModel.message ==
              "Mobile number is not registered with any store.") {
            await postdio.setupStrore(formattedPhoneNumber, formData);
            final storeData =
                await restClient.checkStoreId(int.parse(formattedPhoneNumber));
            final storeId = storeData.StoreID;
            isLoading.value = false;
            Get.to(HomeSeller(storeId: storeId));
                Get.snackbar('Success', 'Store setup completed successfully');
          } else {
            // Fluttertoast.showToast(
            //     msg: "Sit Tight! We are setting up your store on Tickk.");
          }
        } catch (e) {
  Logger().e(e);
  if (e is DioException) {
    final response = e.response;
    if (response != null && response.data is Map<String, dynamic>) {
      final errorMessage = response.data['message'] as String?;
      if (errorMessage != null) {
        Get.snackbar('Error', errorMessage);
      } else {
        Get.snackbar('Error', 'An unexpected error occurred try after restarting the app');
      }
    } else {
      Get.snackbar('Error', 'An unexpected error occurred restarting the app');
    }
  } else {
    Get.snackbar('Error', 'An unexpected error occurred restarting the app');
  }
  ProductSetUpController productSetUpController = Get.put(ProductSetUpController());
  productSetUpController.updateButtonState();
}

    
      } catch (e) {
        Logger().d(e);
      }
    } catch (e) {
      Logger().e('Error in setupStrore: $e');
    } finally {
      isLoading.value = false;
    }
    isLoading.value = false;
  }

  String? getMimeType(String fileName) {
    final ext = path.extension(fileName).toLowerCase();
    switch (ext) {
      case '.jpg':
      case '.jpeg':
        return 'image/jpeg';
      case '.png':
        return 'image/png';
      case '.gif':
        return 'image/gif';
      case '.bmp':
        return 'image/bmp';
      case '.webp':
        return 'image/webp';
      default:
        return null;
    }
  }

  Map<String, Map<String, String>> getTimings() {
    return {
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
      },
    };
  }
}
