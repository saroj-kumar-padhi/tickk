class StoreCategory {
  final String id;
  final List<String> storeCategory;

  StoreCategory({
    required this.id,
    required this.storeCategory,
  });

  factory StoreCategory.fromJson(Map<String, dynamic> json) {
    return StoreCategory(
      id: json['_id'],
      storeCategory: List<String>.from(json['storeCategory']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'storeCategory': storeCategory,
    };
  }
}
