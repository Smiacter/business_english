import 'package:business_english/pages/course_detail/course_detail_page.dart';
import 'package:business_english/router/router.dart';
import 'package:business_english/utils/gaps.dart';
import 'package:business_english/widgets/apply_button.dart';
import 'package:business_english/widgets/y_image.dart';
import 'package:flutter/material.dart';

/// 课程项
class CourseItem extends StatelessWidget {
  final VoidCallback? onItemTap;
  final VoidCallback? onBtnTap;
  // 1-课程中心,2-学习中心
  final int type;
  const CourseItem({Key? key, this.onItemTap, this.onBtnTap, this.type = 1})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/learn_center_item_bg.png"),
            fit: BoxFit.fill,
          ),
        ),
        padding:
            const EdgeInsets.only(left: 28, right: 28, top: 30, bottom: 30),
        child: Row(
          children: [
            // Gaps.hGap32,
            YAssetImage(
              src: ImageUtils.getImgPath("default_avatar"),
              width: 100,
              height: 100,
              cornerRadius: 8,
            ),
            Gaps.hGap16,
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "课程名称",
                  style: TextStyle(color: Colors.white, fontSize: 23),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Gaps.vGap5,
                Text(
                  "主讲老师：王尼玛",
                  style: TextStyle(color: Colors.white, fontSize: 19),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Gaps.vGap5,
                type == 1
                    ? YAssetImage(
                        src: ImageUtils.getImgPath("apply_btn_img"),
                        width: 70,
                        height: 30,
                        onPressed: onBtnTap,
                      )
                    : ApplyButton(
                        width: 70,
                        height: 30,
                        text: "学习",
                        onTap: onBtnTap,
                      ),
              ],
            )
          ],
        ),
      ),
      onTap: onItemTap,
    );
  }
}
