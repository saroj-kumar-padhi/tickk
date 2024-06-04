import 'package:get/get.dart';

class MyStoreCarouselController extends GetxController {
  var currentIndex = 0.obs;

  void updateIndex(int index) {
    currentIndex.value = index;
  }
}
