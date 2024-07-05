import 'package:dekhlo/models/myStoreAcoount.dart';
import 'package:dekhlo/services/injection.dart';
import 'package:get/get.dart';

class Mystoreaccountcontroller extends GetxController {
  Rx<StoreDetails?> storeDetails = Rx<StoreDetails?>(null);
  RxBool isLoading = false.obs;
  RxString error = ''.obs;

  Future<void> fetchStoreDetails(String storeId) async {
    isLoading.value = true;
    error.value = '';

    try {
      final response =
          await restClient.fetchStoreDetailsByStoreID("TS156236HP");
      storeDetails.value = response;
    } catch (e) {
      error.value = 'Failed to fetch store details: ${e.toString()}';
    } finally {
      isLoading.value = false;
    }
  }

  // Getter methods for easy access to store details
  String get storeName => storeDetails.value?.storeName ?? '';
  String get about => storeDetails.value?.aboutTheStore ?? '';
  String get mobile => storeDetails.value?.mobile ?? '';
  String get mondayOpen => storeDetails.value?.timings.monday.open ?? "";
  String get mondayClose => storeDetails.value?.timings.monday.close ?? "";

  String get tuesdayOpen => storeDetails.value?.timings.tuesday.open ?? "";
  String get tuesdayClose => storeDetails.value?.timings.tuesday.close ?? "";

  String get wednesdayOpen => storeDetails.value?.timings.wednesday.open ?? "";
  String get wednesdayClose =>
      storeDetails.value?.timings.wednesday.close ?? "";

  String get thursdayOpen => storeDetails.value?.timings.thursday.open ?? "";
  String get thursdayClose => storeDetails.value?.timings.thursday.close ?? "";

  String get fridayOpen => storeDetails.value?.timings.friday.open ?? "";
  String get fridayClose => storeDetails.value?.timings.friday.close ?? "";

  String get saturdayOpen => storeDetails.value?.timings.saturday.open ?? "";
  String get saturdayClose => storeDetails.value?.timings.saturday.close ?? "";

  String get sundayOpen => storeDetails.value?.timings.sunday.open ?? "";
  String get sundayClose => storeDetails.value?.timings.sunday.close ?? "";
  List<String> get storeCategories => storeDetails.value?.storeCategory ?? [];

  String get storeAddress =>
      '${storeDetails.value?.buildingNo ?? ''} ${storeDetails.value?.colonyName ?? ''}, ${storeDetails.value?.landmark ?? ''}, ${storeDetails.value?.pincode ?? ''}';

  // Add more getter methods as needed
}
