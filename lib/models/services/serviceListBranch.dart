import 'package:json_annotation/json_annotation.dart';
import "branch.dart";
import "serviceCategory.dart";
part 'serviceListBranch.g.dart';

@JsonSerializable()
class ServiceListBranch {
    ServiceListBranch();

    Branch branch;
    List<ServiceCategory> serviceCategory;
    
    factory ServiceListBranch.fromJson(Map<String,dynamic> json) => _$ServiceListBranchFromJson(json);
    Map<String, dynamic> toJson() => _$ServiceListBranchToJson(this);
}
