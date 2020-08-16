import 'package:json_annotation/json_annotation.dart';

part 'branch.g.dart';

@JsonSerializable()
class Branch {
  Branch();

  num id;
  String branchNameArabic;
  String addressArabic;
  String branchNameEnglish;
  String addressEnglish;

  factory Branch.fromJson(Map<String, dynamic> json) => _$BranchFromJson(json);
  Map<String, dynamic> toJson() => _$BranchToJson(this);
}
