import 'package:intl/intl.dart';

class DealDone {
  List<DdItem> ddItems;

  DealDone({
    required this.ddItems,
  });

  factory DealDone.fromJson(Map<String, dynamic> json) {
    var ddItemsList = json['DDItems'] as List;
    List<DdItem> ddItemsObjects =
        ddItemsList.map((itemJson) => DdItem.fromJson(itemJson)).toList();

    return DealDone(
      ddItems: ddItemsObjects,
    );
  }
}

class DdItem {
  List<dynamic> exactSimilarImage;
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
  String size;
  int quantity;
  String units;
  String requirementInDetails;
  String addImage;
  String location;
  String status;
  String quote;
  bool exact;
  bool similar;
  bool yes;
  bool no;
  bool accept;
  bool reject;
  bool dealDone;
  String rating;
  int v;
  String description;
  String howDidYouGetThis;
  List<dynamic> exactImgages;

  DdItem(
      {required this.exactSimilarImage,
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
      required this.v,
      required this.description,
      required this.howDidYouGetThis,
      required this.exactImgages});

  factory DdItem.fromJson(Map<String, dynamic> json) {
    return DdItem(
      exactSimilarImage: json['ExactSimilarImage'] ?? [],
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
      size: json['size'] ?? "",
      quantity: json['Quantity'] ?? 0,
      units: json['Units'] ?? '',
      requirementInDetails: json['Requirement_in_details'] ?? '',
      addImage: json['AddImage'] ?? '',
      location: json['Location'] ?? '',
      status: json['Status'] ?? '',
      quote: json['Quote'] ?? "",
      exact: json['Exact'] ?? false,
      similar: json['Similar'] ?? false,
      yes: json['Yes'] ?? false,
      no: json['No'] ?? false,
      accept: json['Accept'] ?? false,
      reject: json['Reject'] ?? false,
      dealDone: json['DealDone'] ?? false,
      rating: json['Rating'] ?? '',
      v: json['__v'] ?? 0,
      description: json['description'] ?? '',
      howDidYouGetThis: json['how_did_you_get_this'] ?? '',
      exactImgages: json['ExactSimilarImage'] ?? [],
    );
  }
}
