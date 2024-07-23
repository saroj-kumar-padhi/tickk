import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:dio/dio.dart' as dio;
import 'package:http_parser/http_parser.dart' show MediaType;
import 'package:dekhlo/controllers/newTabController.dart';
import 'package:dekhlo/models/genderFetch.dart';
import 'package:dekhlo/services/injection.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:logger/web.dart';

import '../utils/routes/routes_names.dart';

class DropdownController extends GetxController {
  var selectedItem = ''.obs;
  var selectedCategory = ''.obs;
  var selectedSubcategory = ''.obs;
  var selectedSubSubcategory = ''.obs;
  var selectedUnits = ''.obs;
  RxBool isLoading = false.obs;

  NewTabController newTabController = Get.put(NewTabController());

  RxBool issubSet = false.obs;
  RxBool issubsubSet = false.obs;

  RxString selectedGender = ''.obs;
  RxBool isNewImage = false.obs;
  final GenderList = ['Male', 'Female', 'Others'];

  void changeSelectedItem(String newValue) {
    selectedItem.value = newValue;
  }

  void changeSelectedCategory(String newCategory) {
    selectedCategory.value = newCategory;
    selectedItem.value = 'Select a Subcategory';
    selectedSubcategory.value = 'Select a Subcategory';
  }

  void changeSelectedSubcategory(String newSubcategory) {
    selectedSubcategory.value = newSubcategory;
  }

  void changeSelectedSubSubcategory(String newSubSubcategory) {
    selectedSubSubcategory.value = newSubSubcategory;
  }

  Future<void> postRequirements({
    required final String name,
    required final String units,
    required final String category,
    required final String subcategory,
    required final String subsubCategory,
    required final String brand,
    required final String modelNo,
    required final int quote,
    required final String size,
    required final int quantity,
    required final String details,
    required final String image,
  }) async {
    try {
      isLoading.value = true;
      String subSub = subsubCategory.isEmpty ? "Not available" : subsubCategory;

      String? fcmToken = await FirebaseMessaging.instance.getToken();
      final box = Hive.box('myBox');
      final String formattedPhoneNumber = box.get('phone');

      var formData = dio.FormData.fromMap({
        "mobile": formattedPhoneNumber,
        "your_name": name,
        "storeCategory": category,
        "storeSubCategory": subcategory,
        "storeSubSubCategory": subSub,
        "Brands": brand,
        "ModelNo": modelNo,
        "Quote": quote.toString(),
        "size": size.toString(),
        "Quantity": quantity.toString(),
        "Units": units,
        "Requirement_in_details": details,
        "Location": "N/A",
        "Status": "Neutral",
        "deletebutton": "Neutral",
        "FCM": fcmToken ?? ""
      });

      if (image.isNotEmpty) {
        File file = File(image);
        String fileName = path.basename(file.path);
        String? mimeType = getMimeType(fileName);

        formData.files.add(MapEntry(
          "image",
          await dio.MultipartFile.fromFile(
            file.path,
            filename: fileName,
            contentType: mimeType != null ? MediaType.parse(mimeType) : null,
          ),
        ));
      }

      await postdio.postRequirements(formData);

      Fluttertoast.showToast(msg: "Thanks Your requirements sent successfully");
      newTabController.fetchRequirements();
      Get.toNamed(RouteName.homeBuyerScreen);
    } catch (e) {
      Logger().d(e);
      Fluttertoast.showToast(msg: e.toString());
    } finally {
      isLoading.value = false;
    }
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
}
