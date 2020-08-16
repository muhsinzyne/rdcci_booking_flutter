// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'serviceListBranch.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ServiceListBranch _$ServiceListBranchFromJson(Map<String, dynamic> json) {
  return ServiceListBranch()
    ..branch = json['Branch'] == null ? null : Branch.fromJson(json['Branch'] as Map<String, dynamic>)
    ..serviceCategory = (json['ServiceCategory'] as List)?.map((e) => e == null ? null : ServiceCategory.fromJson(e as Map<String, dynamic>))?.toList();
}

Map<String, dynamic> _$ServiceListBranchToJson(ServiceListBranch instance) =>
    <String, dynamic>{'branch': instance.branch, 'serviceCategory': instance.serviceCategory};
