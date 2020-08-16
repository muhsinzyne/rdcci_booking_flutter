// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'serviceCategory.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ServiceCategory _$ServiceCategoryFromJson(Map<String, dynamic> json) {
  return ServiceCategory()
    ..categoryId = json['Categoryid'] as num
    ..categoryNameArabic = json['CategoryNameArabic'] as String
    ..categoryNameEnglish = json['CategoryNameEnglish'] as String
    ..services = (json['Services'] as List)?.map((e) => e == null ? null : Services.fromJson(e as Map<String, dynamic>))?.toList();
}

Map<String, dynamic> _$ServiceCategoryToJson(ServiceCategory instance) => <String, dynamic>{
      'categoryId': instance.categoryId,
      'categoryNameArabic': instance.categoryNameArabic,
      'categoryNameEnglish': instance.categoryNameEnglish,
      'services': instance.services
    };
