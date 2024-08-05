import 'package:dekhlo/models/sellerDealDone.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:dekhlo/services/injection.dart';

class Dealdonesellercontroller extends GetxController {
  RxList<DdItem> dealDoneItems = <DdItem>[].obs;
  RxList<DdItem> processedItems = <DdItem>[].obs;
  RxBool isLoading = true.obs;
  final String StoreId;

  Dealdonesellercontroller({required this.StoreId});

  @override
  void onInit() {
    super.onInit();
    fetchDealDoneItems();
  }

  // refresh action
  Future<void> refreshData() async {
    isLoading.value = true;
    try {
      // Clear existing items
      dealDoneItems.clear();
      processedItems.clear();

      // Fetch new items
      await fetchDealDoneItems();
    } catch (e) {
      print('Error refreshing data: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchDealDoneItems() async {
    try {
      isLoading(true);
      final response = await restClient.dealDoneSellerSide(
          StoreId); // Assuming this method exists in your restClient

      dealDoneItems.addAll(response.ddItems);

      // Process and add each item to processedItems
      for (var item in dealDoneItems) {
        processedItems.add(item);
      }

      Logger().d('Total deal done items: ${dealDoneItems.length}');

      // Log detailed information about each item
    } catch (e) {
      Logger().e('Error fetching deal done items: $e');
    } finally {
      isLoading(false);
    }
  }
}
