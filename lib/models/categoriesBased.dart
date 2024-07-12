class CategoryResponse {
  final List<StoreSubCategory> storeSubCategory;

  CategoryResponse({required this.storeSubCategory});

  factory CategoryResponse.fromJson(Map<String, dynamic> json) {
    return CategoryResponse(
      storeSubCategory: (json['storeSubCategory'] as List)
          .map((item) => StoreSubCategory.fromJson(item))
          .toList(),
    );
  }
}

class StoreSubCategory {
  final String name;
  final List<String> subCategories;
  final String id;

  StoreSubCategory({
    required this.name,
    required this.subCategories,
    required this.id,
  });

  factory StoreSubCategory.fromJson(Map<String, dynamic> json) {
    return StoreSubCategory(
      name: json['name'],
      subCategories: List<String>.from(json['subCategories']),
      id: json['_id'],
    );
  }
}
