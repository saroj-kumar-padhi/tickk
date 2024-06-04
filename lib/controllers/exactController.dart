import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExactController extends GetxController {
  var seletedOption = ''.obs;
  RxBool toShow = false.obs;
  RxBool isExact = false.obs;
  RxBool isSeller = false.obs;
  RxBool quteEnable = false.obs;
  TextEditingController quoteEditingController = TextEditingController();

  void changeSelectedOption({required String option}) {
    seletedOption.value = option;
  }

  void changeQuteOption({required bool option}) {
    quteEnable.value = option;
  }
}
