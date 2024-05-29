import 'package:get/get.dart';

class ExactController extends GetxController {
  var seletedOption = ''.obs;

  void changeSelectedOption({required String option}) {
    seletedOption.value = option;
  }
}
