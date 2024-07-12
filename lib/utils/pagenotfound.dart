import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:lottie/lottie.dart';

class Pagenotfound extends StatelessWidget {
  const Pagenotfound({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
            height: 100.h,
            width: 100.h,
            child: Lottie.asset(
              'assest/Animation - 1720682163540.json',
              fit: BoxFit.cover,
            )),
      ),
    );
  }
}
