import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:dekhlo/controllers/productSetupController.dart';
import 'package:dekhlo/utils/components/coustoumTextField.dart';
import 'package:dekhlo/utils/components/textstyle.dart';
import 'package:dekhlo/utils/routes/routes_names.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';

import '../../../controllers/dropDownController.dart';
import '../../../controllers/exactController.dart';
import '../../../controllers/sortDialogBoxController.dart';
import '../../../utils/components/dialog_boxs/pick_diallo.dart';
import '../../../utils/coustoumDropDown.dart';
import '../../../utils/size/global_size/global_size.dart';

class StoreEditScreen extends StatelessWidget {
  StoreEditScreen({super.key});
  final DropdownController dropdownController = Get.put(DropdownController());
  static final MultiSelectController categorySelectController =
      MultiSelectController();
  final MultiSelectController languageSelectController =
      MultiSelectController();
  static final MultiSelectController subCategorySelectController =
      MultiSelectController();
  static final MultiSelectController subSubCategorySelectController =
      MultiSelectController();
  final ProductSetUpController productSetUpController =
      Get.put(ProductSetUpController());
  DialogBoxController dialogBoxController = Get.put(DialogBoxController());

  final ExactController exactController = Get.put(ExactController());

  final RxList<String> imagePaths = <String>[].obs;
  RxBool isLiked = false.obs;
  RxInt currentPage = 0.obs;
  @override
  Widget build(BuildContext context) {
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
                return imagePaths.value.isEmpty
                    ? addImages(context)
                    : Column(
                        children: [
                          CarouselSlider.builder(
                            options: CarouselOptions(
                              enableInfiniteScroll: false,
                              // enlargeCenterPage: true,
                              onPageChanged: (index, reason) {
                                currentPage.value = index;
                              },
                              viewportFraction: 0.4,
                              height: 160.0.h,
                            ),
                            itemCount: imagePaths.length,
                            itemBuilder: (BuildContext context,
                                int index, //ic_launcher
                                int realIndex) {
                              final String imagePath = imagePaths[index];
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
                                              isLiked.value
                                                  ? InkWell(
                                                      onTap: () {
                                                        isLiked.value =
                                                            !isLiked.value;
                                                      },
                                                      child: const Icon(
                                                        Icons.star,
                                                        color:
                                                            Color(0xffFFD361),
                                                      ),
                                                    )
                                                  : InkWell(
                                                      onTap: () {
                                                        isLiked.value =
                                                            !isLiked.value;
                                                      },
                                                      child: const Icon(
                                                        Icons.star_border,
                                                        color: Colors.grey,
                                                      ),
                                                    ),
                                              SizedBox(
                                                width: 80.w,
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  imagePaths.remove(imagePath);
                                                },
                                                child: const Icon(
                                                  Icons.cancel,
                                                  color: Color(0xff4A4A4A),
                                                ),
                                              )
                                            ],
                                          )))
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  imagePaths.value.length > 1
                                      ? showIndicator()
                                      : const SizedBox(),
                                ],
                              );
                            },
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          GestureDetector(
                            onTap: () async {
                              final result = await showDialog<String>(
                                context: context,
                                builder: (BuildContext context) {
                                  return const PickImageDialog();
                                },
                              );
                              if (result != null) {
                                imagePaths.add(result);
                              }
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4.r),
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
                                            color: const Color(0xffFC8019)))
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
                    heading(title: 'Store Name'),
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
                        isenable: true,
                        controller:
                            productSetUpController.nameEditingController,
                        hintText: "Enter your contact number",
                        height: 48.h,
                        width: 330.w),
                    SizedBox(
                      height: 10.h,
                    ),
                    heading(title: 'Store category'),
                    SizedBox(
                      height: 5.h,
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 20.w),
                      child: MultiSelectDropDown(
                        borderColor: Colors.grey,
                        borderWidth: 1,
                        borderRadius: 4.r,
                        selectedOptionTextColor: const Color(0xffFC8019),
                        clearIcon: const Icon(Icons.close_outlined),
                        controller: categorySelectController,
                        onOptionSelected: (options) {
                          debugPrint(options.toString());
                          if (options.contains(
                            const ValueItem(
                              label: 'Custom Category',
                              value: 4,
                            ),
                          )) {
                            Get.toNamed(RouteName.custoumCategory);
                          }
                        },
                        options: const <ValueItem>[
                          ValueItem(label: 'Electronics', value: '1'),
                          ValueItem(label: 'Fashion', value: '2'),
                          ValueItem(label: 'Sports', value: '3'),
                          ValueItem(label: 'Electricals', value: '4'),
                          ValueItem(label: 'Pet stores', value: '5'),
                          ValueItem(label: 'Medical', value: '6'),
                          ValueItem(label: 'Construction', value: '7'),
                          ValueItem(label: 'Gifts', value: '7'),

                          ValueItem(
                            label: 'Custom Category',
                            value: 8,
                          ), // Custom Category option
                        ],
                        maxItems: 7,
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
                    heading(title: 'Sub categories'),
                    SizedBox(
                      height: 5.h,
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 20.w),
                      child: MultiSelectDropDown(
                        borderColor: Colors.grey,
                        borderWidth: 1,
                        borderRadius: 4.r,
                        selectedOptionTextColor: const Color(0xffFC8019),
                        clearIcon: const Icon(Icons.close_outlined),
                        controller: subCategorySelectController,
                        onOptionSelected: (options) {
                          debugPrint(options.toString());
                          if (options.contains(
                            const ValueItem(
                                label: 'Custom sub category', value: '4'),
                          )) {
                            Get.toNamed(RouteName.custoumSubCategory);
                          }
                        },
                        options: const <ValueItem>[
                          ValueItem(
                              label: 'Mobile phones and accessories',
                              value: '1'),
                          ValueItem(
                              label: 'Laptops, computers, and accessories',
                              value: '2'),
                          ValueItem(label: 'Home appliances', value: '3'),
                          ValueItem(label: 'Kitchen appliances', value: '4'),
                          ValueItem(label: "Head phones", value: '5'),
                          ValueItem(label: "Smart watches", value: '6'),
                          ValueItem(label: "Video games", value: '7'),
                          ValueItem(label: "Tablets", value: '8'),
                          ValueItem(label: "Home audio", value: '9'),
                          ValueItem(label: "Grooming appliances", value: '10'),
                          ValueItem(label: "Women's clothing", value: '11'),
                          //Faction
                          ValueItem(label: "Women's clothing", value: '12'),
                          ValueItem(label: "Men's clothing", value: '13'),
                          ValueItem(label: "Kids fashion", value: '14'),
                          ValueItem(label: "Beauty and makeup", value: '15'),
                          ValueItem(label: "Shoes and footwear", value: '16'),
                          ValueItem(
                              label: "Bags, wallets and luggage", value: '17'),
                          ValueItem(label: "Watches", value: '18'),
                          ValueItem(label: "Jewellery", value: '19'),
                          ValueItem(
                              label: "Women's lingerie and sleepwear",
                              value: '20'),
                          ValueItem(label: "Men's boutique", value: '21'),
                          ValueItem(label: "Women's clothing", value: '22'),
                          ValueItem(label: "Unisex boutique", value: '23'),
                          //Electricals
                          ValueItem(label: "Fancy lights", value: '24'),
                          ValueItem(label: "Fans", value: '25'),
                          ValueItem(label: "Lighting", value: '26'),
                          ValueItem(label: "Wiring", value: '27'),
                          ValueItem(label: "Switches", value: '28'),
                          //Pet stores
                          ValueItem(label: "Dogs", value: '29'),
                          ValueItem(label: "Cats", value: '30'),
                          ValueItem(label: "Fish & Aquatics", value: '31'),
                          ValueItem(label: "Birds", value: '32'),
                          ValueItem(label: "Cattle", value: '33'),
                          ValueItem(label: "Other pets", value: '34'),
                          //Medical
                          ValueItem(label: "Pharmacy", value: '35'),
                          ValueItem(
                              label: "Surgically & equipment", value: '36'),
                          //Gifts
                          ValueItem(label: "Books & Stationery", value: '37'),
                          ValueItem(label: "Toys", value: '38'),
                          ValueItem(label: "Home Decor", value: '39'),
                        ],
                        maxItems: 40,
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
                    heading(title: 'Sub Sub categories'),
                    SizedBox(
                      height: 5.h,
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 20.w),
                      child: MultiSelectDropDown(
                        borderColor: Colors.grey,
                        borderWidth: 1,
                        borderRadius: 4.r,
                        selectedOptionTextColor: const Color(0xffFC8019),
                        clearIcon: const Icon(Icons.close_outlined),
                        controller: subSubCategorySelectController,
                        onOptionSelected: (options) {
                          debugPrint(options.toString());
                          if (options.contains(
                            const ValueItem(
                                label: 'Custom sub sub category', value: '4'),
                          )) {
                            Get.toNamed(RouteName.custoumSubSubCategory);
                          }
                        },
                        options: const <ValueItem>[
                          ValueItem(label: 'Adult geared cycles', value: '1'),
                          ValueItem(
                              label: 'Adult non geared cycles', value: '2'),
                          ValueItem(label: 'Kids cycles', value: '3'),
                          ValueItem(label: 'Electric cycles', value: '4'),
                          ValueItem(
                              label: 'Cycling kits & accessories', value: '5'),

                          //Strength training
                          ValueItem(label: 'Dumbbells', value: '6'),
                          ValueItem(label: 'Home gym sets', value: '7'),
                          ValueItem(label: 'Benches', value: '8'),
                          ValueItem(
                              label: 'Wearable weights & accessories',
                              value: '9'),
                          ValueItem(
                              label: 'Multi gym functional trainers',
                              value: '10'),
                          ValueItem(label: 'Plates & barbells', value: '11'),
                          ValueItem(label: 'Kettle bells', value: '12'),
//Cardio
                          ValueItem(label: 'Treadmills', value: '13'),
                          ValueItem(label: 'Fitness bikes', value: '14'),
                          ValueItem(label: 'Ellipticals', value: '15'),
                          ValueItem(label: 'Rowers', value: '16'),
                          //Badminton
                          ValueItem(label: 'Racquets', value: '13'),
                          ValueItem(label: 'Shuttle cocks', value: '14'),
                          ValueItem(label: 'Badminton sets', value: '15'),
                          ValueItem(label: 'Badminton shoes', value: '16'),
                          ValueItem(label: 'Kit bags', value: '17'),
                          ValueItem(label: 'Accessories', value: '18'),
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
                    heading(title: 'Brands'),
                    SizedBox(
                      height: 5.h,
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 18.w),
                      child: CustomDropdownFormField(
                        items: dropdownController.subcategories,
                        onChanged: (value) {},
                        onSaved: (value) {},
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    heading(title: "About your store"),
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
                          controller:
                              productSetUpController.discriptionController,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(bottom: 60.h),
                            hintText:
                                "e.g This store has all the types of books.",
                            border: InputBorder.none,
                            hintStyle: const TextStyle(color: Colors.grey),
                          ),
                          style: const TextStyle(fontSize: 16.0),
                        ),
                      ),
                    ),

                    // social links
                    SizedBox(
                      height: 20.h,
                    ),
                    heading(title: "Link your social media accounts"),
                    SizedBox(
                      height: 5.h,
                    ),
                    socialLinkBox(
                        controller:
                            productSetUpController.youTubeEditingController,
                        imagePath: 'assest/you_tube.png'),

                    SizedBox(
                      height: 10.h,
                    ),
                    socialLinkBox(
                        controller:
                            productSetUpController.youTubeEditingController,
                        imagePath: 'assest/instagram.png'),
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
                    heading(title: "Timings"),
                    SizedBox(
                      height: 10.h,
                    ),

                    timmings(
                        context,
                        "S",
                        productSetUpController.sundayOpenTimeEditingController,
                        productSetUpController.sundayCloseEditingController),
                    timmings(
                        context,
                        "M",
                        productSetUpController.mondayOpenTimeEditingController,
                        productSetUpController.mondayCloseEditingController),
                    timmings(
                        context,
                        "T",
                        productSetUpController.tuesdayCloseEditingController,
                        productSetUpController.thursdayCloseEditingController),
                    timmings(
                        context,
                        "W",
                        productSetUpController
                            .wednesdayOpenTimeEditingController,
                        productSetUpController.wednesdayCloseEditingController),
                    timmings(
                        context,
                        "T",
                        productSetUpController
                            .thursdayOpenTimeEditingController,
                        productSetUpController.thursdayCloseEditingController),
                    timmings(
                        context,
                        "F",
                        productSetUpController.fridayOpenTimeEditingController,
                        productSetUpController.fridayCloseEditingController),
                    timmings(
                        context,
                        "S",
                        productSetUpController
                            .saturdayOpenTimeEditingController,
                        productSetUpController.saturdayCloseEditingController),

                    SizedBox(
                      height: 10.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            heading(title: 'Building No.'),
                            CustomTextField(
                              isenable: true,
                              onChanged: (Value) {
                                productSetUpController.updateButtonState();
                              },
                              hintText: '',
                              height: 55.h,
                              width: 100.w,
                              controller:
                                  productSetUpController.buildingController,
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 20.h),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              heading(title: 'Pincode'),
                              CustomTextField(
                                isenable: true,
                                onChanged: (Value) {
                                  productSetUpController.updateButtonState();
                                },
                                hintText: '',
                                height: 55.h,
                                width: 100.w,
                                controller: productSetUpController
                                    .pinCodeController.value,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    SizedBox(
                      height: 10.h,
                    ),
                    heading(title: 'Area/Colony Name'),
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
                    heading(title: 'Landmark'),
                    SizedBox(
                      height: 5.h,
                    ),
                    CustomTextField(
                        isenable: true,
                        onChanged: (Value) {
                          productSetUpController.updateButtonState();
                        },
                        controller:
                            productSetUpController.landMarkController.value,
                        hintText: "",
                        height: 48.h,
                        width: 330.w),

                    SizedBox(
                      height: 10.h,
                    ),

                    heading(title: 'Your Store Location'),
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
                            hintText: 'e.g Delhi',
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

                    Text(
                      "Use my current location",
                      style: TextStyles.openSansUnderLine(
                          color: const Color(0xffFC8019),
                          fontWeight: FontWeight.normal),
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
                                    Get.toNamed(RouteName.sellerHome);
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

  Padding timmings(BuildContext context, String day,
      TextEditingController openTime, TextEditingController closeTime) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.h),
      child: Row(
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
          SizedBox(
            width: 10.w,
          ),
          timeEditingBox(
              controller: openTime, context: context, hintText: 'Open Timing'),
          SizedBox(
            width: 10.w,
          ),
          timeEditingBox(
              controller: closeTime,
              context: context,
              hintText: 'Close Timing'),
        ],
      ),
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
          imagePaths.add(result);
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
                  "Add your store images",
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

  Container timeEditingBox({
    required TextEditingController controller,
    required BuildContext context,
    required String hintText,
  }) {
    return Container(
      height: 48.h,
      width: 130.w,
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
            suffixIcon: InkWell(
              onTap: () async {
                TimeOfDay? selectedTime = await showTimePicker(
                  helpText: '',
                  initialEntryMode: TimePickerEntryMode.input,
                  context: context,
                  initialTime: TimeOfDay.now(),
                  builder: (BuildContext context, Widget? child) {
                    return MediaQuery(
                      data: MediaQuery.of(context).copyWith(
                        alwaysUse24HourFormat: false,
                      ),
                      child: Theme(
                        data: Theme.of(context).copyWith(
                          textTheme: Theme.of(context).textTheme.copyWith(
                                bodySmall: const TextStyle(
                                  fontSize: 22,
                                  color: Colors.black,
                                ),
                              ),
                        ),
                        child: child!,
                      ),
                    );
                  },
                );

                if (selectedTime != null) {
                  // Set the selected time to the controller
                  String formattedTime =
                      '${selectedTime.hour.toString().padLeft(2, '0')}:${selectedTime.minute.toString().padLeft(2, '0')}';
                  controller.text = formattedTime;
                }
              },
              child: SizedBox(
                height: 10.h,
                width: 10.h,
                child: Image.asset(
                  "assest/calendar_icon.png",
                ),
              ),
            ),
            hintText: hintText,
            border: InputBorder.none,
            hintStyle: const TextStyle(color: Colors.grey),
          ),
          style: const TextStyle(fontSize: 16.0),
        ),
      ),
    );
  }

  Container socialLinkBox(
      {required TextEditingController controller, required String imagePath}) {
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
            hintText: "paste the link",
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
        imagePaths.length,
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
