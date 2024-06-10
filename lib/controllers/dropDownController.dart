import 'package:dekhlo/models/postRequirementModel.dart';
import 'package:dekhlo/services/injection.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:logger/web.dart';

import '../utils/routes/routes_names.dart';

class DropdownController extends GetxController {
  var selectedItem = ''.obs;
  var selectedCategory = ''.obs;
  var selectedSubcategory = ''.obs;
  var selectedSubSubcategory = ''.obs;
  var selectedUnits = ''.obs;
  RxBool isLoading = false.obs;

  RxBool issubSet = false.obs;
  RxBool issubsubSet = false.obs;

  RxString selectedGender = ''.obs;
  RxBool isNewImage = false.obs;
  final GenderList = ['Male', 'Female', 'Others'];

  final categories = [
    "Electronics",
    "Fashion",
    "Sports",
    "Electricals",
    "Pet stores",
    "Medical",
    "Construction",
    "Gifts"
  ];

  final Map<String, List<String>> subcategoriesMap = {
    "Electronics": [
      "Mobile phones and accessories",
      "Laptops, computers, and accessories",
      "Home appliances",
      "Kitchen appliances",
      "Head phones",
      "Smart watches",
      "Video games",
      "Tablets",
      "Home audio",
      "Grooming appliances"
    ],
    "Fashion": [
      "Women's clothing",
      "Men's clothing",
      "Kids fashion",
      "Beauty and makeup",
      "Shoes and footwear",
      "Bags, wallets and luggage",
      "Watches",
      "Jewellery",
      "Women's lingerie and sleepwear",
      "Men's inner wear",
      "Men's boutique",
      "Women's boutique",
      "Unisex boutique"
    ],
    "Electricals": ["Fancy lights", "Fans", "Lighting", "Wiring", "Switches"],
    "Pet stores": [
      "Dogs",
      "Cats",
      "Fish & Aquatics",
      "Birds",
      "Cattle",
      "Other pets",
    ],
    "Medical": [
      "Pharmacy",
      "Surgically & equipment",
    ],
    "Construction": [
      "Adhesives & Sealants",
      "Asphalts, Cement, & Cementious Products",
      "Construction Chemicals",
      "Doors & Windows & their fittings",
      "Cladding & Facade",
      "Furniture Hardware",
      "Ceiling",
      "Engineered Stones, Marbles, Granites & Tiles",
      "Flooring materials & Tools",
      "Insulations & Acoustics",
      "Coatings",
      "Paints and related materials",
      "Pipes, Plumbing, and Fittings",
      "Sanitary & CP Fittings",
      "Wood Products, Plywood & Laminates",
      "Glass",
      "Sand",
      "Bricks",
      "Steel",
    ],
    "Gifts": [
      "Books & Stationery",
      "Toys",
      "Home Decor",
    ],
    "Sports": [
      "Cycling",
      "Strength training",
      "Cardio",
      "Badminton",
      "Yoga",
      "Swimming",
      "Cricket",
      "Football",
      "Skating",
      "Camping & Outdoors",
      "Fitness accessories",
      "Tennis",
      "Indoor games"
    ],
  };

  final Map<String, List<String>> subSubcategoriesMap = {
    "Cycling": [
      "Adult geared cycles",
      "Adult non geared cycles",
      "Kids cycles",
      "Electric cycles",
      "Cycling kits & accessories"
    ],
    "Strength training": [
      "Dumbbells",
      "Home gym sets",
      "Benches",
      "Wearable weights & accessories",
      "Multi gym functional trainers",
      "Plates & barbells",
      "Kettle bells"
    ],
    "Cardio": ["Treadmills", "Fitness bikes", "Ellipticals", "Rowers"],
    "Badminton": [
      "Racquets",
      "Shuttle cocks",
      "Badminton sets",
      "Badminton shoes",
      "Kit bags",
      "Accessories"
    ],
    "Yoga": ["Yoga mats", "Yoga sets", "Yoga blocks", "Accessories"],
    "Swimming": [
      "Goggles",
      "Swimming caps",
      "Costumes",
      "Training aids",
      "Accessories"
    ],
    "Cricket": [
      "Bats",
      "Balls",
      "Protective gears",
      "Cricket kits",
      "Shoes",
      "Accessories"
    ],
    "Football": [
      "Balls",
      "Shoes",
      "Gloves",
      "Accessories",
      "Training equipment",
      "Fanshop"
    ],
    "Skating": [
      "Scaters",
      "Roller skates",
      "Online skates",
      "Skate boards",
      "Helmets",
      "Protective gears"
    ],
    "Tennis": ["Racquets", "Balls", "Shoes", "Kit bags", "Accessories"],
  };

  List<String> get subcategories =>
      subcategoriesMap[selectedCategory.value] ?? [];

  List<String> get subSubcategories =>
      subSubcategoriesMap[selectedSubcategory.value] ?? [];

  void changeSelectedItem(String newValue) {
    selectedItem.value = newValue;
  }

  void changeSelectedCategory(String newCategory) {
    selectedCategory.value = newCategory;
    selectedItem.value = 'Select a Subcategory';
    selectedSubcategory.value = 'Select a Subcategory';
  }

  void changeSelectedSubcategory(String newSubcategory) {
    selectedSubcategory.value = newSubcategory;
  }

  void changeSelectedSubSubcategory(String newSubSubcategory) {
    selectedSubSubcategory.value = newSubSubcategory;
  }

  Future<void> postRequrements({
    required final String units,
    required final String category,
    required final String subcategory,
    required final String subsubCategory,
    required final String brand,
    required final String modelNo,
    required final int quote,
    required final int size,
    required final int quantity,
    required final String details,
    required final String image,
  }) async {
    try {
      isLoading.value = true;
      String subSub = subsubCategory == "" ? "Not available" : subsubCategory;
      String PhoneNumber = FirebaseAuth.instance.currentUser!.phoneNumber ?? "";
      String formattedPhoneNumber = PhoneNumber.substring(3);
      final test = {
        "mobile": formattedPhoneNumber,
        "your_name": "dheklo",
        "storeCategory": category,
        "storeSubCategory": subcategory,
        "storeSubSubCategory": subSub,
        "Brands": brand,
        "ModelNo": modelNo,
        "Quote": quote,
        "size": size,
        "Quantity": quantity,
        "Units": units,
        "Requirement_in_details": details,
        "AddImage": image,
        "Location": "New York",
        "Status": "accept",
        "deletebutton": "",
        "Accept": "",
        "Reject": ""
      };

      await restClient.postRequirements(test).then((value) {
        Fluttertoast.showToast(msg: "Thanks Yor requrements send sccessfully");
        Get.toNamed(RouteName.homeBuyerScreen);
      });
    } catch (e) {
      Logger().d(e);
      Fluttertoast.showToast(msg: e.toString());
    }
  }
}
