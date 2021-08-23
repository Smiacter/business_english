import 'package:business_english/utils/gaps.dart';
import 'package:business_english/widgets/y_image.dart';
import 'package:flutter/material.dart';

/// 联系客服
class CustomerService extends StatelessWidget {
  const CustomerService({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        YAssetImage(
          src: ImageUtils.getImgPath("robot"),
          width: 25,
          height: 25,
        ),
        Gaps.hGap5,
        Text(
          "联系客服",
          style: TextStyle(color: Colors.white, fontSize: 24),
        )
      ],
    );
  }
}
