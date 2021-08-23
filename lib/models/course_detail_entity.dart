import 'package:business_english/generated/json/base/json_convert_content.dart';

class CourseDetailEntity with JsonConvert<CourseDetailEntity> {
	late CourseDetailDetail detail;
}

class CourseDetailDetail with JsonConvert<CourseDetailDetail> {
	late int id;
	late String name;
	late String lecturer;
	late String intro;
	late String img;
	late List<CourseDetailDetailTimes> times;
}

class CourseDetailDetailTimes with JsonConvert<CourseDetailDetailTimes> {
	late int id;
	late String name;
}
