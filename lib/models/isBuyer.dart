class BuyerResponse {
  final bool success;
  final String message;

  BuyerResponse({required this.success, required this.message});

  factory BuyerResponse.fromJson(Map<String, dynamic> json) {
    return BuyerResponse(
      success: json['success'],
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
