import 'package:business_english/models/member_info_entity.dart';

memberInfoEntityFromJson(MemberInfoEntity data, Map<String, dynamic> json) {
	if (json['id'] != null) {
		data.id = json['id'] is String
				? int.tryParse(json['id'])
				: json['id'].toInt();
	}
	if (json['mobile'] != null) {
		data.mobile = json['mobile'].toString();
	}
	if (json['nickname'] != null) {
		data.nickname = json['nickname'].toString();
	}
	if (json['headimg'] != null) {
		data.headimg = json['headimg'].toString();
	}
	if (json['token'] != null) {
		data.token = json['token'].toString();
	}
	if (json['card_status'] != null) {
		data.cardStatus = json['card_status'] is String
				? int.tryParse(json['card_status'])
				: json['card_status'].toInt();
	}
	return data;
}

Map<String, dynamic> memberInfoEntityToJson(MemberInfoEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['id'] = entity.id;
	data['mobile'] = entity.mobile;
	data['nickname'] = entity.nickname;
	data['headimg'] = entity.headimg;
	data['token'] = entity.token;
	data['card_status'] = entity.cardStatus;
	return data;
}