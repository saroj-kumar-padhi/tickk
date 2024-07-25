import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:dekhlo/controllers/productSetupController.dart';
import 'package:dekhlo/utils/components/coustoumTextField.dart';
import 'package:dekhlo/utils/components/textstyle.dart';
import 'package:dekhlo/utils/routes/routes_names.dart';
import 'package:dekhlo/views/google_map_page.dart';
import 'package:dekhlo/views/seller_views/seller_home_screens/seller_home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:logger/web.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

import '../../controllers/categoriesController.dart';
import '../../controllers/dropDownController.dart';
import '../../controllers/exactController.dart';
import '../../controllers/sortDialogBoxController.dart';
import '../../utils/components/dialog_boxs/pick_diallo.dart';
import '../../utils/size/global_size/global_size.dart';

class SetUpProduct extends StatefulWidget {
  const SetUpProduct({super.key});
  static final MultiSelectController categorySelectController =
      MultiSelectController();
  static final MultiSelectController subCategorySelectController =
      MultiSelectController();
  static final MultiSelectController subSubCategorySelectController =
      MultiSelectController();

  @override
  State<SetUpProduct> createState() => _SetUpProductState();
}

class _SetUpProductState extends State<SetUpProduct> {
  List<String> SubCategoryItems = [];

  List<String> SubSubCategoryItems = [];

  List<dynamic> selectedSubCategoryItems = [];

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

  RxBool sundayIsOpen = true.obs;

  RxBool mondayIsOpen = true.obs;

  RxBool tuesdayIsOpen = true.obs;

  RxBool wednesdayIsOpen = true.obs;

  RxBool thursdayIsOpen = true.obs;

  RxBool fridayIsOpen = true.obs;

  RxBool saturdayIsOpen = true.obs;

  @override
  Widget build(BuildContext context) {
    final box = Hive.box('myBox');
    final String formattedPhoneNumber = box.get('phone') ?? "";
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
          "Setup your store",
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
                return productSetUpController.imagePaths.value.isEmpty
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
                            itemCount: productSetUpController.imagePaths.length,
                            itemBuilder: (BuildContext context, int index,
                                int realIndex) {
                              final String imagePath =
                                  productSetUpController.imagePaths[index];
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
                                            child: Image.file(File(imagePath),
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
                                                    productSetUpController
                                                        .imagePaths
                                                        .remove(imagePath);
                                                    if (productSetUpController
                                                        .staredImage
                                                        .contains(imagePath)) {
                                                      productSetUpController
                                                          .staredImage
                                                          .clear();
                                                    }
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
                          // Separate indicator widget
                          Obx(() => productSetUpController
                                      .imagePaths.value.length >
                                  1
                              ? Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: List.generate(
                                    productSetUpController.imagePaths.length,
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
                                  return const PickImageDialog();
                                },
                              );
                              if (result != null) {
                                productSetUpController.imagePaths.add(result);
                              }
                            },
                            child: productSetUpController.imagePaths.length > 3
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
                        controller:
                            productSetUpController.nameEditingController,
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
                    Padding(
                      padding: EdgeInsets.only(right: 20.w),
                      child: MultiSelectDropDown(
                        suffixIcon: const Icon(Icons.arrow_downward),
                        borderColor: Colors.grey,
                        borderWidth: 1,
                        borderRadius: 4.r,
                        selectedOptionTextColor: const Color(0xffFC8019),
                        clearIcon: const Icon(Icons.close_outlined),
                        controller: SetUpProduct.categorySelectController,
                        onOptionSelected: (options) {
                          debugPrint(options.toString());
                          List<String> selectedCategories =
                              options.map((option) => option.label).toList();

                          // Call fetchSetupSubcategories with the selected categories
                          categoriesController
                              .fetchSetupSubcategories(selectedCategories);

                          // if (options.contains(
                          //   const ValueItem(
                          //     label: 'Custom Category',
                          //     value: 8,
                          //   ),
                          // )) {
                          //   Get.toNamed(RouteName.custoumCategory);
                          // }
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

                    SizedBox(
                      height: 10.h,
                    ),
                    SubSubCategoryItems.isEmpty
                        ? Row(
                            children: [
                              Text(
                                "Sub categories",
                                style: TextStyles.openSans(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0xff313333)
                                        .withOpacity(0.5)),
                              ),
                              Text(
                                " (optional)",
                                style: TextStyles.openSans(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.grey),
                              ),
                            ],
                          )
                        : heading(title: 'Sub categories'),
                    SizedBox(
                      height: 5.h,
                    ),
                    Obx(() {
                      SubCategoryItems =
                          categoriesController.setupsubCategories.value;

                      return categoriesController.isLoading.value
                          ? const Center(child: CircularProgressIndicator())
                          : Padding(
                              padding: EdgeInsets.only(right: 20.w),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  border: Border.all(
                                      color: SubCategoryItems.isEmpty
                                          ? Colors.grey.shade300
                                          : Colors.grey),
                                ),
                                child: AbsorbPointer(
                                  absorbing: SubCategoryItems.isEmpty,
                                  child: Opacity(
                                    opacity:
                                        SubCategoryItems.isEmpty ? 0.5 : 1.0,
                                    child: MultiSelectDialogField<dynamic>(
                                      items: SubCategoryItems.map((item) =>
                                          MultiSelectItem<dynamic>(
                                              item, item)).toList(),
                                      title:
                                          const Text("Select Sub Categories"),
                                      selectedColor: const Color(0xffFC8019),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(4),
                                        color: Colors.white,
                                      ),
                                      buttonText:
                                          const Text("Select Sub Categories"),
                                      onConfirm: (values) {
                                        if (SubCategoryItems.isNotEmpty) {
                                          categoriesController
                                              .fetchSubSubsetUpCategories(
                                                  values.cast<String>());

                                          Logger().d(values);
                                          // Store the selected values in a separate list if needed
                                          selectedSubCategoryItems.clear();
                                          selectedSubCategoryItems = values
                                              .map((value) => ValueItem(
                                                    label: value.toString(),
                                                    value: value,
                                                  ))
                                              .toList();

                                          // Update the subCategorySelectController
                                          SetUpProduct
                                              .subCategorySelectController
                                              .setSelectedOptions(
                                            values
                                                .map((value) => ValueItem(
                                                      label: value.toString(),
                                                      value: value,
                                                    ))
                                                .toList(),
                                          );
                                        }
                                      },
                                      chipDisplay: MultiSelectChipDisplay(
                                        onTap: (item) {
                                          if (SubCategoryItems.isNotEmpty) {
                                            List<ValueItem> currentOptions =
                                                SetUpProduct
                                                    .subCategorySelectController
                                                    .selectedOptions;
                                            currentOptions.removeWhere(
                                                (option) =>
                                                    option.value == item);
                                            SetUpProduct
                                                .subCategorySelectController
                                                .setSelectedOptions(
                                                    currentOptions);

                                            selectedSubCategoryItems =
                                                currentOptions;
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
                    SubSubCategoryItems.isEmpty
                        ? Row(
                            children: [
                              Text(
                                "Sub Sub categories",
                                style: TextStyles.openSans(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0xff313333)
                                        .withOpacity(0.5)),
                              ),
                              Text(
                                " (optional)",
                                style: TextStyles.openSans(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.grey),
                              ),
                            ],
                          )
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
                                    opacity:
                                        SubSubCategoryItems.isEmpty ? 0.5 : 1.0,
                                    child: MultiSelectDialogField<String>(
                                      items: SubSubCategoryItems.map(
                                          (subSubCategory) =>
                                              MultiSelectItem<String>(
                                                  subSubCategory,
                                                  subSubCategory)).toList(),
                                      title: const Text(
                                          "Select Sub Sub Categories"),
                                      selectedColor: const Color(0xffFC8019),
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
                                        if (SubSubCategoryItems.isNotEmpty) {
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
                                          if (values
                                              .contains('Electric cycles')) {
                                            Get.toNamed(RouteName
                                                .custoumSubSubCategory);
                                          }
                                          categoriesController
                                              .fetchSubSubsetUpCategories(
                                                  values);
                                        }
                                      },
                                      chipDisplay: MultiSelectChipDisplay(
                                        onTap: (value) {
                                          // Store the selected values in a separate list if needed

                                          if (SubSubCategoryItems.isNotEmpty) {
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
                                                        .map((option) => option
                                                            .value
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
                        controller: productSetUpController.brandsController,
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
                          controller:
                              productSetUpController.discriptionController,
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
                        controller:
                            productSetUpController.youTubeEditingController,
                        imagePath: 'assest/you_tube.png',
                        platform: 'youtube'),

                    SizedBox(
                      height: 10.h,
                    ),
                    socialLinkBox(
                        controller: productSetUpController.instagram,
                        imagePath: 'assest/instagram.png',
                        platform: 'instagram'),
                    SizedBox(
                      height: 10.h,
                    ),
                    socialLinkBox(
                        controller: productSetUpController.website,
                        imagePath: 'assest/internet.png',
                        platform: 'Website'),
                    SizedBox(
                      height: 10.h,
                    ),
                    heading(title: "Languages you know"),
                    SizedBox(
                      height: 10.h,
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 20.w),
                      child: MultiSelectDropDown(
                        borderColor: Colors.grey,
                        borderWidth: 1,
                        borderRadius: 4.r,
                        selectedOptionTextColor:
                            const Color(0xffFC8019).withOpacity(0.1),
                        clearIcon: const Icon(Icons.close_outlined),
                        controller: languageSelectController,
                        onOptionSelected: (options) {
                          debugPrint(options.toString());
                        },
                        options: const <ValueItem>[
                          ValueItem(label: 'Bangla', value: '1'),
                          ValueItem(label: 'English', value: '2'),
                          ValueItem(label: 'Gujarati', value: '3'),
                          ValueItem(label: 'Hindi', value: '4'),
                          ValueItem(label: 'Kannada', value: '5'),
                          ValueItem(label: 'Marathi', value: '6'),
                          ValueItem(label: 'Malayalam', value: '7'),
                          ValueItem(label: 'Punjabi', value: '8'),
                          ValueItem(label: 'Tamil', value: '9'),
                          ValueItem(label: 'Telugu', value: '10')
                        ],
                        maxItems: 3,
                        selectionType: SelectionType.multi,
                        chipConfig: const ChipConfig(
                            wrapType: WrapType.wrap,
                            backgroundColor: Color(0xffFC8019)),
                        dropdownHeight: 200.h,
                        optionTextStyle: TextStyle(fontSize: 16.sp),
                        selectedOptionIcon: const Icon(Icons.check_circle),
                      ),
                    ),

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
                        productSetUpController.sundayOpenTimeEditingController,
                        productSetUpController.sundayCloseEditingController,
                        sundayIsOpen),
                    timings(
                        context,
                        "M",
                        productSetUpController.mondayOpenTimeEditingController,
                        productSetUpController.mondayCloseEditingController,
                        mondayIsOpen),
                    timings(
                        context,
                        "T",
                        productSetUpController.tuesdayOpenTimeEditingController,
                        productSetUpController.tuesdayCloseEditingController,
                        tuesdayIsOpen),
                    timings(
                        context,
                        "W",
                        productSetUpController
                            .wednesdayOpenTimeEditingController,
                        productSetUpController.wednesdayCloseEditingController,
                        wednesdayIsOpen),
                    timings(
                        context,
                        "T",
                        productSetUpController
                            .thursdayOpenTimeEditingController,
                        productSetUpController.thursdayCloseEditingController,
                        thursdayIsOpen),
                    timings(
                        context,
                        "F",
                        productSetUpController.fridayOpenTimeEditingController,
                        productSetUpController.fridayCloseEditingController,
                        fridayIsOpen),
                    timings(
                        context,
                        "S",
                        productSetUpController
                            .saturdayOpenTimeEditingController,
                        productSetUpController.saturdayCloseEditingController,
                        saturdayIsOpen),

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
                          controller: productSetUpController.buildingController,
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
                        controller:
                            productSetUpController.colonyController.value,
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
                                    controller: productSetUpController
                                        .pinCodeController.value,
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
                                    controller: productSetUpController
                                        .cityController.value,
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
                        await dialogBoxController.getCurrentLoaction();
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

                    Obx(() {
                      return Padding(
                        padding: EdgeInsets.only(right: 20.w),
                        child: SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: productSetUpController
                                    .isButtonEnabled.value
                                ? () {
                                    List<String> brandsList =
                                        productSetUpController
                                            .brandsController.text
                                            .split(',')
                                            .map((brand) => brand.trim())
                                            .where((brand) => brand.isNotEmpty)
                                            .toList();
                                    productSetUpController.setupStrore(
                                        productSetUpController.imagePaths,
                                        SetUpProduct.categorySelectController
                                            .selectedOptions
                                            .map((item) => item.label)
                                            .toList(),
                                        // subCategorySelectController
                                        //     .selectedOptions
                                        //     .map((item) => item.label)
                                        //     .toList(),
                                        selectedSubCategoryItems,
                                        selectedSubSubCategoryItems,
                                        brandsList);
                                    // Get.toNamed(RouteName.sellerHome);

                                    exactController.isSeller.value = false;
                                  }
                                : null, // Disable the button if fields are not filled
                            style: ElevatedButton.styleFrom(
                              side: BorderSide(
                                color: const Color(0xffFC8019).withOpacity(
                                    productSetUpController.isButtonEnabled.value
                                        ? 1.0
                                        : 0.9),
                                width: 0,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              backgroundColor: const Color(0xffFC8019),
                              padding: EdgeInsets.all(
                                GlobalSizes.getDeviceWidth(context) * 0.04,
                              ),
                            ),
                            child: const Text(
                              "Next",
                              style: TextStyle(
                                fontSize: 18.0,
                                color: Colors.white, // Text color
                              ),
                            ),
                          ),
                        ),
                      );
                    }),

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
            return const PickImageDialog();
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
                      // Force refresh if using GetX
                      setState(() {});
                      // Or use setState if in a StatefulWidget
                      // setState(() {});
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
