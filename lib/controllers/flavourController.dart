import 'package:dekhlo/services/injection.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class FlavourContoler extends GetxController {
  RxBool isBoth = false.obs;
  RxBool isBuying = false.obs;
  StoreName comapamyName = StoreName(storeName: "Yours Store");
  final String storeID;
  RxBool isLoading = false.obs;

  FlavourContoler({required this.storeID});

  @override
  void onInit() {
    super.onInit();
    fetchStoreName(storeId: storeID);
  }

  Future<void> fetchStoreName({required String storeId}) async {
    try {
      isLoading.value = true;
      comapamyName = await restClient.getStoreNameById(storeId);
      Logger().d(comapamyName.storeName);
      isLoading.value = false;
    } catch (e) {
      Logger().d(e);
    } finally {
      isLoading.value = false;
    }
  }

  Map<String, String> categoryData = {
    "Medical": "assest/medicine.svg",
    "Pet stores": "assest/pets.svg",
    "Fashion": "assest/cloths.svg",
    "Construction": "assest/consruction.svg",
    "Home decor": "assest/home_dec.svg",
    "Electronics": "assest/electronics.svg",
    "Electricals": "assest/plug.svg",
    "Nursery": "assest/flower.svg",
    "Toys": "assest/to.svg",
    "Gifts": "assest/gift.svg",
    "Sports": "assest/sports.svg",
    "Books & Stationery": "assest/book.svg",
  };
}

class StoreName {
  final String storeName;

  StoreName({required this.storeName});

  // Factory method to create an instance from JSON
  factory StoreName.fromJson(Map<String, dynamic> json) {
    return StoreName(
      storeName: json['StoreName'],
    );
  }
}
