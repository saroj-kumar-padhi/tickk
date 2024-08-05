import 'package:dekhlo/services/injection.dart';
import 'package:get/get.dart';

import '../models/rejectedBySeller.dart';

class RejectedTabController extends GetxController {
  final String storeId;
  RejectedTabController({required this.storeId});
  @override
  Future<void> onInit() async {
    super.onInit();
    // Fetch requirements and store in the list
    await fetchRejectedItems(storeId);
  }

  // refresh action
  Future<void> refreshData() async {
    isLoading.value = true;
    try {
      // Clear existing items
      rejectedItems.clear();
      rejectedItems.clear();

      // Fetch new items
      await fetchRejectedItems(storeId);
    } catch (e) {
      print('Error refreshing data: $e');
    } finally {
      isLoading.value = false;
    }
  }

  RxList<RejectedItem> rejectedItems = <RejectedItem>[].obs;
  RxBool isLoading = false.obs;
  RxString error = ''.obs;

  Future<void> fetchRejectedItems(String storeId) async {
    isLoading.value = true;
    error.value = '';

    try {
      final response = await restClient.rejectedBySeller(storeId);
      rejectedItems.assignAll(response.rejectedItems);
    } catch (e) {
      error.value = 'Failed to fetch rejected items: ${e.toString()}';
    } finally {
      isLoading.value = false;
    }
  }
}
