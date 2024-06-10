import 'package:dekhlo/services/injection.dart';
import 'package:get/get.dart';
import 'package:logger/web.dart';
import '../models/newRequrements.dart';

class NewTabController extends GetxController {
  // Observable list to store the requirements
  var requirementsList = <Requirement>[].obs;
  RxBool isLoading = false.obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    // Fetch requirements and store in the list
    await fetchRequirements();
  }

  Future<void> fetchRequirements() async {
    isLoading.value = true;
    try {
      // Fetch the requirements from the API
      final RequirementList requirementList =
          await restClient.getRequirements(6280644889);

      // Update the observable list with the fetched requirements
      requirementsList.assignAll(requirementList.requirements);

      // Log the result (optional)
      Logger().d(requirementList);
    } catch (e) {
      // Log any errors (optional)
      Logger().e('Error fetching requirements: $e');
    }
    isLoading.value = false;
  }
}
