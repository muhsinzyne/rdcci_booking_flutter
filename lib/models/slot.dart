import 'package:json_annotation/json_annotation.dart';

part 'slot.g.dart';

@JsonSerializable()
class Slot {
    Slot();

    String Date;
    String SlotDate;
    num BookCount;
    
    factory Slot.fromJson(Map<String,dynamic> json) => _$SlotFromJson(json);
    Map<String, dynamic> toJson() => _$SlotToJson(this);
}
