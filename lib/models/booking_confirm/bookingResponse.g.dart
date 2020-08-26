// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bookingResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookingResponse _$BookingResponseFromJson(Map<String, dynamic> json) {
  return BookingResponse()
    ..statusCode = json['Statuscode'] as num
    ..statusMessage = json['StatusMessage'] as String
    ..data = json['Data'] == null ? null : BookingData.fromJson(json['Data'] as Map<String, dynamic>);
}

Map<String, dynamic> _$BookingResponseToJson(BookingResponse instance) =>
    <String, dynamic>{'Statuscode': instance.statusCode, 'StatusMessage': instance.statusMessage, 'Data': instance.data};
