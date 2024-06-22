import 'package:dekhlo/services/injection.dart';
import 'package:get/get.dart';
import 'package:logger/web.dart';
import '../models/sellerPandingQueta.dart';

class Sellerpandingcontroller extends GetxController {
  // Observable list to store the requirements
  var requirementsList = <Data>[].obs;
  RxBool isLoading = false.obs;
  final String storeId;

  Sellerpandingcontroller({required this.storeId});

  @override
  Future<void> onInit() async {
    super.onInit();
    // Fetch requirements and store in the list
    await fetchPandingSellerRequirements(storeId: storeId);
  }

  Future<void> fetchPandingSellerRequirements({required String storeId}) async {
    isLoading.value = true;
    try {
      // Fetch the requirements from the API
      final SellerPandingResponseModel requirementList =
          await restClient.fetchPandingResponseSeller(storeId);

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
