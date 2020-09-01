import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';

import "bookingBranch.dart";
import "bookingServices.dart";

part 'bookingData.g.dart';

@JsonSerializable()
class BookingData {
  var dateFormat = DateFormat.yMMMMd('en_US');

  BookingData();

  num id;
  num nationalIdOrIQAMA;
  String visitorName;
  String bookingDate;
  String bookingSlot;
  String emailAddress;
  num branchId;
  String english;
  num branchAvailabilityTimeSlotId;
  num status;
  String qrCode;
  BookingBranch bookingBranch;
  List<BookingServices> bookingServices;

  // optional

  String bookingBranchArabic;
  String bookingBranchEnglish;
  List<BookingServices> services;

  String get formattedDate {
    var parsedDate = DateTime.parse(this.bookingDate);
    return dateFormat.format(parsedDate);
  }

  String serviceNames(lang) {
    var names = '';
    this.bookingServices.forEach((element) {
      BookingServices serviceItem = element;
      if (serviceItem.otherServiceText != '') {
        names += serviceItem.otherServiceText;
        names += ' \n';
      } else {
        if (lang == 'en') {
          names += serviceItem.serviceNameEnglish;
          names += ' \n';
        } else {
          names += serviceItem.serviceNameArabic;
          names += ' \n';
        }
      }
    });
    return names;
  }

  String serviceNameForManage(lang) {
    var names = '';
    this.services.forEach((element) {
      BookingServices serviceItem = element;
      if (lang == 'en') {
        names += serviceItem.serviceNameEnglish;
        names += ' \n';
      } else {
        names += serviceItem.serviceNameArabic;
        names += ' \n';
      }
    });
    return names;
  }

  factory BookingData.fromJson(Map<String, dynamic> json) => _$BookingDataFromJson(json);
  Map<String, dynamic> toJson() => _$BookingDataToJson(this);
}
