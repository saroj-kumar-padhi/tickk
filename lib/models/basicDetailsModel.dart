class CreateBuyerRequest {
  final String mobile;
  final String yourName;
  final String email;
  final String gender;
  final int age;
  final String Otp;
  final bool verified;
  final String FCM;

  CreateBuyerRequest({
    required this.mobile,
    required this.email,
    required this.yourName,
    required this.age,
    required this.gender,
    required this.Otp,
    required this.verified,
    required this.FCM,
  });

  Map<String, dynamic> toJson() => {
        'mobile': mobile,
        'email': email,
        'your_name': yourName, // Match the field name expected by the API
        'age': age,
        'gender': gender,
        'Otp': Otp,
        "verified": false,
        "FCM": FCM
      };
}


// {
//         "mobile": "1234554321",
//         "your_name": "saroj",
//         "email": "abc",
//         "gender": "Male",
//         "age": 20,
//         "otp" : 123456,
//         "verified": false,
//         "FCM": "sjhdbk"
// } 