import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sample_application/models/students_model.dart';
import 'package:sample_application/utils/api_support.dart';

class StudentProvider extends ChangeNotifier {
  bool isLoading = false;
  StudentsModel? studentsModelData;

  Future<void> getStudent() async {
    isLoading = true;
    notifyListeners();
    Uri url = Uri.parse(Apis.baseUrl + Apis.getStudentUrl);
    var response = await http.get(url);
    log(response.body);

    if (response.statusCode == 200) {
      String respString = response.body;
      studentsModelData = studentsModelFromJson(respString);
      isLoading = false;
      notifyListeners();
    } else {
      log('error');
      isLoading = false;
      notifyListeners();
    }
  }
}
