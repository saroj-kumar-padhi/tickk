import 'dart:io';
import 'package:dekhlo/utils/components/textstyle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../size/global_size/global_size.dart';

class SupportDialogBox extends StatelessWidget {
  const SupportDialogBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: SingleChildScrollView(
        child: Stack(
          children: [
            Positioned(
              top: 0.0,
              right: 0.0,
              child: GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.close,
                    size: 24.0,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        bottom: GlobalSizes.getDeviceHeight(context) * 0.01),
                    child: Text(
                      "For Support Contact us",
                      style: TextStyles.openSans(
                          fontSize: 14, fontWeight: FontWeight.w600),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                          onTap: () {
                            launchWhatsAppSupport();
                          },
                          child: Image.asset("assest/whatapp.png")),
                      SizedBox(
                        width: 20.w,
                      ),
                      InkWell(
                          onTap: () {
                            launchEmailSupport();
                          },
                          child: Image.asset("assest/email.png")),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Future<void> launchEmailSupport() async {
  final Uri emailLaunchUri = Uri(
    scheme: 'mailto',
    path: 'support@tickk.in',
    query: encodeQueryParameters(<String, String>{
      'subject': 'Support Request for Tickk Request',
      'body': '''
Hello Tickk Support Team,

'''
    }),
  );

  try {
    if (await canLaunchUrl(emailLaunchUri)) {
      await launchUrl(emailLaunchUri);
    } else {
      throw 'Could not launch email client';
    }
  } catch (e) {
    print('Error launching email: $e');
    Get.snackbar(
        'Error', 'Could not open email client. Please try again later.');
  }
}

String? encodeQueryParameters(Map<String, String> params) {
  return params.entries
      .map((MapEntry<String, String> e) =>
          '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
      .join('&');
}

Future<void> launchWhatsAppSupport() async {
  const phoneNumber = '9573704231'; // Include country code
  const message = '''
Hello Tickk Support Team,
''';

  final url = Uri.parse('whatsapp://send?phone=$phoneNumber&text=$message');

  try {
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      // WhatsApp is not installed, try web URL
      final webUrl = Uri.parse(
          'https://wa.me/$phoneNumber/?text=${Uri.encodeComponent(message)}');
      if (await canLaunchUrl(webUrl)) {
        await launchUrl(webUrl);
      } else {
        throw 'Could not launch WhatsApp or WhatsApp Web';
      }
    }
  } catch (e) {
    print('Error launching WhatsApp: $e');
    // You can show an error message to the user here
    Get.snackbar(
        'Error', 'Could not open WhatsApp. Please make sure it\'s installed.');
  }
}
