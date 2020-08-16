import 'package:json_annotation/json_annotation.dart';
import "services.dart";
part 'serviceCategory.g.dart';

@JsonSerializable()
class ServiceCategory {
    ServiceCategory();

    num categoryId;
    String categoryNameArabic;
    String categoryNameEnglish;
    List<Services> services;
    
    factory ServiceCategory.fromJson(Map<String,dynamic> json) => _$ServiceCategoryFromJson(json);
    Map<String, dynamic> toJson() => _$ServiceCategoryToJson(this);
}
