class Review {
  final String id;
  final DateTime date;
  final String yourName;
  final String rating;
  final String description;

  Review({
    required this.id,
    required this.date,
    required this.yourName,
    required this.rating,
    required this.description,
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      id: json['_id'],
      date: DateTime.parse(json['Date']),
      yourName: json['your_name'],
      rating: json['Rating'],
      description: json['description'],
    );
  }
}
