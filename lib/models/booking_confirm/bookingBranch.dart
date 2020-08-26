import 'package:json_annotation/json_annotation.dart';

part 'bookingBranch.g.dart';

@JsonSerializable()
class BookingBranch {
  BookingBranch();

  String branchId;
  String branchNameArabic;
  String branchNameEnglish;
  String addressEnglish;
  String addressArabic;

  factory BookingBranch.fromJson(Map<String, dynamic> json) => _$BookingBranchFromJson(json);
  Map<String, dynamic> toJson() => _$BookingBranchToJson(this);
}
