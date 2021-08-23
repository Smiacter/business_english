import 'package:business_english/pages/learning_center/course_item.dart';
import 'package:business_english/widgets/page_layout.dart';
import 'package:flutter/material.dart';

/// 学习中心
class LearningCenterPage extends StatefulWidget {
  LearningCenterPage({Key? key}) : super(key: key);

  @override
  _LearningCenterPageState createState() => _LearningCenterPageState();
}

class _LearningCenterPageState extends State<LearningCenterPage> {
  static const double _hPadding = 60;
  static const double _vPadding = 25;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageLayout(
        onlyBack: true,
        child: Stack(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(
                  horizontal: _hPadding, vertical: _vPadding),
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/learn_center_bg.png"),
                    fit: BoxFit.fill),
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 50, right: 50, top: 50, bottom: 20),
                child: MediaQuery.removePadding(
                  context: context,
                  removeTop: true,
                  child: GridView.count(
                    crossAxisCount: 2,
                    childAspectRatio: 2,
                    mainAxisSpacing: 0,
                    crossAxisSpacing: 0,
                    // shrinkWrap: true,
                    // physics: NeverScrollableScrollPhysics(),
                    children: [
                      CourseItem(type: 2),
                      CourseItem(type: 2),
                      CourseItem(type: 2),
                      CourseItem(type: 2),
                      CourseItem(type: 2),
                      CourseItem(type: 2),
                    ],
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.only(top: _vPadding),
                child: Text(
                  "学习中心",
                  style: TextStyle(color: Colors.white, fontSize: 22),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
