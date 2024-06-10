class CreatePostRequest {
  final String mobile;
  final String your_name;
  final String storeCategory;
  final String storeSubCategory;
  final String storeSubSubCategory;
  final String Brands;
  final String ModelNo;
  final int Quote;
  final int size;
  final int Quantity;
  final String Units;
  final String Requirement_in_details;
  final String AddImage;
  final String Location;
  final String Status;
  final String DeleteButton;
  final String Accept;
  final String Reject;

  CreatePostRequest({
    required this.mobile,
    required this.your_name,
    required this.storeCategory,
    required this.storeSubCategory,
    required this.storeSubSubCategory,
    required this.Brands,
    required this.ModelNo,
    required this.Quote,
    required this.size,
    required this.Quantity,
    required this.Units,
    required this.Requirement_in_details,
    required this.AddImage,
    required this.Location,
    required this.Status,
    required this.DeleteButton,
    required this.Accept,
    required this.Reject,
  });

  Map<String, dynamic> toJson() => {
        'mobile': mobile,
        'your_name': your_name,
        'storeCategory': storeCategory,
        'storeSubCategory': storeSubCategory,
        'storeSubSubCategory': storeSubSubCategory,
        'Brands': Brands,
        'ModelNo': ModelNo,
        'Quote': Quote,
        'size': size,
        'Quantity': Quantity,
        'Units': Units,
        'Requirement_in_details': Requirement_in_details,
        'AddImage': AddImage,
        'Location': Location,
        'Status': Status,
        'deletebutton': DeleteButton,
        'Accept': Accept,
        'Reject': Reject,
      };
}
