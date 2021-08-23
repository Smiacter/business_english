import 'package:business_english/generated/json/base/json_convert_content.dart';
import 'package:business_english/generated/json/base/json_field.dart';

class CourseEntity with JsonConvert<CourseEntity> {
	late int total;
	@JSONField(name: "per_page")
	late int perPage;
	@JSONField(name: "current_page")
	late int currentPage;
	@JSONField(name: "last_page")
	late int lastPage;
	late List<CourseData> data;
}

class CourseData with JsonConvert<CourseData> {
	late int id;
	late String name;
	late String lecturer;
	late String intro;
	late String img;
}
