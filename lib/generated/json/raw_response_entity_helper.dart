import 'package:business_english/models/raw_response_entity.dart';

rawResponseEntityFromJson(RawResponseEntity data, Map<String, dynamic> json) {
	if (json['code'] != null) {
		data.code = json['code'] is String
				? int.tryParse(json['code'])
				: json['code'].toInt();
	}
	if (json['msg'] != null) {
		data.msg = json['msg'].toString();
	}
	if (json['result'] != null) {
		data.result = json['result'].toString();
	}
	return data;
}

Map<String, dynamic> rawResponseEntityToJson(RawResponseEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['code'] = entity.code;
	data['msg'] = entity.msg;
	data['result'] = entity.result;
	return data;
}