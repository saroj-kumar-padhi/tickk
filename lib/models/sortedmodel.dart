class BuyerInprocessResponse {
  final bool success;
  final List<RequirementData> data;
  final List<AllRequirementDetails> allRequirementDetails;

  BuyerInprocessResponse({
    required this.success,
    required this.data,
    required this.allRequirementDetails,
  });

  factory BuyerInprocessResponse.fromJson(Map<String, dynamic> json) {
    return BuyerInprocessResponse(
      success: json['success'],
      data: (json['data'] as List)
          .map((item) => RequirementData.fromJson(item))
          .toList(),
      allRequirementDetails: (json['allRequirementDetails'] as List)
          .map((item) => AllRequirementDetails.fromJson(item))
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
  final DateTime date;
  final String modelNo;
  final int quantity;
  final String brands;
  final String size;
  final String units;
  final String requirementInDetails;
  final List<Store> stores;

  RequirementData({
    required this.requirementID,
    required this.storeCategory,
    required this.storeSubCategory,
    required this.storeSubSubCategory,
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
      storeSubCategory: json['storeSubCategory'],
      storeSubSubCategory: json['storeSubSubCategory'],
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
  final String stared;
  final DateTime date;
  final String quote;
  final bool dealDone;
  final bool similar;
  final bool exact;
  final List<String> exactSimilarImage;

  Store({
    required this.storeName,
    required this.storeID,
    required this.mobile,
    required this.stared,
    required this.date,
    required this.quote,
    required this.dealDone,
    required this.similar,
    required this.exact,
    required this.exactSimilarImage,
  });

  factory Store.fromJson(Map<String, dynamic> json) {
    return Store(
      storeName: json['StoreName'],
      storeID: json['StoreID'],
      mobile: json['mobile'],
      stared: json['stared'],
      date: DateTime.parse(json['Date']),
      quote: json['Quote'],
      dealDone: json['DealDone'],
      similar: json['Similar'],
      exact: json['Exact'],
      exactSimilarImage: List<String>.from(json['ExactSimilarImage']),
    );
  }
}

class AllRequirementDetails {
  final BuyerLocation buyerLocation;
  final String id;
  final int mobile;
  final String requirementID;
  final String storeID;
  final DateTime date;
  final String yourName;
  final String storeCategory;
  final String storeSubCategory;
  final String storeSubSubCategory;
  final String brands;
  final String modelNo;
  final String size;
  final int quantity;
  final String units;
  final String requirementInDetails;
  final String addImage;
  final String location;
  final String status;
  final String quote;
  final bool exact;
  final bool similar;
  final bool yes;
  final bool no;
  final bool accept;
  final bool reject;
  final bool dealDone;
  final String rating;
  final String howDidYouGetThis;
  final List<String> exactSimilarImage;

  AllRequirementDetails({
    required this.buyerLocation,
    required this.id,
    required this.mobile,
    required this.requirementID,
    required this.storeID,
    required this.date,
    required this.yourName,
    required this.storeCategory,
    required this.storeSubCategory,
    required this.storeSubSubCategory,
    required this.brands,
    required this.modelNo,
    required this.size,
    required this.quantity,
    required this.units,
    required this.requirementInDetails,
    required this.addImage,
    required this.location,
    required this.status,
    required this.quote,
    required this.exact,
    required this.similar,
    required this.yes,
    required this.no,
    required this.accept,
    required this.reject,
    required this.dealDone,
    required this.rating,
    required this.howDidYouGetThis,
    required this.exactSimilarImage,
  });

  factory AllRequirementDetails.fromJson(Map<String, dynamic> json) {
    return AllRequirementDetails(
      buyerLocation: BuyerLocation.fromJson(json['buyerLocation']),
      id: json['_id'],
      mobile: json['mobile'],
      requirementID: json['RequirementID'],
      storeID: json['StoreID'],
      date: DateTime.parse(json['Date']),
      yourName: json['your_name'],
      storeCategory: json['storeCategory'],
      storeSubCategory: json['storeSubCategory'],
      storeSubSubCategory: json['storeSubSubCategory'],
      brands: json['Brands'],
      modelNo: json['ModelNo'],
      size: json['size'] ?? 0,
      quantity: json['Quantity'],
      units: json['Units'],
      requirementInDetails: json['Requirement_in_details'],
      addImage: json['AddImage'],
      location: json['Location'],
      status: json['Status'],
      quote: json['Quote'],
      exact: json['Exact'],
      similar: json['Similar'],
      yes: json['Yes'],
      no: json['No'],
      accept: json['Accept'],
      reject: json['Reject'],
      dealDone: json['DealDone'],
      rating: json['Rating'],
      howDidYouGetThis: json['how_did_you_get_this'],
      exactSimilarImage: List<String>.from(json['ExactSimilarImage']),
    );
  }
}

class BuyerLocation {
  final double latitude;
  final double longitude;

  BuyerLocation({
    required this.latitude,
    required this.longitude,
  });

  factory BuyerLocation.fromJson(Map<String, dynamic> json) {
    return BuyerLocation(
      latitude: json['latitude'],
      longitude: json['longitude'],
    );
  }
}
