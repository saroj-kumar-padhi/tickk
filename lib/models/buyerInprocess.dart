class BuyerInprossModel {
  final bool success;
  final List<RequirementData> data;

  BuyerInprossModel({
    required this.success,
    required this.data,
  });

  factory BuyerInprossModel.fromJson(Map<String, dynamic> json) {
    return BuyerInprossModel(
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
  final String storeSubCategory;
  final String storeSubSubCategory;
  final String addImage;
  final String modelNo;
  final int quantity;
  final String size;
  final String units;
  final String Date;
  final String requirementInDetails;
  final List<Store> stores;

  RequirementData({
    required this.Date,
    required this.requirementID,
    required this.storeCategory,
    required this.storeSubCategory,
    required this.storeSubSubCategory,
    required this.addImage,
    required this.modelNo,
    required this.quantity,
    required this.size,
    required this.units,
    required this.requirementInDetails,
    required this.stores,
  });

  factory RequirementData.fromJson(Map<String, dynamic> json) {
    return RequirementData(
      requirementID: json['RequirementID'] ?? "",
      storeCategory: json['storeCategory'] ?? "",
      storeSubCategory: json['storeSubCategory'] ?? "",
      storeSubSubCategory: json['storeSubSubCategory'] ?? "",
      addImage: json['AddImage'] ?? "",
      modelNo: json['ModelNo'] ?? "",
      quantity: json['Quantity'] ?? -1,
      size: json['size'] ?? "",
      units: json['Units'] ?? "",
      requirementInDetails: json['Requirement_in_details'] ?? "",
      stores:
          (json['stores'] as List).map((item) => Store.fromJson(item)).toList(),
      Date: json['Date'],
    );
  }
}

class Store {
  final String storeName;
  final String storeID;
  final String mobile;
  final String addImage;
  final String quote;
  final bool similar;
  final List<dynamic> ExactSimilarImage;
  final String stared;
  final bool exact;
  final String? totalDiatance;

  Store(
      {required this.storeName,
      required this.storeID,
      required this.mobile,
      required this.addImage,
      required this.quote,
      required this.similar,
      required this.exact,
      required this.totalDiatance,
      required this.ExactSimilarImage,
      required this.stared});

  factory Store.fromJson(Map<String, dynamic> json) {
    return Store(
      storeName: json['StoreName'] ?? "",
      storeID: json['StoreID'] ?? "",
      addImage: json['stared'] ?? "",
      quote: json['Quote'] ?? -1,
      similar: json['Similar'] ?? false,
      exact: json['Exact'] ?? false,
      totalDiatance: json['TotalDistance'] != null
          ? json['TotalDistance'].toString()
          : "0",
      mobile: json['mobile'] ?? "",
      ExactSimilarImage: json['ExactSimilarImage'] ?? [],
      stared: json['stared'] ?? "",
    );
  }
}
