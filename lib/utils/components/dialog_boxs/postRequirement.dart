import 'package:dekhlo/utils/components/buyerScreenTiles/send_tile.dart';
import 'package:dekhlo/utils/size/global_size/global_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../controllers/dropDownController.dart';
import '../buttons.dart';
import '../textstyle.dart';

class PostRequirementsDialog extends StatelessWidget {
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
      required this.image});

  @override
  Widget build(BuildContext context) {
    DropdownController dropdownController = DropdownController();
    return AlertDialog(
      contentPadding: EdgeInsets.zero, // Remove content padding
      titlePadding: const EdgeInsets.symmetric(
          horizontal: 20, vertical: 20), // Add title padding
      content: SingleChildScrollView(
        // Wrap content with SingleChildScrollView
        child: Column(
          children: [
            SendTile(
              category: category,
              subcategory: subcategory,
              subsubCategory: subsubCategory,
              brands: brands,
              modelNo: modelNo,
              size: size,
              quantity: quantity,
              units: units,
              description: description,
              image: image,
            ), // Ensure SendTile takes up available space
            SizedBox(height: 20.h),
            const Text(
                'Do you really want to send the requirement to all 25 shops ?'),
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
            dropdownController.postRequrements(
                brand: brands,
                modelNo: modelNo,
                quote: 5600,
                size: 9,
                quantity: 8,
                details: description,
                image: image,
                category: category,
                subcategory: subcategory,
                subsubCategory: subsubCategory,
                units: units);
          },
          buttonText: "Send",
          textColor: Colors.white,
        ),
      ],
    );
  }
}
