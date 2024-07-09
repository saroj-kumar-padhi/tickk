import 'dart:convert';

class PersonName {
  final String id;
  final String yourName;
  final String gender;

  PersonName({
    required this.id,
    required this.yourName,
    required this.gender,
  });

  factory PersonName.fromJson(Map<String, dynamic> json) {
    return PersonName(
      id: json['_id'],
      yourName: json['your_name'],
      gender: json['gender'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'your_name': yourName,
      'gender': gender,
    };
  }
}
