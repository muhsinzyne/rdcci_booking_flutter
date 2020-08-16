// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'branch.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Branch _$BranchFromJson(Map<String, dynamic> json) {
  return Branch()
    ..id = json['Id'] as num
    ..branchNameArabic = json['BranchNameArabic'] as String
    ..addressArabic = json['AddressArabic'] as String
    ..branchNameEnglish = json['BranchNameEnglish'] as String
    ..addressEnglish = json['AddressEnglish'] as String;
}

Map<String, dynamic> _$BranchToJson(Branch instance) => <String, dynamic>{
      'id': instance.id,
      'branchNameArabic': instance.branchNameArabic,
      'addressArabic': instance.addressArabic,
      'branchNameEnglish': instance.branchNameEnglish,
      'addressEnglish': instance.addressEnglish
    };
