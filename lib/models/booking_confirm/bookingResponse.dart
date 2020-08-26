import 'package:json_annotation/json_annotation.dart';

import "bookingData.dart";

part 'bookingResponse.g.dart';

@JsonSerializable()
class BookingResponse {
  BookingResponse();

  num statusCode;
  String statusMessage;
  BookingData data;

  factory BookingResponse.fromJson(Map<String, dynamic> json) => _$BookingResponseFromJson(json);
  Map<String, dynamic> toJson() => _$BookingResponseToJson(this);
}
