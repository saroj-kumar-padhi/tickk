class SellerResponseModel {
  final bool success;
  final List<Data> data;

  SellerResponseModel({required this.success, required this.data});

  factory SellerResponseModel.fromJson(Map<String, dynamic> json) {
    return SellerResponseModel(
      success: json['success'],
      data: List<Data>.from(json['data'].map((item) => Data.fromJson(item))),
    );
  }
}

class Data {
  final bool extract;
  final bool similar;
  final String id;
  final int mobile;
  final String requirementID;
  final DateTime date;
  final String yourName;
  final String storeCategory;
  final String storeSubCategory;
  final String storeID;
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
  final int v;

  Data({
    required this.extract,
    required this.similar,
    required this.id,
    required this.mobile,
    required this.requirementID,
    required this.date,
    required this.yourName,
    required this.storeCategory,
    required this.storeSubCategory,
    required this.storeID,
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
    required this.v,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      extract: json['Exact'],
      similar: json['Similar'],
      id: json['_id'],
      mobile: json['mobile'],
      requirementID: json['RequirementID'],
      date: DateTime.parse(json['Date']),
      yourName: json['your_name'],
      storeCategory: json['storeCategory'],
      storeSubCategory: json['storeSubCategory'],
      storeID: json['StoreID'],
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
      v: json['__v'],
    );
  }
}
