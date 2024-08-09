import 'package:dekhlo/services/injection.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

import '../models/selleracceptedTabModel.dart';

class Acceptedtabsellercotroller extends GetxController {
  RxList<DdItem> acceptedItems = <DdItem>[].obs;
  RxList<DdItem> sentItems = <DdItem>[].obs;
  RxBool isLoading = true.obs;
  final String storeId;

  Acceptedtabsellercotroller(this.storeId);

  @override
  void onInit() {
    super.onInit();
    fetchAcceptedItems();
  }

//refresh action
  Future<void> refreshData() async {
    try {
      isLoading.value = true;
      await fetchAcceptedItems();
    } catch (e) {
      print('Error refreshing data: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchAcceptedItems() async {
    try {
      isLoading(true);
      final response = await restClient.acceptedSellerSide(storeId);

      // Clear the list before adding new items
      acceptedItems.clear();
      acceptedItems.addAll(response.ddItems);

      // Clear and update sentItems as well
      sentItems.clear();
      sentItems.addAll(response.ddItems);

      Logger().d('Total items: ${acceptedItems.length}');
    } catch (e) {
      Logger().e('Error fetching accepted items: $e');
    } finally {
      isLoading(false);
    }
  }
}
