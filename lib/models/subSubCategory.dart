class YogaStore {
  final String storeCategory;
  final String storeSubCategory;
  final List<String> subCategories;

  YogaStore({
    required this.storeCategory,
    required this.storeSubCategory,
    required this.subCategories,
  });

  factory YogaStore.fromJson(Map<String, dynamic> json) {
    return YogaStore(
      storeCategory: json['storeCategory'],
      storeSubCategory: json['storeSubCategory'],
      subCategories: List<String>.from(json['subCategories']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'storeCategory': storeCategory,
      'storeSubCategory': storeSubCategory,
      'subCategories': subCategories,
    };
  }
}
