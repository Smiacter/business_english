import 'package:business_english/models/course_entity.dart';
import 'package:business_english/models/member_info_entity.dart';
import 'package:business_english/models/role_entity.dart';
import 'package:business_english/network/net_api.dart';
import 'package:business_english/network/net_manager.dart';
import 'package:business_english/pages/change_role/change_role_page.dart';
import 'package:business_english/pages/home/plan_item.dart';
import 'package:business_english/pages/home/recommend_item.dart';
import 'package:business_english/pages/learning_center/course_center_page.dart';
import 'package:business_english/pages/learning_center/learning_center_page.dart';
import 'package:business_english/pages/message_center/message_center_page.dart';
import 'package:business_english/pages/mine/exchange_page.dart';
import 'package:business_english/pages/mine/mine_page.dart';
import 'package:business_english/router/router.dart';
import 'package:business_english/utils/gaps.dart';
import 'package:business_english/utils/preference_util.dart';
import 'package:business_english/widgets/page_layout.dart';
import 'package:business_english/widgets/y_image.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

/// 首页
class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TapGestureRecognizer _enterRecognizer = TapGestureRecognizer();
  MemberInfoEntity? memberInfo;
  List<CourseData> courseList = [];
  RoleEntity? role;

  @override
  void initState() {
    super.initState();
    _getMemberInfo();
    _getCourseList();

    role = PreferenceUtil.getRole();
  }

  /// 获取会员信息
  _getMemberInfo() {
    NetManager().request<MemberInfoEntity>(Method.post, NetApi.getMemberInfo,
        isLoading: false, postParams: {}, onSuccess: (entity) {
      if (entity != null) {
        setState(() {
          this.memberInfo = entity;
          // 如果卡片过期或未激活，跳转到年卡兑换页
          if (entity.cardStatus == 0) {
            MyRouter.push(context, ExchangePage());
          }
        });
      }
    });
  }

  /// 获取课程列表
  _getCourseList() {
    NetManager().request<CourseEntity>(Method.post, NetApi.courseList,
        isLoading: false,
        postParams: {
          "page": 1,
          "limit": 10,
        }, onSuccess: (entity) {
      courseList = entity?.data ?? [];
      if (courseList.length == 1) {
        courseList.add(courseList[0]);
      }
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageLayout(
        leftWidget: _leftWidget(),
        rightWidget: _rightWidget(),
        onLeftClick: () => Navigator.push(
          context,
          new CupertinoPageRoute<void>(builder: (ctx) => ChangeRolePage()),
        ).then((value) {
          setState(() {
            role = PreferenceUtil.getRole();
          });
        }), //MyRouter.push(context, ChangeRolePage()),
        onRightClick: () => MyRouter.push(context, MessageCenterPage()),
        child: Stack(
          children: [
            Row(
              children: [
                Container(
                  width: ScreenUtil.getInstance().screenWidth / 2,
                  child: Column(
                    children: [
                      Expanded(
                        child: Padding(
                          // 学习计划左边部分
                          padding: const EdgeInsets.only(
                              top: 30, left: 40, right: 10),
                          child: _buildPlan(),
                        ),
                      ),
                      _buildReportBtn(),
                    ],
                  ),
                ),
                Container(
                  width: ScreenUtil.getInstance().screenWidth / 2,
                  child: Column(
                    children: [
                      Expanded(child: _buildRecommendTitle()),
                      Expanded(child: _buildRecommendCourse())
                    ],
                  ),
                )
              ],
            ),
            _buildRobot(context),
          ],
        ),
      ),
    );
  }

  // 今日计划
  _buildPlan() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/home_left_bg.png"),
          fit: BoxFit.fill,
        ),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(top: 13),
            width: 280,
            height: 55,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/plan_title_bg.png"))),
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text: "今日学习计划",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 19,
                ),
                children: [
                  TextSpan(
                    text: "  进入学习中心 >",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                    recognizer: _enterRecognizer
                      ..onTap = () {
                        MyRouter.push(context, LearningCenterPage());
                      },
                  )
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(bottom: 20),
              child: MediaQuery.removePadding(
                context: context,
                removeTop: true,
                child: ListView.builder(
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    return PlanItem();
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  //学习报告按钮
  _buildReportBtn() {
    return Container(
        margin: const EdgeInsets.only(bottom: 38, top: 25),
        child: YAssetImage(
          src: ImageUtils.getImgPath("report_btn_img"),
          width: 174,
          height: 57,
        )
        // ArgonButton(
        //   color: Colors.purple,
        //   child: Text(
        //     "学习报告",
        //     style: TextStyle(color: Colors.white, fontSize: 22),
        //   ),
        //   width: 174,
        //   height: 57,
        //   borderRadius: 8,
        // ),
        );
  }

  // 推荐课程
  _buildRecommendTitle() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 40),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/recommend_title_bg.png"),
          fit: BoxFit.fill,
        ),
      ),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              padding: const EdgeInsets.only(left: 25, top: 10),
              width: 20,
              height: 120,
              child: Text(
                "推荐课程",
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 17),
              child: InkWell(
                child: Text(
                  "全部课程 >>",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                onTap: () => MyRouter.push(context, CourseCenterPage()),
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: YAssetImage(
              src: ImageUtils.getImgPath("default_avatar"),
              width: 100,
              height: 100,
            ),
          )
        ],
      ),
    );
  }

  _buildRecommendCourse() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      padding: const EdgeInsets.only(left: 50, right: 50, top: 25, bottom: 10),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/recommend_course_bg.png"),
          fit: BoxFit.fill,
        ),
      ),
      child: Expanded(
        child: Container(
          padding: const EdgeInsets.only(bottom: 20),
          child: MediaQuery.removePadding(
            context: context,
            removeTop: true,
            child: ListView.builder(
              itemCount: courseList.length,
              itemBuilder: (context, index) {
                return RecommendItem(
                  title: courseList[index].name,
                  teacher: courseList[index].lecturer,
                  avatar: courseList[index].img,
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  _buildRobot(context) {
    return Positioned(
      left: 23.5,
      bottom: 17,
      child: InkWell(
        child: YAssetImage(
          src: ImageUtils.getImgPath("robot"),
          width: 84,
          height: 70,
        ),
        onTap: () => MyRouter.push(context, MinePage()),
      ),
    );
  }

  _leftWidget() {
    return role == null
        ? Gaps.empty
        : Row(
            children: [
              YNetworkImage(
                src: "",
                width: 30,
                height: 30,
                onPressed: () => MyRouter.push(context, MinePage()),
              ),
              Gaps.hGap10,
              Text(
                role?.name ?? "默认昵称",
                style: TextStyle(color: Colors.white, fontSize: 19),
              ),
              Gaps.hGap10,
              YAssetImage(
                src: ImageUtils.getImgPath("exchange"),
                width: 16.5,
                height: 14.5,
              ),
            ],
          );
  }

  _rightWidget() {
    return Row(
      children: [
        YAssetImage(
          src: ImageUtils.getImgPath("message"),
          width: 20,
          height: 20,
        ),
        Gaps.hGap8,
        Text(
          "消息中心",
          style: TextStyle(color: Colors.white, fontSize: 19),
        )
      ],
    );
  }
}
