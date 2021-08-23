import 'package:business_english/models/course_detail_entity.dart';

courseDetailEntityFromJson(CourseDetailEntity data, Map<String, dynamic> json) {
	if (json['detail'] != null) {
		data.detail = CourseDetailDetail().fromJson(json['detail']);
	}
	return data;
}

Map<String, dynamic> courseDetailEntityToJson(CourseDetailEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['detail'] = entity.detail.toJson();
	return data;
}

courseDetailDetailFromJson(CourseDetailDetail data, Map<String, dynamic> json) {
	if (json['id'] != null) {
		data.id = json['id'] is String
				? int.tryParse(json['id'])
				: json['id'].toInt();
	}
	if (json['name'] != null) {
		data.name = json['name'].toString();
	}
	if (json['lecturer'] != null) {
		data.lecturer = json['lecturer'].toString();
	}
	if (json['intro'] != null) {
		data.intro = json['intro'].toString();
	}
	if (json['img'] != null) {
		data.img = json['img'].toString();
	}
	if (json['times'] != null) {
		data.times = (json['times'] as List).map((v) => CourseDetailDetailTimes().fromJson(v)).toList();
	}
	return data;
}

Map<String, dynamic> courseDetailDetailToJson(CourseDetailDetail entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['id'] = entity.id;
	data['name'] = entity.name;
	data['lecturer'] = entity.lecturer;
	data['intro'] = entity.intro;
	data['img'] = entity.img;
	data['times'] =  entity.times.map((v) => v.toJson()).toList();
	return data;
}

courseDetailDetailTimesFromJson(CourseDetailDetailTimes data, Map<String, dynamic> json) {
	if (json['id'] != null) {
		data.id = json['id'] is String
				? int.tryParse(json['id'])
				: json['id'].toInt();
	}
	if (json['name'] != null) {
		data.name = json['name'].toString();
	}
	return data;
}

Map<String, dynamic> courseDetailDetailTimesToJson(CourseDetailDetailTimes entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['id'] = entity.id;
	data['name'] = entity.name;
	return data;
}