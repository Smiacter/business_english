import 'package:business_english/utils/gaps.dart';
import 'package:business_english/widgets/apply_button.dart';
import 'package:business_english/widgets/y_image.dart';
import 'package:flutter/material.dart';

/// 消息项
class MessageItem extends StatelessWidget {
  final String title;
  final String content;
  final int type;
  const MessageItem(
      {Key? key,
      required this.title,
      required this.content,
      required this.type})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
        color: Color(0x7F292421),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Stack(
        children: [
          Row(
            children: [
              Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Stack(
                  children: [
                    YAssetImage(
                      src: ImageUtils.getImgPath("temp_bg"),
                      width: double.infinity,
                      height: double.infinity,
                      cornerRadius: 8,
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        width: double.infinity,
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Color(0x55000000),
                        ),
                        child: Text(
                          type == 1 ? "课程解锁" : "活动通知",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Gaps.hGap16,
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(color: Colors.white, fontSize: 24),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Gaps.vGap16,
                  Text(
                    content,
                    style: TextStyle(color: Colors.white, fontSize: 20),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ],
          ),
          Visibility(
            visible: type == 1,
            child: Align(
              alignment: Alignment.topRight,
              child: ApplyButton(
                width: 100,
                height: 40,
                text: "已解锁",
                onTap: () {},
              ),
            ),
          ),
        ],
      ),
    );
  }
}
