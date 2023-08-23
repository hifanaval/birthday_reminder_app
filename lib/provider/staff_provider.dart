import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sample_application/models/staff_model.dart';
import 'package:sample_application/utils/api_support.dart';

class StaffProvider extends ChangeNotifier {
  bool isLoading = false;
  StaffModel? staffModelData;

  Future<void> getStaff() async {
    isLoading = true;
    notifyListeners();
    Uri url = Uri.parse(Apis.baseUrl + Apis.getStaffUrl);
    var response = await http.get(url);
    log(response.body);

    if (response.statusCode == 200) {
      String respString = response.body;
      staffModelData = staffModelFromJson(respString);
      isLoading = false;
      notifyListeners();
    } else {
      log('error');
      isLoading = false;
      notifyListeners();
    }
  }
}
