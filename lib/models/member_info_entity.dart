import 'package:business_english/generated/json/base/json_convert_content.dart';
import 'package:business_english/generated/json/base/json_field.dart';

class MemberInfoEntity with JsonConvert<MemberInfoEntity> {
	int? id;
	String? mobile;
	String? nickname;
	String? headimg;
	String? token;
	@JSONField(name: "card_status")
	int? cardStatus;
}
