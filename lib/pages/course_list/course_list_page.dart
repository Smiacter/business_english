import 'package:business_english/utils/constant.dart';
import 'package:business_english/utils/gaps.dart';
import 'package:business_english/widgets/page_layout.dart';
import 'package:business_english/widgets/y_image.dart';
import 'package:flutter/material.dart';

/// 课时详情
class CourseListPage extends StatefulWidget {
  CourseListPage({Key? key}) : super(key: key);

  @override
  _CourseListPageState createState() => _CourseListPageState();
}

class _CourseListPageState extends State<CourseListPage> {
  static const double _hPadding = 100;
  static const double _vPadding = 20;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageLayout(
        onlyBack: true,
        title: "课时详情",
        child: Container(
          padding: const EdgeInsets.only(
            left: _hPadding,
            right: _hPadding,
            bottom: _vPadding,
            top: _vPadding,
          ),
          child: _courseList(),
        ),
      ),
    );
  }

  _courseList() {
    return Container(
      padding: const EdgeInsets.only(left: 20, top: 20, right: 20, bottom: 20),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/course_list_bg.png"),
          fit: BoxFit.fill,
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                flex: 1,
                child: _horiItem(text: "课程", srcName: "course_detail_hori1_bg"),
              ),
              Expanded(
                flex: 2,
                child: _horiItem(text: "课程", srcName: "course_detail_hori2_bg"),
              ),
              Expanded(
                flex: 5,
                child: _horiItem(text: "主题", srcName: "course_detail_hori3_bg"),
              ),
            ],
          ),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: _vertiCourseOverview("商务英语"),
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    height: double.infinity,
                    child: MediaQuery.removePadding(
                      context: context,
                      removeTop: true,
                      child: ListView.builder(
                        itemCount: 12,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: _horiItem(
                                text: "第一课时",
                                srcName: "course_detail_hori2_bg"),
                          );
                        },
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: Container(
                    height: double.infinity,
                    child: MediaQuery.removePadding(
                      context: context,
                      removeTop: true,
                      child: ListView.builder(
                        itemCount: 12,
                        itemBuilder: (context, index) {
                          return Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: _courseTitle(text: "如何熟练的掌握商务英语"));
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// 居中显示文字水平显示项 - 使用包含顶部标题，第几课时
  _horiItem({required String text, required String srcName}) {
    return Container(
      padding: const EdgeInsets.only(top: 5, bottom: 5),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/$srcName.png"),
          fit: BoxFit.fill,
        ),
      ),
      child: Text(
        text,
        style: TextStyle(color: Colors.white, fontSize: 16),
        textAlign: TextAlign.center,
      ),
    );
  }

  /// 课程标题
  _courseTitle({required String text}) {
    return Container(
      padding: const EdgeInsets.only(top: 5, bottom: 5, left: 15, right: 20),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/course_detail_hori3_bg.png"),
          fit: BoxFit.fill,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style: TextStyle(color: Colors.white, fontSize: 16),
            overflow: TextOverflow.ellipsis,
          ),
          YAssetImage(
              src: ImageUtils.getImgPath("course_play"), width: 20, height: 20),
        ],
      ),
    );
  }

  /// 垂直显示项 - 课程总览，如商务英语，共6节
  _vertiCourseOverview(String text) {
    return Container(
      height: double.infinity,
      padding: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/course_detail_verti_bg.png"),
          fit: BoxFit.fill,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style: TextStyle(color: Colors.white, fontSize: 18),
            textAlign: TextAlign.center,
          ),
          Column(
            children: [
              Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.white,
                ),
                child: Text("6", textAlign: TextAlign.center),
              ),
              Text(
                "节",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ],
          )
        ],
      ),
    );
  }
}
