class UserFcmToken {
  final String fcm;

  UserFcmToken({required this.fcm});

  factory UserFcmToken.fromJson(Map<String, dynamic> json) {
    return UserFcmToken(
      fcm: json['FCM'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'FCM': fcm,
    };
  }
}
