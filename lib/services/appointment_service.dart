import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:rdcciappointment/models/branchListResponse.dart';
import 'package:rdcciappointment/models/index.dart';
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

  Future<TimeSlotResponse> getTimeSlots({@required branchId, @required date}) async {
    http.Response response = await http.get(API + 'slot/GetSlotsByBranchResult?Id=' + branchId + '&date=' + date);
    if (response.statusCode == 200) {
      final parsedJson = jsonDecode(response.body);
      if (parsedJson.length > 0) {
        final TimeSlotResponse data = TimeSlotResponse.fromJson({"slots": parsedJson});
        return data;
      } else {
        print("error gose");
        return TimeSlotResponse.fromJson({});
      }
    } else {
      throw Exception();
    }
  }
}
