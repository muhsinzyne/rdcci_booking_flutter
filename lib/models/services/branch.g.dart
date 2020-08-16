// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'branch.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Branch _$BranchFromJson(Map<String, dynamic> json) {
  return Branch()
    ..BranchId = json['BranchId'] as num
    ..BranchNameArabic = json['BranchNameArabic'] as String
    ..BranchNameEnglish = json['BranchNameEnglish'] as String;
}

Map<String, dynamic> _$BranchToJson(Branch instance) => <String, dynamic>{
      'BranchId': instance.BranchId,
      'BranchNameArabic': instance.BranchNameArabic,
      'BranchNameEnglish': instance.BranchNameEnglish
    };
