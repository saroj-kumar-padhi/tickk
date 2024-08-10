import 'dart:convert';

import 'package:dekhlo/controllers/sortDialogBoxController.dart';
import 'package:dekhlo/utils/components/textstyle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';
import 'package:logger/web.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;

import '../../../controllers/productSetupController.dart';
import '../../google_map_page.dart';

class ChangeLocation extends StatefulWidget {
  const ChangeLocation({super.key});

  @override
  State<ChangeLocation> createState() => _ChangeLocationState();
}

class _ChangeLocationState extends State<ChangeLocation> {
  late DialogBoxController dialogBoxController;
  late ProductSetUpController productSetUpController;
  late TextEditingController localController;

  final FocusNode locationFocusNode = FocusNode();
  final String _sessionToken = const Uuid().v4();
  List<dynamic> _placesList = [];

  @override
  void initState() {
    super.initState();
    dialogBoxController = Get.find<DialogBoxController>();
    productSetUpController = Get.find<ProductSetUpController>();
    localController = TextEditingController(
        text: dialogBoxController.locacationController.value.text);

    localController.addListener(onChange);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        FocusScope.of(context).requestFocus(locationFocusNode);
      }
    });
  }

  @override
  void dispose() {
    localController.removeListener(onChange);
    localController.dispose();
    locationFocusNode.dispose();
    super.dispose();
  }

  void onChange() {
    if (mounted) {
      getSuggestion(localController.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.arrow_back, color: Color(0xff313333)),
        ),
        centerTitle: true,
        title: Text(
          "Set location",
          style: TextStyles.openSans(
            fontWeight: FontWeight.w600,
            fontSize: 17.sp,
            color: const Color(0xff313333),
          ),
        ),
      ),
      body: ListView(
        children: [
          Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Container(
                  height: 40.h,
                  width: 400.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: GooglePlaceAutoCompleteTextField(
                    textEditingController: localController,
                    googleAPIKey: "AIzaSyBneuGjYhCSkfB3K4gULsLoq2XMwY2bu94",
                    inputDecoration: const InputDecoration(
                      prefixIcon: Icon(Icons.search_rounded),
                    ),
                    debounceTime: 800,
                    countries: const ["in"],
                    isLatLngRequired: true,
                    getPlaceDetailWithLatLng: (Prediction prediction) async {
                      await _fetchPlaceDetails(prediction.placeId ?? "");
                    },
                    itemClick: (Prediction prediction) async {
                      if (mounted) {
                        localController.text = prediction.description ?? "";
                        localController.selection = TextSelection.fromPosition(
                          TextPosition(offset: prediction.description!.length),
                        );

                        // Update the dialogBoxController with the selected prediction
                        dialogBoxController.locacationController.value.text =
                            prediction.description ?? "";

                        await _fetchPlaceDetails(prediction.placeId ?? "");

                        Get.back();
                      }
                    },
                    itemBuilder: (context, index, Prediction prediction) {
                      return Container(
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          children: [
                            const Icon(Icons.location_on),
                            const SizedBox(width: 7),
                            Expanded(child: Text(prediction.description ?? "")),
                          ],
                        ),
                      );
                    },
                    seperatedBuilder: const Divider(),
                    isCrossBtnShown: true,
                    containerHorizontalPadding: 10,
                  ),
                ),
              ),
              InkWell(
                onTap: () async {
                  await dialogBoxController.getCurrentLocation();
                  Get.to(const GoogleMapPage());
                  productSetUpController.updateButtonState();
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      "Use my current location",
                      style: TextStyles.openSansUnderLine(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: const Color(0xffFC8019),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  void getSuggestion(String input) async {
    String kplacesApiKey = "AIzaSyBneuGjYhCSkfB3K4gULsLoq2XMwY2bu94";
    String baseURL =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json';
    String request =
        '$baseURL?input=$input&key=$kplacesApiKey&sessiontoken=$_sessionToken';
    var response = await http.get(Uri.parse(request));
    Logger().d(response.body.toString());
    if (response.statusCode == 200 && mounted) {
      setState(() {
        _placesList = jsonDecode(response.body.toString())['predictions'];
      });
    } else if (response.statusCode != 200) {
      throw Exception('Failed to load data');
    }
  }

  Future<void> _fetchPlaceDetails(String placeId) async {
    String apiKey = "AIzaSyBneuGjYhCSkfB3K4gULsLoq2XMwY2bu94";
    String url =
        'https://maps.googleapis.com/maps/api/place/details/json?placeid=$placeId&key=$apiKey';

    var response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      var location = json['result']['geometry']['location'];
      double latitude = location['lat'];
      double longitude = location['lng'];

      // Update the DialogBoxController with the correct coordinates
      dialogBoxController.updateLocationFromCoordinates(latitude, longitude);

      // Move the camera to the selected location
      dialogBoxController.moveCameraToLocation(latitude, longitude);
    } else {
      Logger().d("errre ");
    }
  }
}
