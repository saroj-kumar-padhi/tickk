import 'package:dekhlo/services/injection.dart';
import 'package:get/get.dart';
import 'package:logger/web.dart';
import '../models/buyerInprocess.dart';

class Buyerinprocesscontroller extends GetxController {
  // Observable list to store the requirements
  var requirementsList = <Data>[].obs;
  RxBool isLoading = false.obs;
  final String storeId;

  Buyerinprocesscontroller({required this.storeId});

  @override
  Future<void> onInit() async {
    super.onInit();
    // Fetch requirements and store in the list
    await fetchProcessBuyerRequirements(storeId: storeId);
  }

  Future<void> fetchProcessBuyerRequirements({required String storeId}) async {
    isLoading.value = true;
    try {
      // Fetch the requirements from the API
      final BuyerInprocessResponseModel requirementList =
          await restClient.buyerInProcess(storeId);

      // Update the observable list with the fetched requirements
      requirementsList.assignAll(requirementList.data);

      // Log the result (optional)
      Logger().d(requirementList);
    } catch (e) {
      // Log any errors (optional)
      Logger().e('Error fetching requirements: $e');
    }
    isLoading.value = false;
  }
}
