import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../controllers/sellerPandingController.dart';
import '../../../../utils/components/buyerScreenTiles/inprocess_tile.dart';

class InProcessTab extends StatelessWidget {
  const InProcessTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 12,
          child: ListView.builder(itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.all(10.0.h),
              child: const InprocessTile(),
            );
          }),
        ),
      ],
    );
  }
}
