class User {
  final String id;
  final String mobile;
  final String yourName;
  final String email;
  final String gender;
  final int age;
  final int otp;
  final String fcm;
  final int v;

  User({
    required this.id,
    required this.mobile,
    required this.yourName,
    required this.email,
    required this.gender,
    required this.age,
    required this.otp,
    required this.fcm,
    required this.v,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'],
      mobile: json['mobile'],
      yourName: json['your_name'],
      email: json['email'],
      gender: json['gender'],
      age: json['age'],
      otp: json['otp'],
      fcm: json['FCM'],
      v: json['__v'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'mobile': mobile,
      'your_name': yourName,
      'email': email,
      'gender': gender,
      'age': age,
      'otp': otp,
      'FCM': fcm,
      '__v': v,
    };
  }
}
