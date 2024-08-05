import 'package:dekhlo/services/injection.dart';
import 'package:get/get.dart';

import '../models/rejected_buyer.dart';

class RejectedBuyerTabController extends GetxController {
  final String mobileNo;

  RejectedBuyerTabController({required this.mobileNo});
  @override
  Future<void> onInit() async {
    super.onInit();
    // Fetch requirements and store in the list
    await fetchRejectedItems(mobileNo);
  }

  //refresh action
  Future<void> refreshData() async {
    isLoading.value = true;
    try {
      // Clear existing items
      rejectedItems.clear();
      rejectedItems.clear();

      // Fetch new items
      await fetchRejectedItems(mobileNo);
    } catch (e) {
      print('Error refreshing data: $e');
    } finally {
      isLoading.value = false;
    }
  }

  RxList<RejectedItemd> rejectedItems = <RejectedItemd>[].obs;
  RxBool isLoading = false.obs;
  RxString error = ''.obs;

  Future<void> fetchRejectedItems(String mobileNo) async {
    isLoading.value = true;
    error.value = '';

    try {
      final response = await restClient.buyerRejected(mobileNo);
      rejectedItems.assignAll(response);
    } catch (e) {
      error.value = 'Failed to fetch rejected items: ${e.toString()}';
    } finally {
      isLoading.value = false;
    }
  }
}
