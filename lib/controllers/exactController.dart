import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExactController extends GetxController {
  var seletedOption = ''.obs;
  RxBool toShow = false.obs;
  RxBool isExact = false.obs;
  TextEditingController quoteEditingController = TextEditingController();

  void changeSelectedOption({required String option}) {
    seletedOption.value = option;
  }
}
