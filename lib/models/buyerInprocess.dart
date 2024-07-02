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
  final int size;
  final String units;
  final String requirementInDetails;
  final List<Store> stores;

  RequirementData({
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
      requirementID: json['RequirementID'],
      storeCategory: json['storeCategory'],
      storeSubCategory: json['storeSubCategory'],
      storeSubSubCategory: json['storeSubSubCategory'],
      addImage: json['AddImage'],
      modelNo: json['ModelNo'],
      quantity: json['Quantity'],
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
  final String addImage;
  final int quote;
  final bool similar;
  final bool exact;
  final String? totalDiatance;

  Store(
      {required this.storeName,
      required this.storeID,
      required this.addImage,
      required this.quote,
      required this.similar,
      required this.exact,
      this.totalDiatance});

  factory Store.fromJson(Map<String, dynamic> json) {
    return Store(
      storeName: json['StoreName'],
      storeID: json['StoreID'],
      addImage: json['AddImage'],
      quote: json['Quote'],
      similar: json['Similar'],
      exact: json['Exact'],
      totalDiatance: json['TotalDistance'] != null
          ? json['TotalDistance'].toString()
          : "0",
    );
  }
}
