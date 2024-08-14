import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:dekhlo/controllers/productSetupController.dart';
import 'package:dekhlo/services/injection.dart';
import 'package:dekhlo/utils/components/coustoumTextField.dart';
import 'package:dekhlo/utils/components/textstyle.dart';
import 'package:dekhlo/utils/routes/routes_names.dart';
import 'package:dekhlo/views/google_map_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get_connect/connect.dart';
import 'package:http_parser/http_parser.dart';
import 'package:path/path.dart' as path;
import 'package:dio/dio.dart' as dio;
import 'package:get/get.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/multipart/form_data.dart';
import 'package:hive/hive.dart';
import 'package:logger/web.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

import '../../../controllers/categoriesController.dart';
import '../../../controllers/dropDownController.dart';
import '../../../controllers/exactController.dart';
import '../../../controllers/sortDialogBoxController.dart';
import '../../../utils/components/dialog_boxs/pick_diallo.dart';
import '../../../utils/size/global_size/global_size.dart';
import '../set_up_store.dart';

class StoreEditScreen extends StatefulWidget {
  static final MultiSelectController categorySelectController =
      MultiSelectController();
  static final MultiSelectController subCategorySelectController =
      MultiSelectController();
  static final MultiSelectController subSubCategorySelectController =
      MultiSelectController();
  var formData = dio.FormData();
  final String storeID;
  final List<dynamic> imageList;

  final String storeName;
  final List<String> storeCategory;
  final List<dynamic> storeSubcategory;
  final String stared;

  final List<dynamic> brands;
  final String about;
  final String yt;
  final String iG;
  final String webSite;

  final String houseNo;
  final String area;
  final String pincode;
  final String city;
  final String yourStoreLoaction;

  // Timing for each day of the week
  final String sundayOpentime;
  final String sundayClosetime;
  final String mondayOpentime;
  final String mondayClosetime;
  final String tuesdayOpentime;
  final String tuesdayClosetime;
  final String wednesdayOpentime;
  final String wednesdayClosetime;
  final String thursdayOpentime;
  final String thursdayClosetime;
  final String fridayOpentime;
  final String fridayClosetime;
  final String saturdayOpentime;
  final String saturdayClosetime;

  StoreEditScreen(
      {super.key,
      required this.storeName,
      required this.storeCategory,
      required this.storeSubcategory,
      required this.about,
      required this.yt,
      required this.iG,
      required this.webSite,
      required this.houseNo,
      required this.pincode,
      required this.city,
      required this.yourStoreLoaction,
      required this.area,
      required this.brands,
      required this.sundayOpentime,
      required this.sundayClosetime,
      required this.mondayOpentime,
      required this.mondayClosetime,
      required this.tuesdayOpentime,
      required this.tuesdayClosetime,
      required this.wednesdayOpentime,
      required this.wednesdayClosetime,
      required this.thursdayOpentime,
      required this.thursdayClosetime,
      required this.fridayOpentime,
      required this.fridayClosetime,
      required this.saturdayOpentime,
      required this.saturdayClosetime,
      required this.stared,
      required this.storeID,
      required this.imageList});

  @override
  State<StoreEditScreen> createState() => _StoreEditScreenState();
}

class _StoreEditScreenState extends State<StoreEditScreen> {
  List<ValueItem> selectedCategoryOptions = [];
  List<ValueItem> selectedSubCategoryOptions = [];

  List<String> SubCategoryItems = [];
  List<String> SubSubCategoryItems = [];

  List<String> categorySelected = [];
  List<String> subCategorySelected = [];
  List<String> subSubCategorySelected = [];

  List<ValueItem<dynamic>> selectedSubCategoryItems = [];

  List<dynamic> selectedSubSubCategoryItems = [];

  final DropdownController dropdownController = Get.put(DropdownController());

  final MultiSelectController languageSelectController =
      MultiSelectController();

  final ProductSetUpController productSetUpController =
      Get.put(ProductSetUpController());

  final ProductSetUpController brandsController =
      Get.put(ProductSetUpController());

  DialogBoxController dialogBoxController = Get.put(DialogBoxController());

  CategoriesController categoriesController = Get.put(CategoriesController());

  List<ValueItem> convertToValueItems(List<String> items) {
    return items.asMap().entries.map((entry) {
      return ValueItem(label: entry.value, value: entry.key.toString());
    }).toList();
  }

  final ExactController exactController = Get.put(ExactController());

  RxInt currentPage = 0.obs;
  List removedImdexs = [];

  late RxBool sundayIsOpen;
  late RxBool mondayIsOpen;
  late RxBool tuesdayIsOpen;
  late RxBool wednesdayIsOpen;
  late RxBool thursdayIsOpen;
  late RxBool fridayIsOpen;
  late RxBool saturdayIsOpen;

  @override
  void initState() {
    super.initState();
    sundayIsOpen = RxBool(
        widget.sundayOpentime.isNotEmpty && widget.sundayClosetime.isNotEmpty);
    mondayIsOpen = RxBool(
        widget.mondayOpentime.isNotEmpty && widget.mondayClosetime.isNotEmpty);
    tuesdayIsOpen = RxBool(widget.tuesdayOpentime.isNotEmpty &&
        widget.tuesdayClosetime.isNotEmpty);
    wednesdayIsOpen = RxBool(widget.wednesdayOpentime.isNotEmpty &&
        widget.wednesdayClosetime.isNotEmpty);
    thursdayIsOpen = RxBool(widget.thursdayOpentime.isNotEmpty &&
        widget.thursdayClosetime.isNotEmpty);
    fridayIsOpen = RxBool(
        widget.fridayOpentime.isNotEmpty && widget.fridayClosetime.isNotEmpty);
    saturdayIsOpen = RxBool(widget.saturdayOpentime.isNotEmpty &&
        widget.saturdayClosetime.isNotEmpty);

    selectedCategoryOptions = widget.storeCategory
        .asMap()
        .entries
        .map((entry) =>
            ValueItem(label: entry.value, value: entry.key.toString()))
        .toList();

    selectedSubCategoryOptions = widget.storeSubcategory
        .asMap()
        .entries
        .map((entry) =>
            ValueItem(label: entry.value, value: entry.key.toString()))
        .toList();

    productSetUpController.imagePaths.clear();
  }

  @override
  Widget build(BuildContext context) {
    RxList images = widget.imageList.obs;
    String brands = widget.brands.join(',');
    TextEditingController storeNameController =
        TextEditingController(text: widget.storeName);
    TextEditingController brandsController =
        TextEditingController(text: brands);
    TextEditingController aboutYourStoreController =
        TextEditingController(text: widget.about);
//social media
    TextEditingController ytController = TextEditingController(text: widget.yt);
    TextEditingController iGController = TextEditingController(text: widget.iG);
    TextEditingController wLController =
        TextEditingController(text: widget.webSite);

    //address
    TextEditingController houseNoController =
        TextEditingController(text: widget.houseNo);
    TextEditingController streetController =
        TextEditingController(text: widget.area);
    TextEditingController pinCodeController =
        TextEditingController(text: widget.pincode);
    TextEditingController cityController =
        TextEditingController(text: widget.city);

    dialogBoxController.locacationController.value.text =
        widget.yourStoreLoaction;

    // Opening and closing times
    TextEditingController sundayOpenController =
        TextEditingController(text: widget.sundayOpentime);
    TextEditingController sundayCloseController =
        TextEditingController(text: widget.sundayClosetime);
    TextEditingController mondayOpenController =
        TextEditingController(text: widget.mondayOpentime);
    TextEditingController mondayCloseController =
        TextEditingController(text: widget.mondayClosetime);
    TextEditingController tuesdayOpenController =
        TextEditingController(text: widget.tuesdayOpentime);
    TextEditingController tuesdayCloseController =
        TextEditingController(text: widget.tuesdayClosetime);
    TextEditingController wednesdayOpenController =
        TextEditingController(text: widget.wednesdayOpentime);
    TextEditingController wednesdayCloseController =
        TextEditingController(text: widget.wednesdayClosetime);
    TextEditingController thursdayOpenController =
        TextEditingController(text: widget.thursdayOpentime);
    TextEditingController thursdayCloseController =
        TextEditingController(text: widget.thursdayClosetime);
    TextEditingController fridayOpenController =
        TextEditingController(text: widget.fridayOpentime);
    TextEditingController fridayCloseController =
        TextEditingController(text: widget.fridayClosetime);
    TextEditingController saturdayOpenController =
        TextEditingController(text: widget.saturdayOpentime);
    TextEditingController saturdayCloseController =
        TextEditingController(text: widget.saturdayClosetime);

    final box = Hive.box('myBox');
    final String formattedPhoneNumber = box.get('phone') ?? "";
    List<File> localImageFiles = [];
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        shadowColor: Colors.black,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Color(0xff4A4A4A),
          ),
        ),
        title: Text(
          "Edit profile",
          style: TextStyles.openSans(
            fontWeight: FontWeight.w600,
            fontSize: 17.sp,
            color: const Color(0xff4A4A4A),
          ),
        ),
      ),
      body: ListView(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20.h,
              ),
              Obx(() {
                return images.isEmpty
                    ? addImages(context)
                    : Column(
                        children: [
                          CarouselSlider.builder(
                            options: CarouselOptions(
                              enableInfiniteScroll: false,
                              onPageChanged: (index, reason) {
                                currentPage.value = index;
                              },
                              viewportFraction: 0.4,
                              height: 160.0.h,
                            ),
                            itemCount: images.length,
                            itemBuilder: (BuildContext context, int index,
                                int realIndex) {
                              final String imagePath = images[index];
                              final bool isNetworkImage =
                                  imagePath.startsWith('http');

                              if (!localImageFiles
                                  .contains(File(images[index]))) {
                                isNetworkImage == false
                                    ? localImageFiles.add(File(images[index]))
                                    : const SizedBox();
                              }

                              return Column(
                                children: [
                                  Stack(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(4.r),
                                            border: Border.all(
                                                width: 1,
                                                color:
                                                    const Color(0xff828282))),
                                        child: Padding(
                                          padding: EdgeInsets.fromLTRB(
                                              8.0.w, 12.h, 8.w, 12.h),
                                          child: Container(
                                            height: 100,
                                            width: 100,
                                            margin: const EdgeInsets.symmetric(
                                                horizontal: 5.0),
                                            decoration: const BoxDecoration(
                                                color: Colors.amber),
                                            child: isNetworkImage
                                                ? Image.network(imagePath,
                                                    fit: BoxFit.cover)
                                                : Image.file(File(imagePath),
                                                    fit: BoxFit.cover),
                                          ),
                                        ),
                                      ),
                                      Obx(() => Positioned(
                                            child: Row(
                                              children: [
                                                InkWell(
                                                  onTap: () {
                                                    if (productSetUpController
                                                        .staredImage
                                                        .contains(imagePath)) {
                                                      productSetUpController
                                                          .staredImage
                                                          .clear();
                                                    } else {
                                                      productSetUpController
                                                          .staredImage
                                                          .clear();
                                                      productSetUpController
                                                          .staredImage
                                                          .add(imagePath);
                                                    }
                                                  },
                                                  child: Icon(
                                                    productSetUpController
                                                            .staredImage
                                                            .contains(imagePath)
                                                        ? Icons.star
                                                        : Icons.star_border,
                                                    color:
                                                        productSetUpController
                                                                .staredImage
                                                                .contains(
                                                                    imagePath)
                                                            ? const Color(
                                                                0xffFFD361)
                                                            : Colors.grey,
                                                  ),
                                                ),
                                                SizedBox(width: 80.w),
                                                InkWell(
                                                  onTap: () {
                                                    removedImdexs.add(index);

                                                    images.remove(imagePath);
                                                    widget.imageList
                                                        .remove(imagePath);
                                                  },
                                                  child: const Icon(
                                                    Icons.cancel,
                                                    color: Color(0xff4A4A4A),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ))
                                    ],
                                  ),
                                ],
                              );
                            },
                          ),
                          SizedBox(height: 10.h),
                          // Indicator widget (unchanged)
                          Obx(() => images.length > 1
                              ? Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: List.generate(
                                    images.length,
                                    (index) => Container(
                                      width: 8.0,
                                      height: 8.0,
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 4.0),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: currentPage.value == index
                                            ? const Color(0xffFC8019)
                                            : const Color(0xffD9D9D9),
                                      ),
                                    ),
                                  ),
                                )
                              : const SizedBox()),
                          SizedBox(height: 10.h),
                          GestureDetector(
                            onTap: () async {
                              final result = await showDialog<String>(
                                context: context,
                                builder: (BuildContext context) {
                                  return const PickImageDialog(
                                    heading: 'Upload your store image',
                                  );
                                },
                              );
                              if (result != null) {
                                images.add(result);
                              }
                            },
                            child: images.length > 3
                                ? const SizedBox()
                                : Container(
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(4.r),
                                        border: Border.all(
                                            width: 1,
                                            color: const Color(0xffFC8019))),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          const Center(
                                            child: Icon(
                                              Icons.add,
                                              color: Color(0xffFC8019),
                                            ),
                                          ),
                                          Text("Add images",
                                              style: TextStyles.openSans(
                                                  fontSize: 16.sp,
                                                  fontWeight: FontWeight.w600,
                                                  color:
                                                      const Color(0xffFC8019)))
                                        ],
                                      ),
                                    ),
                                  ),
                          ),
                        ],
                      );
              }),
              SizedBox(
                height: 10.h,
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    heading(title: 'Store Name *'),
                    SizedBox(
                      height: 5.h,
                    ),
                    CustomTextField(
                        isenable: true,
                        controller: storeNameController,
                        hintText: "Enter your shop name",
                        height: 48.h,
                        width: 330.w),
                    SizedBox(
                      height: 10.h,
                    ),
                    heading(title: 'Contact Number'),
                    SizedBox(
                      height: 5.h,
                    ),
                    CustomTextField(
                        isenable: false,
                        controller:
                            productSetUpController.contactEditingController,
                        hintText: formattedPhoneNumber,
                        height: 48.h,
                        width: 330.w),
                    SizedBox(
                      height: 10.h,
                    ),
                    heading(title: 'Store category *'),
                    SizedBox(
                      height: 5.h,
                    ),
                    Obx(
                      () => Padding(
                        padding: EdgeInsets.only(right: 20.w),
                        child: MultiSelectDropDown(
                          suffixIcon: const Icon(Icons.arrow_downward),
                          borderColor: Colors.grey,
                          borderWidth: 1,
                          borderRadius: 4.r,
                          selectedOptionTextColor: const Color(0xffFC8019),
                          clearIcon: const Icon(Icons.close_outlined),
                          controller: SetUpProduct.categorySelectController,
                          selectedOptions: selectedCategoryOptions,
                          onOptionSelected: (options) {
                            debugPrint(options.toString());
                            List<String> selectedCategories =
                                options.map((option) => option.label).toList();

                            categorySelected = selectedCategories;
                            categoriesController
                                .fetchSetupSubcategories(selectedCategories);
                          },
                          options: convertToValueItems(
                              categoriesController.setupCategories),
                          maxItems: 10,
                          selectionType: SelectionType.multi,
                          chipConfig: const ChipConfig(
                            deleteIcon: Icon(Icons.close_outlined),
                            wrapType: WrapType.wrap,
                            backgroundColor: Color(0xffFC8019),
                          ),
                          dropdownHeight: 160.h,
                          optionTextStyle: TextStyle(fontSize: 16.sp),
                          selectedOptionIcon: const Icon(Icons.check_circle),
                        ),
                      ),
                    ),

                    SizedBox(
                      height: 10.h,
                    ),
                    widget.storeSubcategory.isEmpty
                        ? const SizedBox()
                        : heading(title: 'Sub categories'),
                    SizedBox(
                      height: 5.h,
                    ),
                    Obx(() {
                      print("Rebuilding subcategory dropdown");
                      print(
                          "Current subcategories: ${categoriesController.setupsubCategories}");

                      return widget.storeSubcategory.isEmpty
                          ? const SizedBox()
                          : Column(
                              children: [
                                categoriesController.isLoading.value
                                    ? const Center(
                                        child: CircularProgressIndicator())
                                    : Padding(
                                        padding: EdgeInsets.only(right: 20.w),
                                        child: CustomMultiSelectDropdown(
                                          items: categoriesController
                                              .setupsubCategories,
                                          preSelectedItems: widget
                                              .storeSubcategory, // Use your pre-selected list here
                                          onSelectionChanged: (selectedItems) {
                                            print(
                                                "Selected subcategories: $selectedItems");

                                            subCategorySelected = selectedItems;

                                            // Fetch sub-subcategories
                                            categoriesController
                                                .fetchSubSubsetUpCategories(
                                                    selectedItems);
                                          },
                                        ),
                                      ),

                                // Sub-subcategories (you can apply similar changes here)
                                // ...
                              ],
                            );
                    }),
                    SizedBox(
                      height: 10.h,
                    ),
                    SubSubCategoryItems.isEmpty
                        ? const SizedBox()
                        : heading(title: 'Sub Sub categories'),
                    SizedBox(
                      height: 5.h,
                    ),

                    Obx(() {
                      SubSubCategoryItems =
                          categoriesController.subSubCategoriessetup;

                      return categoriesController.isLoadingSubSub.value
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : SubSubCategoryItems.isEmpty
                              ? const SizedBox()
                              : Padding(
                                  padding: EdgeInsets.only(right: 20.w),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(4.r),
                                      border: Border.all(
                                          color: SubSubCategoryItems.isEmpty
                                              ? Colors.grey.shade300
                                              : Colors.grey,
                                          width: 1),
                                    ),
                                    child: AbsorbPointer(
                                      absorbing: SubSubCategoryItems.isEmpty,
                                      child: Opacity(
                                        opacity: SubSubCategoryItems.isEmpty
                                            ? 0.5
                                            : 1.0,
                                        child: MultiSelectDialogField<String>(
                                          items: SubSubCategoryItems.map(
                                              (subSubCategory) =>
                                                  MultiSelectItem<String>(
                                                      subSubCategory,
                                                      subSubCategory)).toList(),
                                          title: const Text(
                                              "Select Sub Sub Categories"),
                                          selectedColor:
                                              const Color(0xffFC8019),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(4.r),
                                            color: Colors.white,
                                          ),
                                          buttonText: const Text(
                                              "Select Sub Sub Categories"),
                                          onConfirm: (values) {
                                            selectedSubSubCategoryItems.clear();
                                            selectedSubSubCategoryItems = values
                                                .map((value) => ValueItem(
                                                      label: value.toString(),
                                                      value: value,
                                                    ))
                                                .toList();
                                            if (SubSubCategoryItems
                                                .isNotEmpty) {
                                              debugPrint(values.toString());
                                              SetUpProduct
                                                  .subSubCategorySelectController
                                                  .setSelectedOptions(
                                                values
                                                    .map((value) => ValueItem(
                                                          label: value,
                                                          value: value,
                                                        ))
                                                    .toList(),
                                              );

                                              categoriesController
                                                  .fetchSubSubsetUpCategories(
                                                      values);

                                              subSubCategorySelected = values;
                                            }
                                          },
                                          chipDisplay: MultiSelectChipDisplay(
                                            onTap: (value) {
                                              // Store the selected values in a separate list if needed

                                              if (SubSubCategoryItems
                                                  .isNotEmpty) {
                                                List<ValueItem> currentOptions =
                                                    SetUpProduct
                                                        .subSubCategorySelectController
                                                        .selectedOptions;
                                                currentOptions.removeWhere(
                                                    (option) =>
                                                        option.value == value);
                                                SetUpProduct
                                                    .subSubCategorySelectController
                                                    .setSelectedOptions(
                                                        currentOptions);
                                                categoriesController
                                                    .fetchSubSubsetUpCategories(
                                                        currentOptions
                                                            .map((option) =>
                                                                option.value
                                                                    .toString())
                                                            .toList());
                                              }
                                            },
                                            chipColor: const Color(0xffFC8019),
                                            textStyle: const TextStyle(
                                                color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                    }),

                    SizedBox(
                      height: 10.h,
                    ),
                    Row(
                      children: [
                        heading(title: 'Brands'),
                        Text(
                          " (optional)",
                          style: TextStyles.openSans(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                              color: Colors.grey),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    CustomTextField(
                        isenable: true,
                        controller: brandsController,
                        hintText: "Enter Brands name as list",
                        height: 48.h,
                        width: 330.w),

                    SizedBox(
                      height: 10.h,
                    ),
                    Row(
                      children: [
                        heading(title: "About your store"),
                        Text(
                          " (optional)",
                          style: TextStyles.openSans(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                              color: Colors.grey),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Container(
                      height: 100.h,
                      width: 330.w,
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        border: Border.all(width: 1, color: Colors.grey),
                      ),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: TextField(
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          controller: aboutYourStoreController,
                          decoration: const InputDecoration(
                            // contentPadding: EdgeInsets.only(bottom: 60.h),
                            hintText:
                                "e.g This store has all the types of books.",
                            border: InputBorder.none,
                            hintStyle: TextStyle(color: Colors.grey),
                          ),
                          style: const TextStyle(fontSize: 16.0),
                        ),
                      ),
                    ),

                    // social links
                    SizedBox(
                      height: 20.h,
                    ),
                    Row(
                      children: [
                        heading(title: "Link your social media accounts"),
                        SizedBox(
                          height: 5.h,
                        ),
                        Text(
                          " (optional)",
                          style: TextStyles.openSans(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                              color: Colors.grey),
                        ),
                      ],
                    ),
                    socialLinkBox(
                        controller: ytController,
                        imagePath: 'assest/you_tube.png',
                        platform: 'youtube'),

                    SizedBox(
                      height: 10.h,
                    ),
                    socialLinkBox(
                        controller: iGController,
                        imagePath: 'assest/instagram.png',
                        platform: 'instagram'),
                    SizedBox(
                      height: 10.h,
                    ),
                    socialLinkBox(
                        controller: wLController,
                        imagePath: 'assest/internet.png',
                        platform: 'Website'),
                    SizedBox(
                      height: 10.h,
                    ),
                    // heading(title: "Languages you know *"),
                    // SizedBox(
                    //   height: 10.h,
                    // ),
                    // Padding(
                    //   padding: EdgeInsets.only(right: 20.w),
                    //   child: MultiSelectDropDown(
                    //     borderColor: Colors.grey,
                    //     borderWidth: 1,
                    //     borderRadius: 4.r,
                    //     selectedOptionTextColor:
                    //         const Color(0xffFC8019).withOpacity(0.1),
                    //     clearIcon: const Icon(Icons.close_outlined),
                    //     controller: languageSelectController,
                    //     onOptionSelected: (options) {
                    //       debugPrint(options.toString());
                    //     },
                    //     options: const <ValueItem>[
                    //       ValueItem(label: 'Bangla', value: '1'),
                    //       ValueItem(label: 'English', value: '2'),
                    //       ValueItem(label: 'Gujarati', value: '3'),
                    //       ValueItem(label: 'Hindi', value: '4'),
                    //       ValueItem(label: 'Kannada', value: '5'),
                    //       ValueItem(label: 'Marathi', value: '6'),
                    //       ValueItem(label: 'Malayalam', value: '7'),
                    //       ValueItem(label: 'Punjabi', value: '8'),
                    //       ValueItem(label: 'Tamil', value: '9'),
                    //       ValueItem(label: 'Telugu', value: '10')
                    //     ],
                    //     maxItems: 3,
                    //     selectionType: SelectionType.multi,
                    //     chipConfig: const ChipConfig(
                    //         wrapType: WrapType.wrap,
                    //         backgroundColor: Color(0xffFC8019)),
                    //     dropdownHeight: 200.h,
                    //     optionTextStyle: TextStyle(fontSize: 16.sp),
                    //     selectedOptionIcon: const Icon(Icons.check_circle),
                    //   ),
                    // ),

                    SizedBox(
                      height: 10.h,
                    ),
                    heading(title: "Timings *"),
                    SizedBox(
                      height: 10.h,
                    ),

                    timings(
                      context,
                      "S",
                      sundayOpenController,
                      sundayCloseController,
                      sundayIsOpen,
                    ),
                    timings(
                      context,
                      "M",
                      mondayOpenController,
                      mondayCloseController,
                      mondayIsOpen,
                    ),
                    timings(
                      context,
                      "T",
                      tuesdayOpenController,
                      tuesdayCloseController,
                      tuesdayIsOpen,
                    ),
                    timings(
                      context,
                      "W",
                      wednesdayOpenController,
                      wednesdayCloseController,
                      wednesdayIsOpen,
                    ),
                    timings(
                      context,
                      "T",
                      thursdayOpenController,
                      thursdayCloseController,
                      thursdayIsOpen,
                    ),
                    timings(
                      context,
                      "F",
                      fridayOpenController,
                      fridayCloseController,
                      fridayIsOpen,
                    ),
                    timings(
                      context,
                      "S",
                      saturdayOpenController,
                      saturdayCloseController,
                      saturdayIsOpen,
                    ),

                    SizedBox(
                      height: 10.h,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        heading(title: 'House No, Building Name *'),
                        CustomTextField(
                          isenable: true,
                          onChanged: (Value) {
                            productSetUpController.updateButtonState();
                          },
                          hintText: '',
                          height: 55.h,
                          width: 330.w,
                          controller: houseNoController,
                        ),
                      ],
                    ),

                    SizedBox(
                      height: 10.h,
                    ),
                    heading(title: 'Street Name, Area*'),
                    SizedBox(
                      height: 5.h,
                    ),
                    CustomTextField(
                        isenable: true,
                        onChanged: (Value) {
                          productSetUpController.updateButtonState();
                        },
                        controller: streetController,
                        hintText: "",
                        height: 48.h,
                        width: 330.w),

                    SizedBox(
                      height: 10.h,
                    ),
                    // heading(title: 'Landmark'),
                    // SizedBox(
                    //   height: 5.h,
                    // ),
                    // CustomTextField(
                    //     isenable: true,
                    //     onChanged: (Value) {
                    //       productSetUpController.updateButtonState();
                    //     },
                    //     controller:
                    //         productSetUpController.landMarkController.value,
                    //     hintText: "",
                    //     height: 48.h,
                    //     width: 330.w),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            heading(title: 'Country *'),
                            SizedBox(
                              height: 5.h,
                            ),
                            Container(
                              height: 48.h,
                              width: 160.w,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5.0),
                                border:
                                    Border.all(width: 1, color: Colors.grey),
                              ),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  value: 'India',
                                  icon: const Icon(Icons.arrow_drop_down),
                                  iconSize: 24,
                                  elevation: 16,
                                  style: const TextStyle(
                                      color: Colors.black, fontSize: 16.0),
                                  onChanged: (String? newValue) {
                                    // Since there's only one option, this won't actually change anything
                                    // But you can add logic here if needed in the future
                                  },
                                  items: <String>['India']
                                      .map<DropdownMenuItem<String>>(
                                          (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                ),
                              ),
                            )
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 10.h),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              heading(title: 'Pincode *'),
                              SizedBox(
                                height: 5.h,
                              ),
                              Container(
                                height: 48.h,
                                width: 160.w,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5.0),
                                  border:
                                      Border.all(width: 1, color: Colors.grey),
                                ),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: TextField(
                                    onTap: () {
                                      // Get.toNamed(RouteName.changeLocation);
                                    },
                                    keyboardType: TextInputType.number,
                                    controller: pinCodeController,
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      hintStyle: TextStyle(color: Colors.grey),
                                    ),
                                    style: const TextStyle(fontSize: 16.0),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            heading(title: 'State *'),
                            SizedBox(
                              height: 5.h,
                            ),
                            Container(
                              height: 48.h,
                              width: 160.w,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5.0),
                                border:
                                    Border.all(width: 1, color: Colors.grey),
                              ),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  value: 'Telangana',
                                  icon: const Icon(Icons.arrow_drop_down),
                                  iconSize: 24,
                                  elevation: 16,
                                  style: const TextStyle(
                                      color: Colors.black, fontSize: 16.0),
                                  onChanged: (String? newValue) {
                                    // Since there's only one option, this won't actually change anything
                                    // But you can add logic here if needed in the future
                                  },
                                  items: <String>['Telangana']
                                      .map<DropdownMenuItem<String>>(
                                          (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                ),
                              ),
                            )
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 10.h),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              heading(title: 'City / District *'),
                              SizedBox(
                                height: 5.h,
                              ),
                              Container(
                                height: 48.h,
                                width: 160.w,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5.0),
                                  border:
                                      Border.all(width: 1, color: Colors.grey),
                                ),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: TextField(
                                    onTap: () {
                                      // Get.toNamed(RouteName.changeLocation);
                                    },
                                    controller: cityController,
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      hintStyle: TextStyle(color: Colors.grey),
                                    ),
                                    style: const TextStyle(fontSize: 16.0),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),

                    SizedBox(
                      height: 10.h,
                    ),

                    heading(title: 'Your Store Location *'),
                    SizedBox(
                      height: 10.h,
                    ),

                    Container(
                      height: 48.h,
                      width: 330.w,
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        border: Border.all(width: 1, color: Colors.grey),
                      ),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: TextField(
                          onTap: () {
                            Get.toNamed(RouteName.changeLocation);
                          },
                          controller:
                              dialogBoxController.locacationController.value,
                          decoration: const InputDecoration(
                            hintText: 'Point Your location',
                            border: InputBorder.none,
                            hintStyle: TextStyle(color: Colors.grey),
                          ),
                          style: const TextStyle(fontSize: 16.0),
                        ),
                      ),
                    ),

                    SizedBox(
                      height: 10.h,
                    ),

                    InkWell(
                      onTap: () async {
                        await dialogBoxController.getCurrentLocation();
                        Get.to(const GoogleMapPage());
                        productSetUpController.updateButtonState();
                      },
                      child: Text(
                        "Use my current location",
                        style: TextStyles.openSansUnderLine(
                            color: const Color(0xffFC8019),
                            fontWeight: FontWeight.normal),
                      ),
                    ),
                    SizedBox(
                      height: 30.h,
                    ),

                    Padding(
                      padding: EdgeInsets.only(right: 20.w),
                      child: SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () async {
                            Map<String, double> convertedAddressToLatLong =
                                await convertAddressToLatLong(
                                    dialogBoxController
                                        .locacationController.value.text);
                            Map<String, dynamic> data = {
                              "StoreName": storeNameController.text,
                              "storeCategory": categorySelected.isEmpty
                                  ? widget.storeCategory
                                  : categorySelected,
                              "storeSubCategory": subCategorySelected.isEmpty
                                  ? widget.storeSubcategory
                                  : subCategorySelected,
                              "About_the_store": aboutYourStoreController.text,
                              "youtubelink": ytController.text,
                              "instagarmlink": iGController.text,
                              "Websitelink": wLController.text,
                              "StreetNo_BuildingName": houseNoController.text,
                              "StreetName_Area": streetController.text,
                              "Brands": brandsController.text,
                              "timings": {
                                "Sunday": {
                                  "open": sundayOpenController.text,
                                  "close": sundayCloseController.text
                                },
                                "Monday": {
                                  "open": mondayOpenController.text,
                                  "close": mondayCloseController.text
                                },
                                "Tuesday": {
                                  "open": tuesdayOpenController.text,
                                  "close": tuesdayCloseController.text
                                },
                                "Wednesday": {
                                  "open": wednesdayOpenController.text,
                                  "close": wednesdayCloseController.text
                                },
                                "Thursday": {
                                  "open": thursdayOpenController.text,
                                  "close": thursdayCloseController.text
                                },
                                "Friday": {
                                  "open": fridayOpenController.text,
                                  "close": fridayCloseController.text
                                },
                                "Saturday": {
                                  "open": saturdayOpenController.text,
                                  "close": saturdayCloseController.text
                                }
                              },
                              "Postcode_ZIP": pinCodeController.text,
                              "sellerLocation": {
                                "latitude":
                                    convertedAddressToLatLong["latitude"]
                                        .toString(),
                                "longitude":
                                    convertedAddressToLatLong["longitude"]
                                        .toString()
                              }
                            };

                            if (removedImdexs.isNotEmpty) {
                              try {
                                await restClient.deleteImageInEditStore({
                                  "StoreID": widget.storeID,
                                  "imageIndices": removedImdexs,
                                });
                              } catch (e) {
                                Logger().d(e);

                                // Note: We're not returning here, so it will continue to edit
                              }
                            }

                            dio.FormData formDatatoPost =
                                await convertToMultipart(localImageFiles);
                            try {
                              await postdio.editProfileImage(
                                  widget.storeID, formDatatoPost);
                            } catch (e) {
                              Logger().f(e);
                            }

                            try {
                              await restClient.editStore(widget.storeID, data);
                              Fluttertoast.showToast(
                                  msg: "Store updated successfully");
                            } catch (e) {}

                            Get.back();
                            Get.back();
                          },
                          style: ElevatedButton.styleFrom(
                            side: const BorderSide(color: Color(0xffFC8019)),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            backgroundColor: const Color(0xffFC8019),
                            padding: EdgeInsets.all(
                              GlobalSizes.getDeviceWidth(context) * 0.04,
                            ),
                          ),
                          child: const Text(
                            "Update",
                            style: TextStyle(
                              fontSize: 18.0,
                              color: Colors.white, // Text color
                            ),
                          ),
                        ),
                      ),
                    ),

                    SizedBox(
                      height: 30.h,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String? getMimeType(String fileName) {
    final ext = path.extension(fileName).toLowerCase();
    switch (ext) {
      case '.jpg':
      case '.jpeg':
        return 'image/jpeg';
      case '.png':
        return 'image/png';
      case '.gif':
        return 'image/gif';
      case '.bmp':
        return 'image/bmp';
      case '.webp':
        return 'image/webp';
      default:
        return null;
    }
  }

  Future<dio.FormData> convertToMultipart(List<File> localImageFiles) async {
    var formData = dio.FormData();

    for (int i = 0; i < localImageFiles.length; i++) {
      File file = localImageFiles[i];
      String fileName = path.basename(file.path);
      String? mimeTypeString = getMimeType(file.path);

      MediaType? contentType;
      if (mimeTypeString != null) {
        List<String> mimeTypeParts = mimeTypeString.split('/');
        if (mimeTypeParts.length == 2) {
          contentType = MediaType(mimeTypeParts[0], mimeTypeParts[1]);
        }
      }

      formData.files.add(MapEntry(
        "images",
        await dio.MultipartFile.fromFile(
          file.path,
          filename: fileName,
          contentType: contentType,
        ),
      ));
    }

    return formData;
  }

  Padding timings(
      BuildContext context,
      String day,
      TextEditingController openTime,
      TextEditingController closeTime,
      RxBool isOpen) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.h),
      child: Obx(() => Row(
            children: [
              CircleAvatar(
                backgroundColor: const Color(0xffFC8019),
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: const Color(0xffE0E0E0),
                      width: 2.0,
                    ),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    day,
                    style: const TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 10.w),
              timeEditingBox(
                controller: openTime,
                context: context,
                hintText: 'Open',
                enabled: isOpen.value,
              ),
              SizedBox(width: 10.w),
              timeEditingBox(
                controller: closeTime,
                context: context,
                hintText: 'Close ',
                enabled: isOpen.value,
              ),
              SizedBox(width: 10.w),
              Flexible(
                child: Switch(
                  value: isOpen.value,
                  onChanged: (value) {
                    isOpen.value = value;
                    if (!value) {
                      openTime.clear();
                      closeTime.clear();
                    }
                  },
                  activeColor: const Color(0xffFC8019),
                  inactiveTrackColor: const Color(0xff939393),
                  inactiveThumbColor: Colors.white,
                ),
              ),
            ],
          )),
    );
  }

  InkWell addImages(BuildContext context) {
    return InkWell(
      onTap: () async {
        final result = await showDialog<String>(
          context: context,
          builder: (BuildContext context) {
            return const PickImageDialog(
              heading: 'upload your stote image',
            );
          },
        );
        if (result != null) {
          productSetUpController.imagePaths.add(result);
          if (productSetUpController.imagePaths.length == 1) {
            productSetUpController.staredImage.add(result);
          }
        }
      },
      child: Center(
        child: Container(
          height: 100.h,
          width: 150.w,
          decoration: BoxDecoration(
            border: Border.all(
              color: const Color(0xffC4C4C4), // Border color
              width: 1.0.w, // Border width
            ),
            borderRadius: BorderRadius.circular(10.0.r), // Border radius
          ),
          child: Padding(
            padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.01),
            child: Column(
              children: [
                SizedBox(
                  height: 20.h,
                ),
                SvgPicture.asset(
                  "assest/camera_orange.svg",
                  height: 30.h,
                  width: 50.w, // Corrected spelling of "assets"
                  // Adjust height as needed
                ),
                SizedBox(
                  height: 5.h,
                ),
                Text(
                  "Add your store images *",
                  style: TextStyles.openSans(
                      fontWeight: FontWeight.w400,
                      fontSize: 10.sp,
                      color: const Color(0xffFC8019)),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget timeEditingBox({
    required TextEditingController controller,
    required BuildContext context,
    required String hintText,
    required bool enabled,
  }) {
    return ValueListenableBuilder<TextEditingValue>(
      valueListenable: controller,
      builder: (context, value, child) {
        return SizedBox(
          width: 120.w,
          child: TextFormField(
            controller: controller,
            enabled: enabled,
            readOnly: true,
            decoration: InputDecoration(
              hintText: hintText,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            onTap: enabled
                ? () async {
                    TimeOfDay? pickedTime = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                    );
                    if (pickedTime != null) {
                      String formattedTime = pickedTime.format(context);
                      controller.text = formattedTime;
                    }
                  }
                : null,
          ),
        );
      },
    );
  }

  Container socialLinkBox(
      {required TextEditingController controller,
      required String imagePath,
      required String platform}) {
    return Container(
      height: 50.h,
      width: 330.w,
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        border: Border.all(width: 1, color: Colors.grey),
      ),
      child: Align(
        alignment: Alignment.centerLeft,
        child: TextField(
          controller: controller,
          decoration: InputDecoration(
            prefixIcon: SizedBox(
              height: 10.h,
              width: 10.h,
              child: Image.asset(
                imagePath,
              ),
            ),
            hintText: "paste the $platform link",
            border: InputBorder.none,
            hintStyle: const TextStyle(color: Colors.grey),
          ),
          style: const TextStyle(fontSize: 16.0),
        ),
      ),
    );
  }

  Text heading({required String title}) {
    return Text(
      title,
      style: TextStyles.openSans(
          fontSize: 14.sp,
          fontWeight: FontWeight.w600,
          color: const Color(0xff313333)),
    );
  }

  showIndicator() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        productSetUpController.imagePaths.length,
        (index) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0),
          child: Obx(
            () => Container(
              height: 8.h,
              width: 8.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: index == currentPage.value ? Colors.black : Colors.grey,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CustomMultiSelectDropdown extends StatefulWidget {
  final List<String> items;
  final List<dynamic> preSelectedItems;
  final Function(List<String>) onSelectionChanged;

  const CustomMultiSelectDropdown({
    super.key,
    required this.items,
    required this.preSelectedItems,
    required this.onSelectionChanged,
  });

  @override
  _CustomMultiSelectDropdownState createState() =>
      _CustomMultiSelectDropdownState();
}

class _CustomMultiSelectDropdownState extends State<CustomMultiSelectDropdown> {
  late List<String> _selectedItems;

  @override
  void initState() {
    super.initState();
    _selectedItems = List.from(widget.preSelectedItems);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 6.0,
          runSpacing: 6.0,
          children: _selectedItems.map((item) => _buildTag(item)).toList(),
        ),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(4),
          ),
          child: DropdownButton<String>(
            isExpanded: true,
            hint: const Text("Select Subcategories"),
            underline: const SizedBox(),
            icon: const Icon(Icons.arrow_drop_down),
            value: null,
            items: widget.items
                .where((item) => !_selectedItems.contains(item))
                .map((String item) {
              return DropdownMenuItem<String>(
                value: item,
                child: Text(item),
              );
            }).toList(),
            onChanged: (String? newValue) {
              if (newValue != null && !_selectedItems.contains(newValue)) {
                _selectedItems.add(newValue);

                widget.onSelectionChanged(_selectedItems);
              }
            },
          ),
        ),
      ],
    );
  }

  Widget _buildTag(String item) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFFFC8019), // Orange color
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            item,
            style: const TextStyle(color: Colors.white),
          ),
          const SizedBox(width: 4),
          GestureDetector(
            onTap: () {
              _selectedItems.remove(item);

              widget.onSelectionChanged(_selectedItems);
            },
            child: const Icon(
              Icons.close,
              size: 16,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

Future<Map<String, double>> convertAddressToLatLong(String address) async {
  try {
    List<Location> locations = await locationFromAddress(address);

    if (locations.isNotEmpty) {
      Location location = locations.first;
      double latitude = location.latitude;
      double longitude = location.longitude;

      print('Latitude: $latitude, Longitude: $longitude');
      return {"latitude": latitude, "longitude": longitude};
      // You can now use these latitude and longitude values as needed
      // For example, you might want to store them in variables or send them to an API
    } else {
      print('No coordinates found for the given address.');
      return {"latitude": 0, "longitude": 0};
    }
  } catch (e) {
    print('Error occurred while converting address to coordinates: $e');
    return {"latitude": 0, "longitude": 0};
  }
}
