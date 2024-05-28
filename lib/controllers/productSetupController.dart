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
  final TextEditingController openTimeEditingController = TextEditingController(
      text:
          '${DateTime.now().hour.toString().padLeft(2, '0')}:${DateTime.now().minute.toString().padLeft(2, '0')}');

  final TextEditingController closeEditingController = TextEditingController(
      text:
          '${DateTime.now().hour.toString().padLeft(2, '0')}:${DateTime.now().minute.toString().padLeft(2, '0')}');
  final TextEditingController buildingController = TextEditingController();
  final TextEditingController pinCodeController = TextEditingController();
  final TextEditingController colonyController = TextEditingController();
  final TextEditingController landMarkController = TextEditingController();
  final TextEditingController locationController = TextEditingController();

  List<String> dayList = ["S", "M", "T", "W", "T", "F", "S"];
  RxList<int> selectedIndices =
      <int>[].obs; // Reactive list for selected indices

  void toggleSelection(int index) {
    if (selectedIndices.contains(index)) {
      selectedIndices.remove(index);
    } else {
      selectedIndices.add(index);
    }
  }
}
