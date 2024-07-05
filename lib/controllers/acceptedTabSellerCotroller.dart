import 'package:dekhlo/services/injection.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

import '../models/selleracceptedTabModel.dart';

class Acceptedtabsellercotroller extends GetxController {
  RxList<DdItem> acceptedItems = <DdItem>[].obs;
  RxList<DdItem> sentItems = <DdItem>[].obs;
  RxBool isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchAcceptedItems();
  }

  Future<void> fetchAcceptedItems() async {
    try {
      isLoading(true);
      final response = await restClient.acceptedSellerSide('TS15625HP');
      acceptedItems.addAll(response.ddItems);

      // Log detailed information about each item
      for (var item in acceptedItems) {
        sentItems.add(item);
      }

      Logger().d('Total items: ${acceptedItems.length}');
    } catch (e) {
      Logger().e('Error fetching accepted items: $e');
    } finally {
      isLoading(false);
    }
  }
}
