import 'package:intl/intl.dart';

class AcceptSeller {
  List<DdItem> ddItems;

  AcceptSeller({
    required this.ddItems,
  });

  factory AcceptSeller.fromJson(Map<String, dynamic> json) {
    var ddItemsList = json['DDItems'] as List;
    List<DdItem> ddItemsObjects =
        ddItemsList.map((itemJson) => DdItem.fromJson(itemJson)).toList();

    return AcceptSeller(
      ddItems: ddItemsObjects,
    );
  }
}

class DdItem {
  bool exact;
  bool similar;
  String id;
  String requirementId;
  String storeId;
  DateTime date;
  String yourName;
  String storeCategory;
  String storeSubCategory;
  String storeSubSubCategory;
  String brands;
  String modelNo;
  String quote;
  int size;
  int quantity;
  String units;
  String requirementInDetails;
  String addImage;
  String location;
  String status;
  List<dynamic> exactSimilarImage;
  int v;

  DdItem({
    required this.exact,
    required this.exactSimilarImage,
    required this.similar,
    required this.id,
    required this.requirementId,
    required this.storeId,
    required this.date,
    required this.yourName,
    required this.storeCategory,
    required this.storeSubCategory,
    required this.storeSubSubCategory,
    required this.brands,
    required this.modelNo,
    required this.quote,
    required this.size,
    required this.quantity,
    required this.units,
    required this.requirementInDetails,
    required this.addImage,
    required this.location,
    required this.status,
    required this.v,
  });

  factory DdItem.fromJson(Map<String, dynamic> json) {
    return DdItem(
      exactSimilarImage: json['ExactSimilarImage'] ?? [],
      exact: json['Exact'] ?? false,
      similar: json['Similar'] ?? false,
      id: json['_id'] ?? '',
      requirementId: json['RequirementID'] ?? '',
      storeId: json['StoreID'] ?? '',
      date: DateTime.tryParse(json['Date'] ?? '') ?? DateTime.now(),
      yourName: json['your_name'] ?? '',
      storeCategory: json['storeCategory'] ?? '',
      storeSubCategory: json['storeSubCategory'] ?? '',
      storeSubSubCategory: json['storeSubSubCategory'] ?? '',
      brands: json['Brands'] ?? '',
      modelNo: json['ModelNo'] ?? '',
      quote: json['Quote']?.toString() ?? '0',
      size: json['size'] ?? 0,
      quantity: json['Quantity'] ?? 0,
      units: json['Units'] ?? '',
      requirementInDetails: json['Requirement_in_details'] ?? '',
      addImage: json['AddImage'] ?? '',
      location: json['Location'] ?? '',
      status: json['Status'] ?? '',
      v: json['__v'] ?? 0,
    );
  }
}
