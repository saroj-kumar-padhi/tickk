import 'package:get/get.dart';

class DeleteReasonController extends GetxController {
  var seletedOption = 'Too many bugs'.obs;
  var otherReason = ''.obs;

  void changeSelectedOption({required String option}) {
    seletedOption.value = option;
  }

  String getSelectedReason() {
    if (seletedOption.value == 'Something else') {
      return otherReason.value.isEmpty
          ? 'Something else (no description provided)'
          : otherReason.value;
    }
    return seletedOption.value;
  }
}
