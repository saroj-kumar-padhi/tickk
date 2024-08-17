import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../../controllers/dealDoneSellerController.dart';
import '../../../utils/components/sellerScreenTiles/done_done.dart';
import '../../../utils/components/textstyle.dart';

class DealDoneTabSeller extends StatelessWidget {
  final String storeName;
  final String storeId;

  const DealDoneTabSeller({
    super.key,
    required this.storeName,
    required this.storeId,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<Dealdonesellercontroller>(
      init: Dealdonesellercontroller(StoreId: storeId),
      builder: (controller) {
        return RefreshIndicator(
          onRefresh: controller.refreshData,
          child: Obx(() {
            if (controller.isLoading.value) {
              return Center(
                  child: LottieBuilder.asset("assest/mX2qe5gUvP.json"));
            } else if (controller.processedItems.isEmpty) {
              return ListView(
                // Wrap with ListView to make it scrollable
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.2),
                  emptyStateBuild(),
                ],
              );
            } else {
              return buildListState(controller);
            }
          }),
        );
      },
    );
  }

  Widget buildListState(Dealdonesellercontroller dealdonesellercontroller) {
    return ListView.builder(
      itemCount: dealdonesellercontroller.processedItems.length,
      itemBuilder: (context, index) {
        var data = dealdonesellercontroller.processedItems[index];
        return Padding(
          padding: const EdgeInsets.all(10.0),
          child: DoneDoneSellerCard(
            yourName: data.yourName,
            category: data.storeCategory,
            subCategories: data.storeSubCategory,
            brands: data.brands,
            date: data.date,
            modelNo: data.modelNo,
            oty: data.quantity.toString(),
            size: data.size.toString(),
            units: data.units,
            des: data.requirementInDetails,
            quote: data.quote.toString(),
            addImages: data.addImage,
            exactImages: data.exactImgages,
            exact: data.exact,
            addImage: data.addImage,
            requirementId: data.requirementId,
            profileImage: data.profileImage,
          ),
        );
      },
    );
  }

  Widget emptyStateBuild() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset('assest/empty.png'),
        SizedBox(height: 10.sp),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            "No Requirement Yet. Tickk is working for $storeName to get Request",
            style: TextStyles.openSans(
              fontWeight: FontWeight.w600,
              fontSize: 14.sp,
              color: const Color(0xff4A4A4A),
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
