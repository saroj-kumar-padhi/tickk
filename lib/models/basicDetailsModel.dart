class CreateBuyerRequest {
  final String mobile;
  final String email;
  final String yourName;
  final int age;
  final String gender;

  CreateBuyerRequest({
    required this.mobile,
    required this.email,
    required this.yourName,
    required this.age,
    required this.gender,
  });

  Map<String, dynamic> toJson() => {
        'mobile': mobile,
        'email': email,
        'your_name': yourName, // Match the field name expected by the API
        'age': age,
        'gender': gender,
      };
}
