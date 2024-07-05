import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../controllers/acceptedTabSellerCotroller.dart';
import '../../../utils/components/sellerScreenTiles/accepted_tile.dart';
import '../../../utils/components/textstyle.dart';

class AcceptedTabSeller extends StatelessWidget {
  const AcceptedTabSeller({super.key});

  @override
  Widget build(BuildContext context) {
    Acceptedtabsellercotroller acceptedtabsellercotroller =
        Get.put(Acceptedtabsellercotroller());
    return Obx(() {
      return acceptedtabsellercotroller.isLoading.value
          ? Scaffold(
              backgroundColor: const Color(0xffFC8019),
              body: Center(
                child: LoadingAnimationWidget.inkDrop(
                    color: const Color(0xffE4E4E4), size: 200),
              ),
            )
          : Column(
              children: [
                Expanded(
                  flex: 12,
                  child: acceptedtabsellercotroller.sentItems.isEmpty
                      ? Center(
                          child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset('assest/empty.png'),
                            SizedBox(
                              height: 10.sp,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Text(
                                "No Requirement Yet.Tickk is working for ABC Store to get Request",
                                style: TextStyles.openSans(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14.sp,
                                    color: const Color(0xff4A4A4A)),
                              ),
                            ),
                          ],
                        ))
                      : ListView.builder(
                          itemCount:
                              acceptedtabsellercotroller.sentItems.length,
                          itemBuilder: (context, index) {
                            var data =
                                acceptedtabsellercotroller.sentItems[index];
                            return Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: AcceptedSellerCard(
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
                                quote: data.quote,
                              ),
                            );
                          }),
                ),
              ],
            );
    });
  }
}
