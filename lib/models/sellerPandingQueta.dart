class SellerPandingResponseModel {
  final bool success;
  final List<Data> data;

  SellerPandingResponseModel({required this.success, required this.data});

  factory SellerPandingResponseModel.fromJson(Map<String, dynamic> json) {
    return SellerPandingResponseModel(
      success: json['success'],
      data: List<Data>.from(json['data'].map((item) => Data.fromJson(item))),
    );
  }
}

class Data {
  final bool exact;
  final String id;
  final String requirementID;
  final String storeID;
  final DateTime date;
  final String yourName;
  final List<String> storeCategory;
  final List<String> storeSubCategory;
  final List<String> storeSubSubCategory;
  final String brands;
  final String modelNo;
  final int size;
  final int quantity;
  final String units;
  final String requirementInDetails;
  final String addImage;
  final String location;
  final String status;
  final int quote;
  final bool extract;
  final bool similar;
  final int v;

  Data({
    required this.exact,
    required this.id,
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
    required this.extract,
    required this.similar,
    required this.v,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      exact: json['Exact'],
      id: json['_id'],
      requirementID: json['RequirementID'],
      storeID: json['StoreID'],
      date: DateTime.parse(json['Date']),
      yourName: json['your_name'],
      storeCategory: List<String>.from(json['storeCategory']),
      storeSubCategory: List<String>.from(json['storeSubCategory']),
      storeSubSubCategory: List<String>.from(json['storeSubSubCategory']),
      brands: json['Brands'],
      modelNo: json['ModelNo'],
      size: json['size'],
      quantity: json['Quantity'],
      units: json['Units'],
      requirementInDetails: json['Requirement_in_details'],
      addImage: json['AddImage'],
      location: json['Location'],
      status: json['Status'],
      quote: json['Quote'],
      extract: json['Extract'],
      similar: json['Similar'],
      v: json['__v'],
    );
  }
}
