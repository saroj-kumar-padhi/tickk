import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import '../../../controllers/categoriesController.dart';
import '../../../controllers/dropDownController.dart';
import '../../../utils/components/coustoumTextField.dart';
import '../../../utils/components/dialog_boxs/pick_diallo.dart';
import '../../../utils/components/dialog_boxs/postRequirement.dart';
import '../../../utils/components/heading.dart';
import '../../../utils/components/textstyle.dart';
import '../../../utils/coustoumDropDown.dart';

class PostRequirements extends StatefulWidget {
  const PostRequirements({super.key});

  @override
  _PostRequirementsState createState() => _PostRequirementsState();
}

class _PostRequirementsState extends State<PostRequirements> {
  final DropdownController dropdownController = Get.put(DropdownController());
  final TextEditingController brandController = TextEditingController();
  final TextEditingController modelController = TextEditingController();
  final TextEditingController sizeController = TextEditingController();
  final TextEditingController quntityController = TextEditingController();
  final TextEditingController commentsController = TextEditingController();
  final TextEditingController unitsController = TextEditingController();
  CategoriesController categoriesController = Get.put(CategoriesController());
  final RxString imagePath = ''.obs;
  RxBool isFormValid = false.obs;
  String selectedCity = '';

  @override
  initState() {
    super.initState();
    // categoriesController.selectedCategory.value = "";
    categoriesController.selectedSubCategory.value = "";
    categoriesController.selectedSubSubCategory.value = "";
  }

  @override
  Widget build(BuildContext context) {
    String removeExtraSpaces(String input) {
      // Remove leading and trailing spaces, then replace multiple spaces with a single space
      return input.trim().replaceAll(RegExp(r'\s+'), ' ');
    }

    return Obx(() => categoriesController.isLoading.value
        ? Scaffold(
            body: Center(child: LottieBuilder.asset("assest/mX2qe5gUvP.json")),
          )
        : Scaffold(
            appBar: AppBar(
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
                "Posting requirement",
                style: TextStyles.openSans(
                  fontWeight: FontWeight.w600,
                  fontSize: 17.sp,
                  color: const Color(0xff4A4A4A),
                ),
              ),
            ),
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: 28.w),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10.h,
                    ),
                    categoriesController.categories.isNotEmpty
                        ? Align(
                            alignment: Alignment.centerLeft,
                            child: Text("Category *",
                                style: TextStyles.openSans(
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0xff4A4A4A))),
                          )
                        : Align(
                            alignment: Alignment.centerLeft,
                            child: Text("Category",
                                style: TextStyles.openSans(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0xff959595))),
                          ),
                    SizedBox(
                      height: 5.h,
                    ),
                    CustomDropdownFormField(
                      items: categoriesController.categories,
                      value:
                          categoriesController.selectedCategory.value.isNotEmpty
                              ? categoriesController.selectedCategory.value
                              : null,
                      onChanged: (value) {
                        updateFormValidity();
                        categoriesController.selectedSubCategory.value = '';
                        categoriesController.selectedCategory.value =
                            value ?? "";
                        categoriesController.fetchSubcategories(
                          categoriesController.selectedCategory.value,
                        );
                      },
                    ),
                    // SizedBox(
                    //   height: 5.h,
                    // ),
                    categoriesController.subCategories.isNotEmpty
                        ? Align(
                            alignment: Alignment.centerLeft,
                            child: Text("Sub Category",
                                style: TextStyles.openSans(
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0xff4A4A4A))),
                          )
                        : const SizedBox(),
                    categoriesController.subCategories.isNotEmpty
                        ? SizedBox(
                            height: 5.h,
                          )
                        : const SizedBox(),
                    categoriesController.subCategories.isNotEmpty
                        ? CustomDropdownFormField(
                            items: categoriesController.subCategories,
                            value: categoriesController
                                    .selectedSubCategory.value.isNotEmpty
                                ? categoriesController.selectedSubCategory.value
                                : null,
                            onChanged: (value) {
                              categoriesController.selectedSubCategory.value =
                                  value ?? "";
                              categoriesController.fetchSubSubcategories(
                                  categoriesController.selectedCategory.value,
                                  value ?? "");
                            },
                          )
                        : const SizedBox(),
                    categoriesController.subCategories.isNotEmpty
                        ? SizedBox(
                            height: 5.h,
                          )
                        : const SizedBox(),
                    categoriesController.subSubCategories.isNotEmpty
                        ? Align(
                            alignment: Alignment.centerLeft,
                            child: Text("Sub Sub Category",
                                style: TextStyles.openSans(
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0xff4A4A4A))),
                          )
                        : const SizedBox(),
                    SizedBox(
                      height: 5.h,
                    ),
                    categoriesController.subSubCategories.isNotEmpty
                        ? CustomDropdownFormField(
                            items: categoriesController.subSubCategories,
                            onChanged: (value) {
                              dropdownController
                                  .changeSelectedSubSubcategory(value ?? "");

                              categoriesController
                                  .selectedSubSubCategory.value = value ?? "";
                            },
                            onSaved: (value) {},
                          )
                        : const SizedBox(),
                    SizedBox(
                      height: 5.h,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Row(
                        children: [
                          Text(
                            "Brand",
                            style: TextStyles.openSans(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xff4A4A4A),
                            ),
                          ),
                          Text(
                            "(optional)",
                            style: TextStyles.openSans(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xffA9A7A7),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    CustomTextField(
                      isenable: true,
                      controller: brandController,
                      hintText: '',
                      height: 55.h,
                      width: 300.w,
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Row(
                        children: [
                          Text(
                            "Model no",
                            style: TextStyles.openSans(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xff4A4A4A),
                            ),
                          ),
                          Text(
                            "(optional)",
                            style: TextStyles.openSans(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xffA9A7A7),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    CustomTextField(
                      isenable: true,
                      controller: modelController,
                      hintText: '',
                      height: 55.h,
                      width: 300.w,
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const SmallHeading(
                                  headingText: 'Size',
                                ),
                                Text(
                                  "(optional)",
                                  style: TextStyles.openSans(
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0xffA9A7A7),
                                  ),
                                ),
                              ],
                            ),
                            CustomTextField(
                              isenable: true,
                              controller: sizeController,
                              hintText: '',
                              height: 55.h,
                              width: 90.w,
                              keyboardType: TextInputType.text,
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SmallHeading(
                              headingText: 'Qty *',
                            ),
                            CustomTextField(
                              onChanged: (value) {
                                updateFormValidity();
                              },
                              isenable: true,
                              hintText: '',
                              height: 55.h,
                              width: 90.w,
                              controller: quntityController,
                              keyboardType: TextInputType.number,
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SmallHeading(
                              headingText: 'Units *',
                            ),
                            SizedBox(
                              height: 40.h,
                              width: 90.w,
                              child: CustomDropdownFormField(
                                items: const [
                                  'units',
                                  'kg',
                                  'gm',
                                  'ml',
                                  'liter',
                                  'mm',
                                  'cm',
                                  'ft',
                                  'meter',
                                  'sq.ft',
                                  'sq.meter',
                                  'bundle',
                                  'pair',
                                  'quintal',
                                  'ton',
                                  'inch'
                                ],
                                onChanged: (value) {
                                  updateFormValidity();
                                  dropdownController.selectedUnits.value =
                                      value ?? "";
                                },
                                onSaved: (value) {},
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    const SmallHeading(
                        headingText: "Enter your requirement in details *"),
                    SizedBox(
                      height: 5.h,
                    ),
                    Container(
                      height: 80.h,
                      width: 300.w,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8.r),
                        border: Border.all(color: const Color(0xffC4CDD5)),
                      ),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: TextField(
                          maxLines:
                              null, // This allows the field to expand vertically
                          keyboardType: TextInputType.multiline,
                          controller: commentsController,
                          decoration: InputDecoration(
                            hintText: '',
                            border: InputBorder.none,
                            hintStyle: TextStyle(
                              color: const Color(0xffD8D8D8),
                              fontSize: 16.sp,
                            ),
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 16.w, vertical: 16.h),
                          ),
                          style: TextStyle(fontSize: 16.sp),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Add your image *",
                        style: TextStyles.openSans(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xff4A4A4A),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Obx(
                      () => imagePath.value != ""
                          ? Stack(
                              children: [
                                Image.file(
                                  File(imagePath.value),
                                  width: 100.w,
                                  height: 100.h,
                                  fit: BoxFit.fill,
                                ),
                                Positioned(
                                  top: 5.h,
                                  right: 5.h,
                                  child: InkWell(
                                    onTap: () {
                                      imagePath.value = "";
                                      updateFormValidity();
                                    },
                                    child: Center(
                                        child: SvgPicture.asset(
                                      "assest/cross.svg",
                                      height: 20,
                                    )),
                                  ),
                                ),
                              ],
                            )
                          : GestureDetector(
                              onTap: () async {
                                final result = await showDialog<String>(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return const PickImageDialog(
                                      heading: 'Upload Product image',
                                    );
                                  },
                                );
                                if (result != null) {
                                  imagePath.value = result;
                                  updateFormValidity(); // Call updateFormValidity here
                                }
                              },
                              child: Row(
                                children: [
                                  const Center(
                                    child: Icon(
                                      Icons.add,
                                      color: Color(0xffFC8019),
                                    ),
                                  ),
                                  Text("Add Image",
                                      style: TextStyles.openSans(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w600,
                                          color: const Color(0xffFC8019)))
                                ],
                              ),
                            ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    const SmallHeading(
                        headingText: "Select your target City *"),
                    SizedBox(
                      height: 5.h,
                    ),
                    CustomDropdownFormField(
                      items: const ["Hyderabad"],
                      onChanged: (value) {
                        selectedCity = value ?? '';
                        updateFormValidity();
                      },
                      onSaved: (value) {
                        selectedCity = value ?? '';
                      },
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: 40.h,
                      child: ElevatedButton(
                        onPressed: () async {
                          if (isFormValid.value) {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return PostRequirementsDialog(
                                  category: categoriesController
                                      .selectedCategory.value,
                                  subcategory: categoriesController
                                      .selectedSubCategory.value,
                                  subsubCategory: categoriesController
                                      .selectedSubSubCategory.value,
                                  brands:
                                      removeExtraSpaces(brandController.text),
                                  modelNo:
                                      removeExtraSpaces(modelController.text),
                                  size: sizeController.text,
                                  quantity: quntityController.text,
                                  units: dropdownController.selectedUnits.value,
                                  description: removeExtraSpaces(
                                      commentsController.text.trim()),
                                  image: imagePath.value,
                                );
                              },
                            );
                          } else {
                            Fluttertoast.showToast(
                                msg: "Fill all required fields");
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          side: isFormValid.value
                              ? const BorderSide(
                                  color: Color(0xffFC8019),
                                  width: 0,
                                )
                              : null,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          backgroundColor: isFormValid.value
                              ? const Color(0xffFC8019)
                              : const Color(0xffFC8019).withOpacity(0.2),
                        ),
                        child: const Text(
                          "Send",
                          style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                  ],
                ),
              ),
            ),
          ));
  }

  void updateFormValidity() {
    isFormValid.value =
        categoriesController.selectedCategory.value.isNotEmpty &&
            quntityController.text.isNotEmpty &&
            imagePath.value.isNotEmpty &&
            selectedCity.isNotEmpty;
  }
}
