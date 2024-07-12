import 'package:dekhlo/models/reviewModel.dart';
import 'package:dekhlo/services/injection.dart';
import 'package:get/get.dart';

class Reviewscontrollers extends GetxController {
  RxList<Review> reviews = <Review>[].obs;
  RxBool isLoading = false.obs;
  RxString error = ''.obs;
  final String storeId;

  Reviewscontrollers(this.storeId);

  @override
  void onInit() {
    super.onInit();
    fetchReviews(storeId);
  }

  Future<void> fetchReviews(String storeID) async {
    try {
      isLoading.value = true;
      error.value = '';

      final response = await restClient.getPostedReviewByUsers(storeID);

      reviews.addAll(response);
      isLoading.value = false;
    } catch (e) {
      error.value = 'Failed to fetch reviews: $e';
    } finally {
      isLoading.value = false;
    }
  }
}
