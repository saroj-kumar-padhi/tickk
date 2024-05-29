import 'package:get/get.dart';

class DeleteReasonController extends GetxController {
  var seletedOption = 'Too many bugs'.obs;

  void changeSelectedOption({required String option}) {
    seletedOption.value = option;
  }
}
