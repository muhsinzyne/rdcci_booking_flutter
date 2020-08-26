import 'package:json_annotation/json_annotation.dart';

part 'bookingServices.g.dart';

@JsonSerializable()
class BookingServices {
  BookingServices();

  num appointmentBookingId;
  num serviceId;
  String serviceNameEnglish;
  String serviceNameArabic;
  String otherServiceText;

  factory BookingServices.fromJson(Map<String, dynamic> json) => _$BookingServicesFromJson(json);
  Map<String, dynamic> toJson() => _$BookingServicesToJson(this);
}
