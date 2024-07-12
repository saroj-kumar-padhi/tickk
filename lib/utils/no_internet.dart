import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:lottie/lottie.dart';

class NoInternet extends StatelessWidget {
  const NoInternet({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
            height: 100.h,
            width: 100.h,
            child: Lottie.asset(
              'assest/Animation - 1720680711808.json',
              fit: BoxFit.cover,
            )),
      ),
    );
  }
}
