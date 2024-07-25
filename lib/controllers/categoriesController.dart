import 'package:dekhlo/models/subSubCategory.dart';
import 'package:dekhlo/services/injection.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

import '../models/categoriesBased.dart';
import '../models/categororiesModel.dart';

class CategoriesController extends GetxController {
  final RxList<String> categories = <String>[].obs;
  final RxList<String> setupCategories = <String>[].obs;
  final RxList<String> subCategories = <String>[].obs;
  final RxList<String> setupsubCategories = <String>[].obs;
  final RxList<String> setupsubSubCategories = <String>[].obs;
  List<String> subSubCategoriessetup = [];
  final RxList<String> subSubCategories = <String>[].obs;

  final RxBool isLoading = false.obs;
  final RxBool isLoadingSubSub = false.obs;
  var selectedCategory = ''.obs;
  var selectedSubCategory = ''.obs;
  var selectedSubSubCategory = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchCategories();
    fetchCategoriesSetUp();
  }

  Future<void> fetchCategoriesSetUp() async {
    try {
      isLoading.value = true;
      final List<StoreCategory> response =
          await restClient.getAllCategoriesStoreSetUp();

      setupCategories
          .assignAll(response.expand((category) => category.storeCategory));
      isLoading.value = false;

      if (setupCategories.isNotEmpty) {
        Logger().f('First category: ${setupCategories.first}');
      } else {
        Logger().f('No categories found');
      }
    } catch (error) {
      isLoading.value = true;
      Logger().e('Error fetching categories: $error');
      isLoading.value = false;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchCategories() async {
    try {
      isLoading.value = true;
      final List<StoreCategory> response = await restClient.getAllCategories();

      categories
          .assignAll(response.expand((category) => category.storeCategory));
      isLoading.value = false;

      if (categories.isNotEmpty) {
        Logger().f('First category: ${categories.first}');
      } else {
        Logger().f('No categories found');
      }
    } catch (error) {
      isLoading.value = true;
      Logger().e('Error fetching categories: $error');
      isLoading.value = false;
    } finally {
      isLoading.value = false;
    }
  }

  // fetch categories with subcategory
  Future<void> fetchSetupSubcategories(List<String> categories) async {
    setupsubCategories.clear();
    try {
      isLoading.value = true;

      final String categoriesList = categories.join(',');
      final List<CategoryWithSubcategories> response =
          await restClient.getSetupsubcategorieswithCategories(categoriesList);

      for (var category in response) {
        for (var subCategory in category.storeSubCategory) {
          setupsubCategories.add(subCategory.name);
        }
      }
      setupsubCategories.refresh(); // Force update

      Logger().f('Fetched setup subcategories: $setupsubCategories');

      isLoading.value = false;
    } catch (error) {
      isLoading.value = false;
      Logger().e('Error fetching setup subcategories: $error');
    }
  }

  Future<List<String>> fetchSubSubsetUpCategories(List<String> list) async {
    try {
      isLoadingSubSub.value = true;
      final String categoriesList = list.join(',');
      final response = await restClient
          .getSetupsubsubcategorieswithCategories(categoriesList);

      //check

      for (var categoryGroup in response) {
        for (var mainCategory in categoryGroup.mainCategories) {
          subSubCategoriessetup.addAll(mainCategory.subCategories);
        }
      }
      Logger().f(subSubCategoriessetup);
      isLoadingSubSub.value = false;
      return subSubCategoriessetup;
    } catch (e) {
      isLoadingSubSub.value = true;
      print('Error fetching sub-subcategories: $e');
      isLoadingSubSub.value = false;
      return [];
    }
  }

  Future<void> fetchSubcategories(String subcat) async {
    subCategories.clear();
    try {
      isLoading.value = true;
      final CategoryResponse response =
          await restClient.getsubcategorieswithCategories(subcat);

      isLoading.value = false;

      if (categories.isNotEmpty) {
        Logger().f('First category: ${response.storeSubCategory.first.name}');
        subCategories.addAll(
            response.storeSubCategory.map((subcategory) => subcategory.name));
      } else {
        Logger().f('No categories found');
      }
    } catch (error) {
      isLoading.value = true;
      Logger().e('Error fetching categories: $error');
      isLoading.value = false;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchSubSubcategories(
      String subcategory, String subSubCat) async {
    subSubCategories.clear();
    try {
      isLoading.value = true;
      final YogaStore response = await restClient
          .getsubSubcategorieswithCategories(subcategory, subSubCat);

      isLoading.value = false;

      if (response.subCategories.isNotEmpty) {
        Logger().f('First sub-subcategory: ${response.storeSubCategory}');
        subSubCategories.addAll(
            response.subCategories.map((subSubcategory) => subSubcategory));

        Logger().d(subSubCategories);
      } else {
        Logger().f('No sub-subcategories found');
      }
    } catch (error) {
      isLoading.value = true;
      Logger().e('Error fetching sub-subcategories: $error');
      isLoading.value = false;
    } finally {
      isLoading.value = false;
    }
  }
}

class StoreCategorySetUp {
  List<CategoryWithSubcategories> categories;

  StoreCategorySetUp({required this.categories});

  factory StoreCategorySetUp.fromJson(List<dynamic> json) {
    return StoreCategorySetUp(
      categories:
          json.map((item) => CategoryWithSubcategories.fromJson(item)).toList(),
    );
  }
}

class CategoryWithSubcategories {
  List<String> storeCategory;
  List<SubCategory> storeSubCategory;

  CategoryWithSubcategories({
    required this.storeCategory,
    required this.storeSubCategory,
  });

  factory CategoryWithSubcategories.fromJson(Map<String, dynamic> json) {
    return CategoryWithSubcategories(
      storeCategory: List<String>.from(json['storeCategory']),
      storeSubCategory: (json['storeSubCategory'] as List)
          .map((item) => SubCategory.fromJson(item))
          .toList(),
    );
  }

  static List<CategoryWithSubcategories> fromJsonList(List<dynamic> jsonList) {
    return jsonList
        .map((json) => CategoryWithSubcategories.fromJson(json))
        .toList();
  }
}

class SubCategory {
  String name;
  String id;

  SubCategory({
    required this.name,
    required this.id,
  });

  factory SubCategory.fromJson(Map<String, dynamic> json) {
    return SubCategory(
      name: json['name'],
      id: json['_id'],
    );
  }
}

class StoreSetupSubSub {
  List<CategoryGroup> categoryGroups;

  StoreSetupSubSub({required this.categoryGroups});

  factory StoreSetupSubSub.fromJson(List<dynamic> json) {
    return StoreSetupSubSub(
      categoryGroups: json.map((item) => CategoryGroup.fromJson(item)).toList(),
    );
  }
}

class CategoryGroup {
  List<MainCategory> mainCategories;

  CategoryGroup({
    required this.mainCategories,
  });

  factory CategoryGroup.fromJson(Map<String, dynamic> json) {
    return CategoryGroup(
      mainCategories: (json['storeSubCategory'] as List)
          .map((item) => MainCategory.fromJson(item))
          .toList(),
    );
  }

  static List<CategoryGroup> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => CategoryGroup.fromJson(json)).toList();
  }
}

class MainCategory {
  String name;
  List<String> subCategories;

  MainCategory({
    required this.name,
    required this.subCategories,
  });

  factory MainCategory.fromJson(Map<String, dynamic> json) {
    return MainCategory(
      name: json['name'],
      subCategories: List<String>.from(json['subCategories'] ?? []),
    );
  }
}
