class MatchingStoresResponse {
  final List<MatchingStore> matchingStores;

  MatchingStoresResponse({required this.matchingStores});

  factory MatchingStoresResponse.fromJson(Map<String, dynamic> json) {
    return MatchingStoresResponse(
      matchingStores: (json['matchingStores'] as List<dynamic>)
          .map((storeJson) => MatchingStore.fromJson(storeJson))
          .toList(),
    );
  }
}

class MatchingStore {
  final String storeID;
  final String sellerMobile;
  final String fcm;

  MatchingStore({
    required this.storeID,
    required this.sellerMobile,
    required this.fcm,
  });

  factory MatchingStore.fromJson(Map<String, dynamic> json) {
    return MatchingStore(
      storeID: json['StoreID'],
      sellerMobile: json['SellerMobile'],
      fcm: json['FCM'],
    );
  }
}
