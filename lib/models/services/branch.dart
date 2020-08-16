import 'package:json_annotation/json_annotation.dart';

part 'branch.g.dart';

@JsonSerializable()
class Branch {
    Branch();

    num BranchId;
    String BranchNameArabic;
    String BranchNameEnglish;
    
    factory Branch.fromJson(Map<String,dynamic> json) => _$BranchFromJson(json);
    Map<String, dynamic> toJson() => _$BranchToJson(this);
}
