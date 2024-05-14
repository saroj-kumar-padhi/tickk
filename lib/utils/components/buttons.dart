import 'package:dekhlo/utils/size/global_size/global_size.dart';
import 'package:flutter/material.dart';

class Buttons {
  static Padding longButton(
      {required Color color,
      required BuildContext context,
      required VoidCallback onPressedCallback,
      required String buttonText,
      required Color textColor}) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: GlobalSizes.getDeviceWidth(context) * 0.05,
          vertical: GlobalSizes.getDeviceHeight(context) * 0.01),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: onPressedCallback,
          style: ElevatedButton.styleFrom(
            side: const BorderSide(
              color: Color(0xffFC8019),
              width: 0,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            backgroundColor: color,
            padding: EdgeInsets.all(GlobalSizes.getDeviceWidth(context) * 0.04),
          ),
          child: Text(
            buttonText,
            style: TextStyle(
              fontSize: 18.0,
              color: textColor, // Text color
            ),
          ),
        ),
      ),
    );
  }

  static Padding shortButton(
      {required Color color,
      required BuildContext context,
      required VoidCallback onPressedCallback,
      required String buttonText,
      required Color textColor}) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: GlobalSizes.getDeviceWidth(context) * 0.016,
        vertical: GlobalSizes.getDeviceHeight(context) * 0.009,
      ),
      child: SizedBox(
        width:
            GlobalSizes.getDeviceWidth(context) * 0.3, // Adjust width as needed
        height: GlobalSizes.getDeviceHeight(context) *
            0.05, // Adjust height as needed
        child: ElevatedButton(
          onPressed: onPressedCallback,
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            backgroundColor: color,
            padding: EdgeInsets.fromLTRB(
                GlobalSizes.getDeviceWidth(context) * -0.1,
                GlobalSizes.getDeviceHeight(context) * 0.001,
                GlobalSizes.getDeviceWidth(context) * -0.1,
                GlobalSizes.getDeviceHeight(context) * 0.001),
          ),
          child: Text(
            buttonText,
            style: TextStyle(
              fontSize: 16.0, // Adjust font size as needed
              color: textColor, // Text color
            ),
          ),
        ),
      ),
    );
  }

 static GestureDetector veryShortButton(
  {required Color color,
      required BuildContext context,
      required VoidCallback onPressedCallback,
      required String buttonText,
      required Color textColor}
 ){
  return GestureDetector(
      onTap: onPressedCallback,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.127,
        height: MediaQuery.of(context).size.height * 0.04,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Center(
          child: Text(
            buttonText,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 12, // Adjust font size as needed
              color: textColor,
            ),
          ),
        ),
      ),
    );
 }



}
