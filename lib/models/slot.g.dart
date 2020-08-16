// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'slot.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Slot _$SlotFromJson(Map<String, dynamic> json) {
  return Slot()
    ..date = json['Date'] as String
    ..slotDate = json['SlotDate'] as String
    ..bookCount = json['BookCount'] as num;
}

Map<String, dynamic> _$SlotToJson(Slot instance) => <String, dynamic>{'Date': instance.date, 'SlotDate': instance.slotDate, 'BookCount': instance.bookCount};
