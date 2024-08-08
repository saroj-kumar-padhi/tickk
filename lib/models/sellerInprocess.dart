class SellerInprocessResponseModel {
  final bool success;
  final List<Data> data;

  SellerInprocessResponseModel({required this.success, required this.data});

  factory SellerInprocessResponseModel.fromJson(Map<String, dynamic> json) {
    return SellerInprocessResponseModel(
      success: json['success'],
      data: List<Data>.from(json['data'].map((item) => Data.fromJson(item))),
    );
  }
}

class Data {
  // final List<String> storeSubSubCategory;
  final bool dealdone;
  final String id;
  final String requirementID;
  final String storeID;
  final String date;
  final String yourName;
  final String storeCategory;
  final String brands;
  final String modelNo;
  final int size;
  final int quantity;
  final String units;
  final String requirementInDetails;
  final String addImage;
  final String location;
  final String status;
  final String quote;
  final bool similar;
  final int v;
  final String storeSubCategory;
  final bool exact;
  final List<dynamic> exactSimilarImage;

  Data(
      {
      // required this.storeSubSubCategory,
      required this.dealdone,
      required this.id,
      required this.requirementID,
      required this.storeID,
      required this.date,
      required this.yourName,
      required this.storeCategory,
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
      required this.similar,
      required this.v,
      required this.storeSubCategory,
      required this.exact,
      required this.exactSimilarImage});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      // storeSubSubCategory: json['storeSubSubCategory'] ?? "",
      dealdone: json['dealdone'] ?? "",
      id: json['_id'] ?? "",
      requirementID: json['RequirementID'] ?? "",
      storeID: json['StoreID'] ?? "",
      date: json['Date'] ?? "", // Use the formatted date
      yourName: json['your_name'] ?? "",
      storeCategory: json['storeCategory'],
      brands: json['Brands'] ?? "",
      modelNo: json['ModelNo'] ?? "",
      size: json['size'] ?? -1,
      quantity: json['Quantity'] ?? -1,
      units: json['Units'] ?? "",
      requirementInDetails: json['Requirement_in_details'] ?? "",
      addImage: json['AddImage'] ?? "",
      location: json['Location'] ?? "",
      status: json['Status'] ?? "",
      quote: json['Quote'] ?? "",
      similar: json['Similar'] ?? "",
      v: json['__v'] ?? "",
      storeSubCategory: json['storeSubCategory'] ?? "",
      exact: json['Exact'] ?? "",
      exactSimilarImage: json["ExactSimilarImage"] ?? "",
    );
  }
}
