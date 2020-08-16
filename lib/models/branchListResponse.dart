import 'package:json_annotation/json_annotation.dart';
import "branch.dart";
part 'branchListResponse.g.dart';

@JsonSerializable()
class BranchListResponse {
    BranchListResponse();

    List<Branch> data;
    
    factory BranchListResponse.fromJson(Map<String,dynamic> json) => _$BranchListResponseFromJson(json);
    Map<String, dynamic> toJson() => _$BranchListResponseToJson(this);
}
