class RejectedItemsResponsed {
  List<RejectedItemd> rejectedItems;

  RejectedItemsResponsed({required this.rejectedItems});

  factory RejectedItemsResponsed.fromJson(List<dynamic> json) {
    return RejectedItemsResponsed(
      rejectedItems: json.map((item) => RejectedItemd.fromJson(item)).toList(),
    );
  }
}

class RejectedItemd {
  String id;
  String requirementID;
  String storeID;
  DateTime date;
  String yourName;
  String storeCategory;
  String brands;
  String modelNo;
  String size;
  int quantity;
  String units;
  String requirementInDetails;
  String addImage;
  String location;
  String status;
  int v;

  RejectedItemd({
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

  factory RejectedItemd.fromJson(Map<String, dynamic> json) {
    return RejectedItemd(
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
