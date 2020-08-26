import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:rdcciappointment/models/booking_confirm/bookingResponse.dart';
import 'package:rdcciappointment/models/branchListResponse.dart';
import 'package:rdcciappointment/models/index.dart';
import 'package:rdcciappointment/models/services/serviceListBranch.dart';
import 'package:rdcciappointment/models/validate_booking_id.dart';

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
      print(parsedJson);
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

  Future<BookingResponse> bookAppointment(bodyObject) async {
    print(bodyObject);
    http.Response response = await http.post(API + 'Booking', headers: {"Content-Type": "application/json"}, body: json.encode(bodyObject));
    if (response.statusCode == 200) {
      final parsedJson = jsonDecode(response.body);
      print(response.body);
      return BookingResponse.fromJson(parsedJson);
    } else {
      final parsedJson = jsonDecode(response.body);
      return BookingResponse.fromJson({});
      throw Exception();
    }
  }

  Future<ValidateBookingID> validateBookingId(nationalId) async {
    http.Response response = await http.get(API + 'Bookingdata/GetAppointmentBooking?NationalId_or_IQAMAId=' + nationalId);
    if (response.statusCode == 200) {
      final parsedJson = jsonDecode(response.body);
      if (parsedJson != null) {
        ValidateBookingID validateBookingID = ValidateBookingID.fromJSON(parsedJson);
        return validateBookingID;
      }
      return ValidateBookingID.fromJSON({});
    } else {
      throw Exception('Error in API Calll');
    }
  }

  Future<bool> cancelAppointment(bodyObject) async {
    http.Response response = await http.post(API + 'CancelAppointment', headers: {"Content-Type": "application/json"}, body: json.encode(bodyObject));
    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      print(responseData);
      return responseData;
    } else {
      return false;
      throw Exception('Error in API Calll');
    }
  }
}
