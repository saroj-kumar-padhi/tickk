import 'package:dekhlo/services/injection.dart';
import 'package:get/get.dart';

class InProcessController extends GetxController {
  RxList index = [].obs;

  Future<Map<String, dynamic>> fetchStoreRating(String storeId) async {
    try {
      final response = await restClient.getStoreRating(storeId);
      return {
        'averageRating': response.averageRating,
        'ratingCount': response.ratingCount
      };
    } catch (e) {
      print('Error fetching store rating: $e');
      return {'averageRating': 0, 'ratingCount': 0};
    }
  }
}
