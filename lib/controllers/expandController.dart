import 'package:get/get.dart';

class ExpandController extends GetxController {
  RxBool isExpanded = false.obs;
  RxList<bool> expandedList = List<bool>.filled(100, false).obs;
}
