// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'branchListResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BranchListResponse _$BranchListResponseFromJson(Map<String, dynamic> json) {
  return BranchListResponse()
    ..data = (json['data'] as List)
        ?.map((e) =>
            e == null ? null : Branch.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$BranchListResponseToJson(BranchListResponse instance) =>
    <String, dynamic>{'data': instance.data};
