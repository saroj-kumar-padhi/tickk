import 'package:dekhlo/services/injection.dart';
import 'package:get/get.dart';
import 'package:logger/web.dart';

import '../models/sellerNewModel.dart';

class HomeSellerController extends GetxController {
  RxList<Data> sellerDataList = <Data>[].obs;
  RxBool isLoading = false.obs;
  final String storeId;

  // Constructor with storeId as a parameter
  HomeSellerController(this.storeId);

  @override
  void onInit() {
    super.onInit();
    fetchSellerData(storeId);
  }

  //refresh action
  Future<void> refreshData() async {
    isLoading.value = true;
    try {
      // Clear existing items
      sellerDataList.clear();
      sellerDataList.clear();

      // Fetch new items
      await fetchSellerData(storeId);
    } catch (e) {
      print('Error refreshing data: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchSellerData(String storeId) async {
    sellerDataList.clear();
    try {
      isLoading.value = true;
      dynamic response = await restClient.fetchNewSeller(storeId);
      sellerDataList.value = response.data;
      sellerDataList.value = sellerDataList.toList();
      isLoading.value = false;
    } catch (e) {
      // Handle error
      isLoading.value = true;
      Logger().d(e);
      isLoading.value = false;
    }
  }
}
