import 'package:business_english/pages/message_center/message_item.dart';
import 'package:business_english/widgets/customer_service.dart';
import 'package:business_english/widgets/page_layout.dart';
import 'package:flutter/material.dart';

/// 消息中心
class MessageCenterPage extends StatefulWidget {
  MessageCenterPage({Key? key}) : super(key: key);

  @override
  _MessageCenterPageState createState() => _MessageCenterPageState();
}

class _MessageCenterPageState extends State<MessageCenterPage> {
  static const double _hPadding = 100;
  static const double _vPadding = 40;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageLayout(
        onlyBack: true,
        rightWidget: CustomerService(),
        onRightClick: () => print("联系客服"),
        child: Container(
          margin: const EdgeInsets.symmetric(
              horizontal: _hPadding, vertical: _vPadding),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Color(0x994169E1),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
            child: GridView.count(
              crossAxisCount: 1,
              childAspectRatio: 4,
              mainAxisSpacing: 20,
              crossAxisSpacing: 20,
              // shrinkWrap: true,
              // physics: NeverScrollableScrollPhysics(),
              children: [
                MessageItem(
                    title: "商务英语", content: "第二课时  |  如何熟练的练习口语", type: 1),
                MessageItem(
                    title: "维护公告", content: "系统将于xxxxxxxxx进行维护", type: 2),
                MessageItem(
                    title: "商务英语", content: "第二课时  |  如何熟练的练习口语", type: 1),
                MessageItem(
                    title: "维护公告", content: "系统将于xxxxxxxxx进行维护", type: 2),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
