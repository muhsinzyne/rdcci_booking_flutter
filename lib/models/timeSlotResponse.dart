import 'package:json_annotation/json_annotation.dart';
import "slot.dart";
part 'timeSlotResponse.g.dart';

@JsonSerializable()
class TimeSlotResponse {
    TimeSlotResponse();

    List<Slot> slots;
    
    factory TimeSlotResponse.fromJson(Map<String,dynamic> json) => _$TimeSlotResponseFromJson(json);
    Map<String, dynamic> toJson() => _$TimeSlotResponseToJson(this);
}
