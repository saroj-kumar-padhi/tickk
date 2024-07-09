import 'package:get/get.dart';

class FlavourContoler extends GetxController {
  RxBool isBoth = false.obs;
  RxBool isBuying = false.obs;

  Map<String, String> categoryData = {
    "Medicine": "assest/medicine.svg",
    "Pets": "assest/pets.svg",
    "Books": "assest/book.svg",
    "Fashion": "",
    "Construction": "assest/consruction.svg",
    "Home Decor": "assest/homeDecoder.svg"
  };
}
