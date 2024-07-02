import 'package:dekhlo/models/myStoreAcoount.dart';
import 'package:dekhlo/services/injection.dart';
import 'package:get/get.dart';

class Mystoreaccountcontroller extends GetxController {
  Rx<StoreDetails?> storeDetails = Rx<StoreDetails?>(null);
  RxBool isLoading = false.obs;
  RxString error = ''.obs;

  Future<void> fetchStoreDetails(String storeId) async {
    isLoading.value = true;
    error.value = '';

    try {
      final response =
          await restClient.fetchStoreDetailsByStoreID("TS156236HP");
      storeDetails.value = response;
    } catch (e) {
      error.value = 'Failed to fetch store details: ${e.toString()}';
    } finally {
      isLoading.value = false;
    }
  }

  // Getter methods for easy access to store details
  String get storeName => storeDetails.value?.storeName ?? '';
  List<String> get storeCategories => storeDetails.value?.storeCategory ?? [];
  String get storeAddress =>
      '${storeDetails.value?.buildingNo ?? ''} ${storeDetails.value?.colonyName ?? ''}, ${storeDetails.value?.landmark ?? ''}, ${storeDetails.value?.pincode ?? ''}';

  // Add more getter methods as needed
}
