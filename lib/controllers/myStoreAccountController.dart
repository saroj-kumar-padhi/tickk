import 'package:dekhlo/models/categoriesBased.dart';
import 'package:dekhlo/models/myStoreAcoount.dart';
import 'package:dekhlo/services/injection.dart';
import 'package:get/get.dart';

class Mystoreaccountcontroller extends GetxController {
  Rx<StoreDetails?> storeDetails = Rx<StoreDetails?>(null);
  RxBool isLoading = false.obs;
  RxString error = ''.obs;
  final String storeId;

  Mystoreaccountcontroller({required this.storeId});

  @override
  void onInit() {
    super.onInit();
    fetchStoreDetails(storeId);
  }

  Future<void> fetchStoreDetails(String storeId) async {
    isLoading.value = true;
    error.value = '';

    try {
      final response = await restClient.fetchStoreDetailsByStoreID(storeId);
      storeDetails.value = response;
      isLoading.value = false;
    } catch (e) {
      error.value = 'Failed to fetch store details: ${e.toString()}';
    } finally {
      isLoading.value = false;
    }
  }

  String getCurrentDayTiming() {
    final now = DateTime.now();
    final currentDay = now.weekday;

    String openTime = '';
    String closeTime = '';

    switch (currentDay) {
      case DateTime.monday:
        openTime = mondayOpen;
        closeTime = mondayClose;
        break;
      case DateTime.tuesday:
        openTime = tuesdayOpen;
        closeTime = tuesdayClose;
        break;
      case DateTime.wednesday:
        openTime = wednesdayOpen;
        closeTime = wednesdayClose;
        break;
      case DateTime.thursday:
        openTime = thursdayOpen;
        closeTime = thursdayClose;
        break;
      case DateTime.friday:
        openTime = fridayOpen;
        closeTime = fridayClose;
        break;
      case DateTime.saturday:
        openTime = saturdayOpen;
        closeTime = saturdayClose;
        break;
      case DateTime.sunday:
        openTime = sundayOpen;
        closeTime = sundayClose;
        break;
    }

    if (openTime.isEmpty || closeTime.isEmpty) {
      return "Timing not available";
    }

    return "$openTime - $closeTime";
  }

  bool isCurrentlyOpen() {
    final timing = getCurrentDayTiming();
    if (timing == "Timing not available") return false;

    final times = timing.split(' - ');
    if (times.length != 2) return false;

    final now = DateTime.now();
    final openTime = _parseTime(times[0]);
    final closeTime = _parseTime(times[1]);

    return now.isAfter(openTime) && now.isBefore(closeTime);
  }

  DateTime _parseTime(String time) {
    final now = DateTime.now();

    if (time.isEmpty) {
      return now;
    }

    time = time.replaceAll('"', '');
    final parts = time.toLowerCase().split(RegExp(r'[: ]'));

    if (parts.length < 2) {
      return now;
    }

    int hour;
    int minute;
    try {
      hour = int.parse(parts[0]);
      minute = int.parse(parts[1]);
    } catch (e) {
      print('Error parsing time: $time');
      return now;
    }

    if (parts.length > 2) {
      if (parts[2] == 'pm' && hour != 12) {
        hour += 12;
      } else if (parts[2] == 'am' && hour == 12) {
        hour = 0;
      }
    }

    hour = hour.clamp(0, 23);
    minute = minute.clamp(0, 59);

    return DateTime(now.year, now.month, now.day, hour, minute);
  }

  // Getter methods
  String get storeName => storeDetails.value?.storeName ?? '';
  List get brands => storeDetails.value?.brands ?? [];
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
  String get staredImage => storeDetails.value?.staredImage ?? "";
  List get storeCategory => storeDetails.value?.storeCategory ?? [];
  List get storeSubCategory => storeDetails.value?.storeSubCategory ?? [];
  String get yt => storeDetails.value?.youtubeLink ?? "";
  String get iG => storeDetails.value?.instagarmLink ?? "";
  String get wL => storeDetails.value?.websiteLink ?? "";
  String get houseNoBuildingName => storeDetails.value?.websiteLink ?? "";
  int get pinCode => storeDetails.value?.pincode ?? -1;

  String get streetController => storeDetails.value?.colonyName ?? "";
  String get storeAddress =>
      '${storeDetails.value?.buildingNo ?? ''} ${storeDetails.value?.colonyName ?? ''}, ${storeDetails.value?.landmark ?? ''}, ${storeDetails.value?.pincode ?? ''}';
  List<String> get storeImages => storeDetails.value?.addImage ?? [];
  SellerLocation get sellerLocation =>
      storeDetails.value?.sellerLocation ??
      SellerLocation(latitude: "90.676", longitude: "90.76586");
}
