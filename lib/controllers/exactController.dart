import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExactController extends GetxController {
  RxList<String> items = <String>[].obs;
  var seletedOption = ''.obs;
  RxBool toShow = false.obs;
  RxBool isExact = false.obs;
  RxBool isSeller = false.obs;
  RxBool quteEnable = false.obs;
  TextEditingController quoteEditingController = TextEditingController();

  ExactController() {
    // Initialize the list with ListItem objects having empty strings
    items.addAll(List.generate(100, (index) => ''));
  }

  void changeSelectedOption({required String option, required int index}) {
    items[index] = option;
  }

  void changeQuteOption({required bool option}) {
    quteEnable.value = option;
  }
}

class ListItem {
  String title;

  ListItem({
    required this.title,
  });
}
