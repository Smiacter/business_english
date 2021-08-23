import 'package:business_english/widgets/y_image.dart';
import 'package:flutter/material.dart';

/// 首页学习计划列表项
class PlanItem extends StatelessWidget {
  const PlanItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 30, right: 30, top: 11),
      padding: const EdgeInsets.only(left: 20, top: 20, right: 20, bottom: 15),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/plan_item_bg.png"),
          fit: BoxFit.fill,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("1.如何熟练的掌握日常口语",
              style: TextStyle(color: Colors.white, fontSize: 21)),
          // Gaps.vGap4,
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 8),
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/plan_tag_bg.png"))),
            child: Text(
              "商务英语",
              style: TextStyle(color: Colors.white),
            ),
          ),
          // Gaps.vGap5,
          Row(
            children: [
              YAssetImage(
                src: ImageUtils.getImgPath("learn_time_icon"),
                width: 20,
                height: 20,
              ),
              Text(
                "上次学习：2021.08.08 12:12",
                style: TextStyle(color: Color(0xFF8899C3), fontSize: 19),
                overflow: TextOverflow.ellipsis,
              )
            ],
          )
        ],
      ),
    );
  }
}
