import 'dart:convert';

import 'package:dekhlo/controllers/sortDialogBoxController.dart';
import 'package:dekhlo/utils/components/textstyle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:logger/web.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;

class ChangeLocation extends StatefulWidget {
  ChangeLocation({super.key});
  DialogBoxController dialogBoxController = Get.put(DialogBoxController());
  var uuid = const Uuid();
  final String _sessionToken = '123456';
  List<dynamic> _placesList = [];
  final FocusNode locationFocusNode = FocusNode();

  @override
  State<ChangeLocation> createState() => _ChangeLocationState();
}

class _ChangeLocationState extends State<ChangeLocation> {
  @override
  void initState() {
    // TODO: implement initState
    widget.dialogBoxController.addListener(() {
      onChange();
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).requestFocus(widget.locationFocusNode);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Color(0xff313333),
            )),
        centerTitle: true,
        title: Text(
          "Set location",
          style: TextStyles.openSans(
              fontWeight: FontWeight.w600,
              fontSize: 17.sp,
              color: const Color(0xff313333)),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Material(
              elevation: 3,
              child: Container(
                height: 40.h,
                width: 400.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.w),
                      child: const Icon(Icons.search, color: Colors.grey),
                    ),
                    Expanded(
                      child: TextField(
                        focusNode: widget.locationFocusNode,
                        controller:
                            widget.dialogBoxController.locacationController,
                        onChanged: (val) {
                          onChange();
                        },
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText:
                              'Search by area, landmark, street address... ',
                          hintStyle: TextStyles.openSans(
                              fontWeight: FontWeight.w600,
                              fontSize: 12.sp,
                              color: const Color(0xffC4C4C4)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Text(
                "Use my current location",
                style: TextStyles.openSansUnderLine(
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    color: const Color(0xffFC8019)),
              ),
            ),
          )
        ],
      ),
    );
  }

  void onChange() {
    getSuggestion(widget.dialogBoxController.locacationController.text);
  }

  void getSuggestion(String input) async {
    String kplacesApiKey = "AIzaSyBaZWnJ0KrnuL_ile3HbJwrtD_zspXj0Lw";
    String baseURL =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json';
    String requrest =
        '$baseURL?input=$input&key=$kplacesApiKey&sessiontoken=$kplacesApiKey&sessiontoken=${widget._sessionToken}';
    var response = await http.get(Uri.parse(requrest));
    Logger().d(response.body.toString());
    if (response.statusCode == 200) {
      setState(() {
        widget._placesList =
            jsonDecode(response.body.toString())['predictions'];
      });
    } else {
      throw Exception('Failed to load data');
    }
  }
}
