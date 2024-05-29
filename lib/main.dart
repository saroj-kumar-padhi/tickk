import 'package:dekhlo/views/seller_views/seller_home_screens/seller_new.dart';
import 'package:dekhlo/views/seller_views/set_up_product.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:dekhlo/utils/routes/routes_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(DevicePreview(builder: (context) {
    return const MyApp();
  }));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      // Set design size based on your project needs (e.g., 360x640)
      designSize: const Size(360, 742),
      minTextAdapt: true,
      builder: (BuildContext context, child) => GetMaterialApp(
        locale: DevicePreview.locale(context),
        builder: DevicePreview.appBuilder,
        theme: ThemeData(
          useMaterial3: false,

          primaryColor: Colors.white, // Set primary color to white
          appBarTheme: const AppBarTheme(
            backgroundColor:
                Colors.white, // Set app bar background color to white
          ),
          scaffoldBackgroundColor:
              Colors.white, // Set scaffold background color to white
          // Set accent color to black
        ),
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        home: const HomeSeller(),
        getPages: AppPages.pages,
      ),
    );
  }
}

// import 'package:dekhlo/views/login.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';

// import 'package:dekhlo/utils/routes/routes_controller.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return ScreenUtilInit(
//       // Set design size based on your project needs (e.g., 360x640)
//       designSize: const Size(360, 742),
//       minTextAdapt: true,
//       builder: (BuildContext context, child) => GetMaterialApp(
//         theme: ThemeData(
//           useMaterial3: false,
//           primaryColor: Colors.white, // Set primary color to white
//           appBarTheme: const AppBarTheme(
//             backgroundColor:
//                 Colors.white, // Set app bar background color to white
//           ),
//           scaffoldBackgroundColor:
//               Colors.white, // Set scaffold background color to white
//         ),
//         debugShowCheckedModeBanner: false,
//         title: 'Flutter Demo',
//         home: const Login(),
//         getPages: AppPages.pages,
//       ),
//     );
//   }
// }
