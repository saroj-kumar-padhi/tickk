import 'package:dekhlo/models/subSubCategory.dart';
import 'package:dekhlo/services/injection.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

import '../models/categoriesBased.dart';
import '../models/categororiesModel.dart';

class CategoriesController extends GetxController {
  final RxList<String> categories = <String>[].obs;
  final RxList<String> subCategories = <String>[].obs;
  final RxList<String> subSubCategories = <String>[].obs;
  final RxBool isLoading = false.obs;
  var selectedCategory = ''.obs;
  var selectedSubCategory = ''.obs;
  var selectedSubSubCategory = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchCategories();
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
