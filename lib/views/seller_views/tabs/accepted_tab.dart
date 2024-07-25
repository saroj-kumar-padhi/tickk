import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:lottie/lottie.dart';

import '../../../controllers/acceptedTabSellerCotroller.dart';
import '../../../utils/components/sellerScreenTiles/accepted_tile.dart';
import '../../../utils/components/textstyle.dart';

class AcceptedTabSeller extends StatelessWidget {
  final String storeName;
  final String storeId;
  const AcceptedTabSeller(
      {super.key, required this.storeName, required this.storeId});

  @override
  Widget build(BuildContext context) {
    Acceptedtabsellercotroller acceptedtabsellercotroller =
        Get.put(Acceptedtabsellercotroller(storeId));
    return Obx(() {
      return acceptedtabsellercotroller.isLoading.value
          ? Scaffold(
              body:
                  Center(child: LottieBuilder.asset("assest/mX2qe5gUvP.json")),
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
                                "No Requirement Yet.Tickk is working for $storeName to get Request",
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
                                image: data.addImage,
                                exactImage: data.exactSimilarImage,
                                exact: data.exact,
                              ),
                            );
                          }),
                ),
              ],
            );
    });
  }
}
