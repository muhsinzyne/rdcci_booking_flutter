// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bookingBranch.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookingBranch _$BookingBranchFromJson(Map<String, dynamic> json) {
  return BookingBranch()
    ..branchId = json['BranchId'] as String
    ..branchNameArabic = json['BranchNameArabic'] as String
    ..branchNameEnglish = json['BranchNameEnglish'] as String
    ..addressEnglish = json['AddressEnglish'] as String
    ..addressArabic = json['AddressArabic'] as String;
}

Map<String, dynamic> _$BookingBranchToJson(BookingBranch instance) => <String, dynamic>{
      'BranchId': instance.branchId,
      'BranchNameArabic': instance.branchNameArabic,
      'BranchNameEnglish': instance.branchNameEnglish,
      'AddressEnglish': instance.addressEnglish,
      'AddressArabic': instance.addressArabic
    };
