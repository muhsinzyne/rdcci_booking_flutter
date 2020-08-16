// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'slot.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Slot _$SlotFromJson(Map<String, dynamic> json) {
  return Slot()
    ..Date = json['Date'] as String
    ..SlotDate = json['SlotDate'] as String
    ..BookCount = json['BookCount'] as num;
}

Map<String, dynamic> _$SlotToJson(Slot instance) => <String, dynamic>{
      'Date': instance.Date,
      'SlotDate': instance.SlotDate,
      'BookCount': instance.BookCount
    };
