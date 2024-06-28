class BuyerDealDoneResponse {
  final bool success;
  final List<RequirementData> data;

  BuyerDealDoneResponse({
    required this.success,
    required this.data,
  });

  factory BuyerDealDoneResponse.fromJson(Map<String, dynamic> json) {
    return BuyerDealDoneResponse(
      success: json['success'],
      data: (json['data'] as List)
          .map((item) => RequirementData.fromJson(item))
          .toList(),
    );
  }
}

class RequirementData {
  final String requirementID;
  final String storeCategory;
  final String addImage;
  final DateTime date;
  final String modelNo;
  final int quantity;
  final String brands;
  final int size;
  final String units;
  final String requirementInDetails;
  final List<Store> stores;

  RequirementData({
    required this.requirementID,
    required this.storeCategory,
    required this.addImage,
    required this.date,
    required this.modelNo,
    required this.quantity,
    required this.brands,
    required this.size,
    required this.units,
    required this.requirementInDetails,
    required this.stores,
  });

  factory RequirementData.fromJson(Map<String, dynamic> json) {
    return RequirementData(
      requirementID: json['RequirementID'],
      storeCategory: json['storeCategory'],
      addImage: json['AddImage'],
      date: DateTime.parse(json['Date']),
      modelNo: json['ModelNo'],
      quantity: json['Quantity'],
      brands: json['Brands'],
      size: json['size'],
      units: json['Units'],
      requirementInDetails: json['Requirement_in_details'],
      stores:
          (json['stores'] as List).map((item) => Store.fromJson(item)).toList(),
    );
  }
}

class Store {
  final String storeName;
  final String storeID;
  final String mobile;
  final String addImage;
  final String location;

  Store({
    required this.storeName,
    required this.storeID,
    required this.mobile,
    required this.addImage,
    required this.location,
  });

  factory Store.fromJson(Map<String, dynamic> json) {
    return Store(
      storeName: json['StoreName'],
      storeID: json['StoreID'],
      mobile: json['mobile'],
      addImage: json['AddImage'],
      location: json['Location'],
    );
  }
}
