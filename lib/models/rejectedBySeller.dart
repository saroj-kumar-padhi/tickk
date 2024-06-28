class RejectedItemsResponse {
  List<RejectedItem> rejectedItems;

  RejectedItemsResponse({required this.rejectedItems});

  factory RejectedItemsResponse.fromJson(Map<String, dynamic> json) {
    return RejectedItemsResponse(
      rejectedItems: (json['rejectedItems'] as List)
          .map((item) => RejectedItem.fromJson(item))
          .toList(),
    );
  }
}

class RejectedItem {
  String id;
  String requirementID;
  String storeID;
  DateTime date;
  String yourName;
  String storeCategory;
  String brands;
  String modelNo;
  int size;
  int quantity;
  String units;
  String requirementInDetails;
  String addImage;
  String location;
  String status;
  int v;

  RejectedItem({
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
    required this.v,
  });

  factory RejectedItem.fromJson(Map<String, dynamic> json) {
    return RejectedItem(
      id: json['_id'],
      requirementID: json['RequirementID'],
      storeID: json['StoreID'],
      date: DateTime.parse(json['Date']),
      yourName: json['your_name'],
      storeCategory: json['storeCategory'],
      brands: json['Brands'],
      modelNo: json['ModelNo'],
      size: json['size'],
      quantity: json['Quantity'],
      units: json['Units'],
      requirementInDetails: json['Requirement_in_details'],
      addImage: json['AddImage'],
      location: json['Location'],
      status: json['Status'],
      v: json['__v'],
    );
  }
}
