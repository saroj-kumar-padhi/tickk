class BasicDataModelEdit {
  String id;
  String mobile;
  String yourName;
  String email;
  String gender;
  int age;
  bool verified;
  String profileImage;
  int v;

  BasicDataModelEdit({
    required this.id,
    required this.mobile,
    required this.yourName,
    required this.email,
    required this.gender,
    required this.age,
    required this.verified,
    required this.profileImage,
    required this.v,
  });

  // Factory constructor to create an instance from JSON
  factory BasicDataModelEdit.fromJson(Map<String, dynamic> json) {
    return BasicDataModelEdit(
      id: json['_id'] ?? "",
      mobile: json['mobile'] ?? "",
      yourName: json['your_name'] ?? "",
      email: json['email'] ?? "",
      gender: json['gender'] ?? "",
      age: json['age'] ?? 0,
      verified: json['verified'] ?? false,
      v: json['__v'] ?? -1,
      profileImage: json['profileImage'] ?? "",
    );
  }

  // Method to convert an instance to JSON
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'mobile': mobile,
      'your_name': yourName,
      'email': email,
      'gender': gender,
      'age': age,
      'verified': verified,
      '__v': v,
    };
  }
}
