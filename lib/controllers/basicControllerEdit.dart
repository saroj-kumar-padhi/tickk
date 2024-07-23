import 'dart:io';

import 'package:dekhlo/models/basicDetailsEdit.dart';
import 'package:dekhlo/services/injection.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:logger/logger.dart';
import 'package:path/path.dart' as path;
import 'package:dio/dio.dart' as dio;
import 'package:http_parser/http_parser.dart' show MediaType;

class BasiccontrollerEdit extends GetxController {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  @override
  void onInit() async {
    final box = Hive.box('myBox');
    final String formattedPhoneNumber = box.get('phone');
    Logger().d(formattedPhoneNumber);
    await fetchBasicDetailsEdit(mobile: formattedPhoneNumber);
    super.onInit();
  }

  var response = BasicDataModelEdit(
    id: '',
    mobile: '',
    yourName: '',
    email: '',
    gender: '',
    age: 0,
    verified: false,
    v: 0,
    profileImage: '',
  ).obs;

  var isLoading = false.obs;

  Future<void> fetchBasicDetailsEdit({required String mobile}) async {
    isLoading(true);
    try {
      final data = await restClient.fetchBasicDetails(int.parse(mobile));
      response.value = data;
      isLoading(false);
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    } finally {
      isLoading(false);
    }
    isLoading(false);
  }

  Future<void> updateProfileData(
      String mobile, Map<String, dynamic> data) async {
    isLoading(true);
    try {
      final box = Hive.box('myBox');
      final String formattedPhoneNumber = box.get('phone');

      var formData = dio.FormData();

      // Add other fields from the data map
      data.forEach((key, value) {
        if (key != 'profileImage') {
          formData.fields.add(MapEntry(key, value.toString()));
        }
      });

      // Add profile image if present
      if (data.containsKey('profileImage')) {
        File file = File(data['profileImage']);
        String fileName = path.basename(file.path);
        String? mimeType = getMimeType(fileName);

        formData.files.add(MapEntry(
          "profileImage",
          await dio.MultipartFile.fromFile(
            file.path,
            filename: fileName,
            contentType: mimeType != null ? MediaType.parse(mimeType) : null,
          ),
        ));
      }

      await postdio.updateProfileData(
          int.parse(formattedPhoneNumber), formData);

      Fluttertoast.showToast(msg: "Profile updated successfully");
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    } finally {
      isLoading(false);
    }
  }

  String? getMimeType(String fileName) {
    final ext = path.extension(fileName).toLowerCase();
    switch (ext) {
      case '.jpg':
      case '.jpeg':
        return 'image/jpeg';
      case '.png':
        return 'image/png';
      case '.gif':
        return 'image/gif';
      case '.bmp':
        return 'image/bmp';
      case '.webp':
        return 'image/webp';
      default:
        return null;
    }
  }
}
