import 'package:json_annotation/json_annotation.dart';

part 'services.g.dart';

@JsonSerializable()
class Services {
  Services();

  String serviceNameArabic;
  String serviceNameEnglish;
  num id;
  num isOther;

  bool selected = false;
  bool isOtherActivated = false;
  String otherValue = '';
  factory Services.fromJson(Map<String, dynamic> json) => _$ServicesFromJson(json);
  Map<String, dynamic> toJson() => _$ServicesToJson(this);
}
