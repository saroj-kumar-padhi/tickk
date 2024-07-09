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
