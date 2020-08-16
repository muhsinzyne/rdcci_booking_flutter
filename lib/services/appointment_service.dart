import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:rdcciappointment/models/branchListResponse.dart';
import 'package:rdcciappointment/models/services/serviceListBranch.dart';

class AppointmentServices {
  static const API = 'http://10.3.1.50:88/Api/';
  static const headers = {'token': ''};

  Future<ServiceListBranch> getBranchServices({id = null}) async {
    http.Response response = await http.get(API + '/branch/' + id.toString());
    if (response.statusCode == 200) {
      final parsedJson = jsonDecode(response.body);
      print(parsedJson);
      if (parsedJson.length > 0) {
        var data = ServiceListBranch.fromJson(parsedJson[0]);
        return data;
      } else {
        throw Exception();
      }
    } else {
      throw Exception();
    }
  }

  Future<BranchListResponse> getBranch() async {
    http.Response response = await http.get(API + '/branch');
    if (response.statusCode == 200) {
      final parsedJson = jsonDecode(response.body);
      return BranchListResponse.fromJson({"data": parsedJson});
    } else {
      throw Exception();
    }
  }
}
