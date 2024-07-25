import 'package:dekhlo/controllers/newTabController.dart';
import 'package:dekhlo/services/injection.dart';
import 'package:dekhlo/utils/components/buyerScreenTiles/send_tile.dart';
import 'package:dekhlo/utils/routes/routes_names.dart';
import 'package:dekhlo/utils/size/global_size/global_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:logger/logger.dart';

import '../../../controllers/basicControllerEdit.dart';
import '../../../controllers/categoriesController.dart';
import '../../../controllers/dropDownController.dart';
import '../../../services/notificationServices.dart';
import '../buttons.dart';
import '../textstyle.dart';

class PostRequirementsDialog extends StatefulWidget {
  final String category;
  final String subcategory;
  final String subsubCategory;
  final String brands;
  final String modelNo;
  final String size;
  final String quantity;
  final String units;
  final String description;
  final String image;
  final List fcm;

  const PostRequirementsDialog(
      {super.key,
      required this.category,
      required this.subcategory,
      required this.subsubCategory,
      required this.brands,
      required this.modelNo,
      required this.size,
      required this.quantity,
      required this.units,
      required this.description,
      required this.image,
      required this.fcm});

  @override
  State<PostRequirementsDialog> createState() => _PostRequirementsDialogState();
}

class _PostRequirementsDialogState extends State<PostRequirementsDialog> {
  @override
  void initState() {
    super.initState();
    fetchStoreCount();
  }

  CategoriesController categoriesController = Get.put(CategoriesController());
  int storeCount = 0;
  Future<void> fetchStoreCount() async {
    try {
      CountModel? countModel;
      if (widget.subcategory.isNotEmpty) {
        try {
          countModel =
              await restClient.fetchSubCategoriesCount(widget.subcategory);
        } catch (e) {
          Logger().d("Error fetching subcategory count: $e");
          // Optionally, you can set a default count or try fetching the category count instead
          // countModel = await restClient.fetchCategoriesCount(widget.category);
        }
      }

      countModel ??= await restClient.fetchCategoriesCount(widget.category);

      setState(() {
        storeCount = countModel?.count ?? 0;
      });
    } catch (e) {
      Logger().e('Error fetching store count: $e');
      setState(() {
        storeCount = 0; // Set a default value in case of error
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    DropdownController dropdownController = DropdownController();
    NewTabController newTabController = Get.put(NewTabController());
    BasiccontrollerEdit basiccontrollerEdit = Get.put(BasiccontrollerEdit());

    String subFormatted =
        widget.subsubCategory == '' ? "N/A" : widget.subsubCategory;
    return Obx(() => basiccontrollerEdit.isLoading.value
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : AlertDialog(
            contentPadding: EdgeInsets.zero, // Remove content padding
            titlePadding: const EdgeInsets.symmetric(
                horizontal: 20, vertical: 20), // Add title padding
            content: SingleChildScrollView(
              // Wrap content with SingleChildScrollView
              child: Column(
                children: [
                  SendTile(
                    category: widget.category,
                    subcategory: widget.subcategory,
                    subsubCategory: widget.subsubCategory,
                    brands: widget.brands,
                    modelNo: widget.modelNo,
                    size: widget.size,
                    quantity: widget.quantity,
                    units: widget.units,
                    description: widget.description,
                    image: widget.image,
                    storeCount: storeCount.toString(),
                  ), // Ensure SendTile takes up available space
                  SizedBox(height: 20.h),
                  Text(
                      'Do you really want to send the requirement to all $storeCount shops ?'),
                ],
              ),
            ),
            actions: <Widget>[
              InkWell(
                onTap: () {
                  Get.back();
                },
                child: Padding(
                  padding: EdgeInsets.only(
                    right: GlobalSizes.getDeviceWidth(context) * 0.007,
                    bottom: 0, // Add bottom padding
                  ),
                  child: Text(
                    "Cancel",
                    style: TextStyles.openSans(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xff979797),
                    ),
                  ),
                ),
              ),
              Buttons.shortButton(
                color: const Color(0xffFC8019),
                context: context,
                onPressedCallback: () {
                  dropdownController.postRequirements(
                      brand: widget.brands,
                      modelNo: widget.modelNo,
                      quote: 0,
                      size: widget.size,
                      quantity: int.parse(widget.quantity),
                      details: widget.description,
                      image: widget.image,
                      category: widget.category,
                      subcategory: widget.subcategory,
                      subsubCategory: subFormatted,
                      units: widget.units,
                      name: basiccontrollerEdit.response.value.yourName);
                  try {
                    restClient.putRequirementInSellerTab(
                        widget.category, widget.subcategory);
                    // PushNotificationServices.sendNotification(fcm, context,
                    //     "A new requirement has been Posted of requirement id $category please check it out");
                  } catch (e) {
                    Logger().d(e);
                  }
                  newTabController.fetchRequirements();
                  Get.toNamed(RouteName.homeBuyerScreen);
                },
                buttonText: "Send",
                textColor: Colors.white,
              ),
            ],
          ));
  }
}
