import 'package:business_english/utils/gaps.dart';
import 'package:business_english/widgets/y_image.dart';
import 'package:flutter/material.dart';

/// 首页推荐课程列表项
class RecommendItem extends StatelessWidget {
  final String title;
  final String teacher;
  final String avatar;
  const RecommendItem(
      {Key? key, this.title: "", this.teacher: "", this.avatar: ""})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 14, top: 16, bottom: 16, right: 14),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/course_item_bg.png"),
          fit: BoxFit.fill,
        ),
      ),
      child: Row(
        children: [
          YNetworkImage(
            src: avatar,
            width: 50,
            height: 50,
          ),
          Gaps.hGap10,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        style: TextStyle(color: Colors.white, fontSize: 21),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    YAssetImage(
                      src: ImageUtils.getImgPath("apply_btn_img"),
                      width: 65,
                      height: 28,
                    )
                    // ApplyButton(
                    //   width: 65,
                    //   height: 28,
                    //   text: "报名",
                    //   onTap: () {
                    //     print("首页报名...");
                    //   },
                    // ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "讲师：$teacher",
                      style: TextStyle(color: Colors.grey[300], fontSize: 19),
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.lock_clock,
                          color: Colors.grey[300],
                          size: 30,
                        ),
                        Icon(
                          Icons.lock_clock,
                          color: Colors.grey[300],
                          size: 30,
                        ),
                        Icon(
                          Icons.lock_clock,
                          color: Colors.grey[300],
                          size: 30,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        YAssetImage(
                          src: ImageUtils.getImgPath("favorite"),
                          width: 16,
                          height: 13.5,
                        ),
                        Text(
                          "1233人",
                          style: TextStyle(
                            color: Colors.grey[300],
                            fontSize: 14,
                          ),
                        )
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
