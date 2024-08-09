import 'package:dekhlo/models/rating_response.dart';
import 'package:dekhlo/models/reviewModel.dart';
import 'package:dekhlo/services/injection.dart';
import 'package:get/get.dart';
import 'package:logger/web.dart';

class Reviewscontrollers extends GetxController {
  RxList<Review> reviews = <Review>[].obs;
  RxBool isLoading = false.obs;
  RxString error = ''.obs;
  final String storeId;
  RatingResponse ratingResponse =
      RatingResponse(averageRating: 0.0, ratingCount: 0);

  Reviewscontrollers(this.storeId);

  @override
  void onInit() {
    super.onInit();
    fetchReviews(storeId);
    totalRating(storeId);
  }

  Future<void> totalRating(String storeID) async {
    try {
      ratingResponse = await restClient.getStoreRating(storeId);
    } catch (e) {
      Logger().d(e);
    }
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
