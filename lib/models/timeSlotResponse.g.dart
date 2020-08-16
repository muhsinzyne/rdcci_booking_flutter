// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'timeSlotResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TimeSlotResponse _$TimeSlotResponseFromJson(Map<String, dynamic> json) {
  return TimeSlotResponse()..slots = (json['slots'] as List)?.map((e) => e == null ? null : Slot.fromJson(e as Map<String, dynamic>))?.toList();
}

Map<String, dynamic> _$TimeSlotResponseToJson(TimeSlotResponse instance) => <String, dynamic>{'slots': instance.slots};
