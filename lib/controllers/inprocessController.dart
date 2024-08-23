import 'package:dekhlo/services/injection.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class InProcessController extends GetxController {
  RxList index = [].obs;
  Rx<DocumentResponse?> documentResponse = Rx<DocumentResponse?>(null);
  RxMap<String, DocumentResponse> documentResponses =
      <String, DocumentResponse>{}.obs;

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

  Future<void> fetchIsAccepted(
      {required String reqId, required String storeId}) async {
    // Only fetch if we haven't already for this store
    if (!documentResponses.containsKey(reqId)) {
      try {
        final response = await restClient.knowIsAccepeted(reqId, storeId);
        documentResponses[reqId] = response;
      } catch (e) {
        Fluttertoast.showToast(msg: "$e");
      }
    }
  }
}

class DocumentResponse {
  final String message;

  DocumentResponse({required this.message});

  factory DocumentResponse.fromJson(Map<String, dynamic> json) {
    return DocumentResponse(
      message: json['message'],
    );
  }
}
