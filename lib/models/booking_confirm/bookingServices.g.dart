// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bookingServices.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookingServices _$BookingServicesFromJson(Map<String, dynamic> json) {
  return BookingServices()
    ..appointmentBookingId = json['AppointmentBookingId'] as num
    ..serviceId = json['ServiceId'] as num
    ..serviceNameEnglish = json['ServiceNameEnglish'] as String
    ..serviceNameArabic = json['ServiceNameArabic'] as String
    ..otherServiceText = json['OtherServiceText'] as String;
}

Map<String, dynamic> _$BookingServicesToJson(BookingServices instance) => <String, dynamic>{
      'AppointmentBookingId': instance.appointmentBookingId,
      'ServiceId': instance.serviceId,
      'ServiceNameEnglish': instance.serviceNameEnglish,
      'ServiceNameArabic': instance.serviceNameArabic,
      'OtherServiceText': instance.otherServiceText
    };
