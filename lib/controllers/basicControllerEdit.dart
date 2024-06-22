import 'package:dekhlo/models/basicDetailsEdit.dart';
import 'package:dekhlo/services/injection.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class BasiccontrollerEdit extends GetxController {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  var response = BasicDataModelEdit(
    id: '',
    mobile: '',
    yourName: '',
    email: '',
    gender: '',
    age: 0,
    verified: false,
    v: 0,
  ).obs;

  var isLoading = false.obs;
  @override
  void onInit() async {
    await fetchBasicDetailsEdit(mobile: "1234567890");
    super.onInit();
  }

  Future<void> fetchBasicDetailsEdit({required String mobile}) async {
    isLoading(true);
    try {
      final data = await restClient.fetchBasicDetails(int.parse(mobile));
      response.value = data;
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    } finally {
      isLoading(false);
    }
  }

  Future<void> updateProfileData(
      String mobile, Map<String, dynamic> data) async {
    isLoading(true);
    try {
      await restClient.updateProfileData(int.parse(mobile), data);
      Fluttertoast.showToast(msg: "Profile updated successfully");
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    } finally {
      isLoading(false);
    }
  }
}
