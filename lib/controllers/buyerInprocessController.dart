import 'package:dekhlo/models/buyerInprocess.dart';
import 'package:dekhlo/services/injection.dart';
import 'package:get/get.dart';
import 'package:logger/web.dart';

class Buyerinprocesscontroller extends GetxController {
  // Observable list to store the requirements
  var requirementsList = <RequirementData>[].obs;
  RxBool isLoading = false.obs;
  final String mobileNo;

  Buyerinprocesscontroller({required this.mobileNo});

  @override
  Future<void> onInit() async {
    super.onInit();
    // Fetch requirements and store in the list
    await fetchProcessBuyerRequirements(mobileNo: mobileNo);
  }

  Future<void> fetchProcessBuyerRequirements({required String mobileNo}) async {
    isLoading.value = true;
    try {
      // Fetch the requirements from the API
      final BuyerInprossModel requirementList =
          await restClient.buyerInProcess(mobileNo);

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