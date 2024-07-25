class BuyerResponse {
  final String message;

  BuyerResponse({required this.message});

  factory BuyerResponse.fromJson(Map<String, dynamic> json) {
    return BuyerResponse(
      message: json['message'],
    );
  }
}

class StoreIDbyMobile {
  final String StoreID;

  StoreIDbyMobile({required this.StoreID});

  factory StoreIDbyMobile.fromJson(dynamic json) {
    return StoreIDbyMobile(StoreID: json['StoreID']);
  }
}
