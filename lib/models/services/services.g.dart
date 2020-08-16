// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'services.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Services _$ServicesFromJson(Map<String, dynamic> json) {
  return Services()
    ..serviceNameArabic = json['ServiceNameArabic'] as String
    ..serviceNameEnglish = json['ServiceNameEnglish'] as String
    ..id = json['Id'] as num
    ..isOther = json['IsOther'] as num;
}

Map<String, dynamic> _$ServicesToJson(Services instance) => <String, dynamic>{
      'serviceNameArabic': instance.serviceNameArabic,
      'serviceNameEnglish': instance.serviceNameEnglish,
      'id': instance.id,
      'isOther': instance.isOther,
      'selected': instance.selected,
      'isOtherActivated': instance.isOtherActivated,
      'otherValue': instance.otherValue
    };
