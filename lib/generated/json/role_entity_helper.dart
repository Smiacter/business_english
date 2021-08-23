import 'package:business_english/models/role_entity.dart';

roleEntityFromJson(RoleEntity data, Map<String, dynamic> json) {
	if (json['id'] != null) {
		data.id = json['id'] is String
				? int.tryParse(json['id'])
				: json['id'].toInt();
	}
	if (json['name'] != null) {
		data.name = json['name'].toString();
	}
	if (json['age'] != null) {
		data.age = json['age'] is String
				? int.tryParse(json['age'])
				: json['age'].toInt();
	}
	if (json['sex'] != null) {
		data.sex = json['sex'].toString();
	}
	if (json['job'] != null) {
		data.job = json['job'].toString();
	}
	if (json['headimg'] != null) {
		data.headimg = json['headimg'].toString();
	}
	return data;
}

Map<String, dynamic> roleEntityToJson(RoleEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['id'] = entity.id;
	data['name'] = entity.name;
	data['age'] = entity.age;
	data['sex'] = entity.sex;
	data['job'] = entity.job;
	data['headimg'] = entity.headimg;
	return data;
}