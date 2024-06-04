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

  final RxList<String> imagePaths = <String>[
    "assest/book_store.png",
    "assest/book_store.png",
    "assest/book_store.png"
  ].obs;
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
                                            child: Image.asset(
                                              imagePath,
                                              fit: BoxFit.cover,
                                            ),
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
                          ValueItem(label: 'Clothes', value: '1'),
                          ValueItem(label: 'Shoes', value: '2'),
                          ValueItem(label: 'Cosmetics', value: '3'),
                          ValueItem(
                            label: 'Custom Category',
                            value: 4,
                          ), // Custom Category option
                        ],
                        maxItems: 3,
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
                          ValueItem(label: 'subCat1', value: '1'),
                          ValueItem(label: 'subCat2', value: '2'),
                          ValueItem(label: 'subCat3', value: '3'),
                          ValueItem(label: 'Custom sub category', value: '4'),
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
                          ValueItem(label: 'subsubCat1', value: '1'),
                          ValueItem(label: 'subsubCat2', value: '2'),
                          ValueItem(label: 'subsubCat3', value: '3'),
                          ValueItem(
                              label: 'Custom sub sub category', value: '4'),
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
                    SizedBox(
                        height: 50.h,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: productSetUpController.dayList.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: EdgeInsets.symmetric(horizontal: 2.w),
                                child: SizedBox(
                                    height: 10.h,
                                    width: 50.w,
                                    child: Obx(
                                      () => InkWell(
                                        onTap: () {
                                          productSetUpController
                                              .updateButtonState();
                                          productSetUpController
                                              .toggleSelection(index);
                                        },
                                        child: CircleAvatar(
                                          backgroundColor:
                                              productSetUpController
                                                      .selectedIndices
                                                      .contains(index)
                                                  ? const Color(0xffFC8019)
                                                  : Colors.transparent,
                                          child: Container(
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              border: Border.all(
                                                color: productSetUpController
                                                        .selectedIndices
                                                        .contains(index)
                                                    ? Colors.transparent
                                                    : const Color(0xffE0E0E0),
                                                width: 2.0,
                                              ),
                                            ),
                                            alignment: Alignment.center,
                                            child: Text(
                                              productSetUpController
                                                  .dayList[index],
                                              style: TextStyle(
                                                color: productSetUpController
                                                        .selectedIndices
                                                        .contains(index)
                                                    ? Colors.white
                                                    : Colors.black,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    )),
                              );
                            })),
                    SizedBox(
                      height: 10.h,
                    ),

                    timeEditingBox(
                        controller:
                            productSetUpController.openTimeEditingController,
                        context: context,
                        hintText: 'Open Timing'),
                    SizedBox(
                      height: 10.h,
                    ),
                    timeEditingBox(
                        controller:
                            productSetUpController.closeEditingController,
                        context: context,
                        hintText: 'Close Timing'),

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
                                onChanged: (Value) {
                                  productSetUpController.updateButtonState();
                                },
                                hintText: '',
                                height: 55.h,
                                width: 100.w,
                                controller:
                                    productSetUpController.pinCodeController,
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
                        onChanged: (Value) {
                          productSetUpController.updateButtonState();
                        },
                        controller: productSetUpController.colonyController,
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
                        onChanged: (Value) {
                          productSetUpController.updateButtonState();
                        },
                        controller: productSetUpController.landMarkController,
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
                          controller: dialogBoxController.locacationController,
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
                    InkWell(
                      onTap: () {
                        Get.toNamed(RouteName.logInphoneScreen);
                      },
                      child: Center(
                        child: Text.rich(
                          TextSpan(
                            text: 'Already have an account? ', // Default text
                            style: TextStyles.openSans(
                                fontSize: 16.sp,
                                fontWeight:
                                    FontWeight.w500), // Default text style
                            children: <TextSpan>[
                              TextSpan(
                                text: 'Login', // Text to be styled differently
                                style: TextStyles.openSans(
                                    color: const Color(0xffFC8019),
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight
                                        .w600), // Different text style
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
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
