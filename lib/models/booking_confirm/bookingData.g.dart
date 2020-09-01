// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bookingData.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookingData _$BookingDataFromJson(Map<String, dynamic> json) {
  return BookingData()
    ..id = json['Id'] as num
    ..nationalIdOrIQAMA = json['NationalIdOrIQAMA'] as num
    ..visitorName = json['VisitorName'] as String
    ..bookingDate = json['BookingDate'] as String
    ..bookingSlot = json['BookingSlot'] as String
    ..emailAddress = json['EmailAddress'] as String
    ..branchId = json['BranchId'] as num
    ..english = json['English'] as String
    ..branchAvailabilityTimeSlotId = json['BranchAvailabilityTimeSlotId'] as num
    ..status = json['Status'] as num
    ..qrCode = json['qrcodeval'] as String
    ..bookingBranch = json['bookingBranch'] == null ? null : BookingBranch.fromJson(json['bookingBranch'] as Map<String, dynamic>)
    ..bookingServices = (json['bookingServices'] as List)?.map((e) => e == null ? null : BookingServices.fromJson(e as Map<String, dynamic>))?.toList()
    ..bookingBranchArabic = json['BranchNameArabic'] as String
    ..bookingBranchEnglish = json['BranchNameEnglish'] as String
    ..services = (json['Services'] as List)?.map((e) => e == null ? null : BookingServices.fromJson(e as Map<String, dynamic>))?.toList();
}

Map<String, dynamic> _$BookingDataToJson(BookingData instance) => <String, dynamic>{
      'Id': instance.id,
      'NationalIdOrIQAMA': instance.nationalIdOrIQAMA,
      'VisitorName': instance.visitorName,
      'BookingDate': instance.bookingDate,
      'BookingSlot': instance.bookingSlot,
      'EmailAddress': instance.emailAddress,
      'BranchId': instance.branchId,
      'English': instance.english,
      'BranchAvailabilityTimeSlotId': instance.branchAvailabilityTimeSlotId,
      'Status': instance.status,
      'qrcodeval': instance.qrCode,
      'bookingBranch': instance.bookingBranch,
      'bookingServices': instance.bookingServices,
      'bookingBranchArabic': instance.bookingBranchArabic,
      'bookingBranchEnglish': instance.bookingBranchEnglish,
      'services': instance.services
    };
