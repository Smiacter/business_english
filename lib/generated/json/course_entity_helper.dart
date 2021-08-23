import 'package:business_english/models/course_entity.dart';

courseEntityFromJson(CourseEntity data, Map<String, dynamic> json) {
	if (json['total'] != null) {
		data.total = json['total'] is String
				? int.tryParse(json['total'])
				: json['total'].toInt();
	}
	if (json['per_page'] != null) {
		data.perPage = json['per_page'] is String
				? int.tryParse(json['per_page'])
				: json['per_page'].toInt();
	}
	if (json['current_page'] != null) {
		data.currentPage = json['current_page'] is String
				? int.tryParse(json['current_page'])
				: json['current_page'].toInt();
	}
	if (json['last_page'] != null) {
		data.lastPage = json['last_page'] is String
				? int.tryParse(json['last_page'])
				: json['last_page'].toInt();
	}
	if (json['data'] != null) {
		data.data = (json['data'] as List).map((v) => CourseData().fromJson(v)).toList();
	}
	return data;
}

Map<String, dynamic> courseEntityToJson(CourseEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['total'] = entity.total;
	data['per_page'] = entity.perPage;
	data['current_page'] = entity.currentPage;
	data['last_page'] = entity.lastPage;
	data['data'] =  entity.data.map((v) => v.toJson()).toList();
	return data;
}

courseDataFromJson(CourseData data, Map<String, dynamic> json) {
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
	return data;
}

Map<String, dynamic> courseDataToJson(CourseData entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['id'] = entity.id;
	data['name'] = entity.name;
	data['lecturer'] = entity.lecturer;
	data['intro'] = entity.intro;
	data['img'] = entity.img;
	return data;
}