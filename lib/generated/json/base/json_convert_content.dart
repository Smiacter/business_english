// ignore_for_file: non_constant_identifier_names
// ignore_for_file: camel_case_types
// ignore_for_file: prefer_single_quotes

// This file is automatically generated. DO NOT EDIT, all your changes would be lost.
import 'package:business_english/models/course_detail_entity.dart';
import 'package:business_english/generated/json/course_detail_entity_helper.dart';
import 'package:business_english/models/raw_response_entity.dart';
import 'package:business_english/generated/json/raw_response_entity_helper.dart';
import 'package:business_english/models/member_info_entity.dart';
import 'package:business_english/generated/json/member_info_entity_helper.dart';
import 'package:business_english/models/course_entity.dart';
import 'package:business_english/generated/json/course_entity_helper.dart';
import 'package:business_english/models/role_entity.dart';
import 'package:business_english/generated/json/role_entity_helper.dart';
import 'package:business_english/models/login_entity.dart';
import 'package:business_english/generated/json/login_entity_helper.dart';

class JsonConvert<T> {
	T fromJson(Map<String, dynamic> json) {
		return _getFromJson<T>(runtimeType, this, json);
	}

  Map<String, dynamic> toJson() {
		return _getToJson<T>(runtimeType, this);
  }

  static _getFromJson<T>(Type type, data, json) {
		switch (type) {
			case CourseDetailEntity:
				return courseDetailEntityFromJson(data as CourseDetailEntity, json) as T;
			case CourseDetailDetail:
				return courseDetailDetailFromJson(data as CourseDetailDetail, json) as T;
			case CourseDetailDetailTimes:
				return courseDetailDetailTimesFromJson(data as CourseDetailDetailTimes, json) as T;
			case RawResponseEntity:
				return rawResponseEntityFromJson(data as RawResponseEntity, json) as T;
			case MemberInfoEntity:
				return memberInfoEntityFromJson(data as MemberInfoEntity, json) as T;
			case CourseEntity:
				return courseEntityFromJson(data as CourseEntity, json) as T;
			case CourseData:
				return courseDataFromJson(data as CourseData, json) as T;
			case RoleEntity:
				return roleEntityFromJson(data as RoleEntity, json) as T;
			case LoginEntity:
				return loginEntityFromJson(data as LoginEntity, json) as T;    }
		return data as T;
	}

  static _getToJson<T>(Type type, data) {
		switch (type) {
			case CourseDetailEntity:
				return courseDetailEntityToJson(data as CourseDetailEntity);
			case CourseDetailDetail:
				return courseDetailDetailToJson(data as CourseDetailDetail);
			case CourseDetailDetailTimes:
				return courseDetailDetailTimesToJson(data as CourseDetailDetailTimes);
			case RawResponseEntity:
				return rawResponseEntityToJson(data as RawResponseEntity);
			case MemberInfoEntity:
				return memberInfoEntityToJson(data as MemberInfoEntity);
			case CourseEntity:
				return courseEntityToJson(data as CourseEntity);
			case CourseData:
				return courseDataToJson(data as CourseData);
			case RoleEntity:
				return roleEntityToJson(data as RoleEntity);
			case LoginEntity:
				return loginEntityToJson(data as LoginEntity);
			}
			return data as T;
		}
  //Go back to a single instance by type
	static _fromJsonSingle<M>( json) {
		String type = M.toString();
		if(type == (CourseDetailEntity).toString()){
			return CourseDetailEntity().fromJson(json);
		}
		if(type == (CourseDetailDetail).toString()){
			return CourseDetailDetail().fromJson(json);
		}
		if(type == (CourseDetailDetailTimes).toString()){
			return CourseDetailDetailTimes().fromJson(json);
		}
		if(type == (RawResponseEntity).toString()){
			return RawResponseEntity().fromJson(json);
		}
		if(type == (MemberInfoEntity).toString()){
			return MemberInfoEntity().fromJson(json);
		}
		if(type == (CourseEntity).toString()){
			return CourseEntity().fromJson(json);
		}
		if(type == (CourseData).toString()){
			return CourseData().fromJson(json);
		}
		if(type == (RoleEntity).toString()){
			return RoleEntity().fromJson(json);
		}
		if(type == (LoginEntity).toString()){
			return LoginEntity().fromJson(json);
		}

		return null;
	}

  //list is returned by type
	static M _getListChildType<M>(List data) {
		if(<CourseDetailEntity>[] is M){
			return data.map<CourseDetailEntity>((e) => CourseDetailEntity().fromJson(e)).toList() as M;
		}
		if(<CourseDetailDetail>[] is M){
			return data.map<CourseDetailDetail>((e) => CourseDetailDetail().fromJson(e)).toList() as M;
		}
		if(<CourseDetailDetailTimes>[] is M){
			return data.map<CourseDetailDetailTimes>((e) => CourseDetailDetailTimes().fromJson(e)).toList() as M;
		}
		if(<RawResponseEntity>[] is M){
			return data.map<RawResponseEntity>((e) => RawResponseEntity().fromJson(e)).toList() as M;
		}
		if(<MemberInfoEntity>[] is M){
			return data.map<MemberInfoEntity>((e) => MemberInfoEntity().fromJson(e)).toList() as M;
		}
		if(<CourseEntity>[] is M){
			return data.map<CourseEntity>((e) => CourseEntity().fromJson(e)).toList() as M;
		}
		if(<CourseData>[] is M){
			return data.map<CourseData>((e) => CourseData().fromJson(e)).toList() as M;
		}
		if(<RoleEntity>[] is M){
			return data.map<RoleEntity>((e) => RoleEntity().fromJson(e)).toList() as M;
		}
		if(<LoginEntity>[] is M){
			return data.map<LoginEntity>((e) => LoginEntity().fromJson(e)).toList() as M;
		}

		throw Exception("not found");
	}

  static M fromJsonAsT<M>(json) {
		if (json is List) {
			return _getListChildType<M>(json);
		} else {
			return _fromJsonSingle<M>(json) as M;
		}
	}
}