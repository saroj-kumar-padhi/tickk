class Requirement {
  final String id;
  final int mobile;
  final String requirementID;
  final String yourName;
  final String storeCategory;
  final String storeSubCategory;
  final String storeSubSubCategory;
  final String brands;
  final String modelNo;
  final int size;
  final int quantity;
  final String units;
  final int quote;
  final String requirementInDetails;
  final String addImage;
  final String location;
  final String status;
  final String deleteButton;
  final String accept;
  final String reject;
  final DateTime date;
  final int v;

  Requirement({
    required this.id,
    required this.mobile,
    required this.requirementID,
    required this.yourName,
    required this.storeCategory,
    required this.storeSubCategory,
    required this.storeSubSubCategory,
    required this.brands,
    required this.modelNo,
    required this.size,
    required this.quantity,
    required this.units,
    required this.quote,
    required this.requirementInDetails,
    required this.addImage,
    required this.location,
    required this.status,
    required this.deleteButton,
    required this.accept,
    required this.reject,
    required this.date,
    required this.v,
  });

  factory Requirement.fromJson(Map<String, dynamic> json) {
    return Requirement(
      id: json['_id'],
      mobile: json['mobile'],
      requirementID: json['RequirementID'],
      yourName: json['your_name'],
      storeCategory: json['storeCategory'],
      storeSubCategory: json['storeSubCategory'],
      storeSubSubCategory: json['storeSubSubCategory'],
      brands: json['Brands'],
      modelNo: json['ModelNo'],
      size: json['size'],
      quantity: json['Quantity'],
      units: json['Units'],
      quote: json['Quote'],
      requirementInDetails: json['Requirement_in_details'],
      addImage: json['AddImage'],
      location: json['Location'],
      status: json['Status'],
      deleteButton: json['deletebutton'],
      accept: json['Accept'],
      reject: json['Reject'],
      date: DateTime.parse(json['Date']),
      v: json['__v'],
    );
  }
}

class RequirementList {
  final List<Requirement> requirements;

  RequirementList({required this.requirements});

  factory RequirementList.fromJson(List<dynamic> json) {
    List<Requirement> requirements =
        json.map((i) => Requirement.fromJson(i)).toList();
    return RequirementList(requirements: requirements);
  }
}
