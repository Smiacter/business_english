import 'package:business_english/utils/constant.dart';
import 'package:business_english/utils/gaps.dart';
import 'package:business_english/widgets/y_image.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';

class CustomNavbar extends StatelessWidget {
  final Widget? leftWidget;
  final Widget? rightWidget;
  final String title;
  final bool onlyBack;
  final VoidCallback? onLeftClick;
  final VoidCallback? onRightClick;

  const CustomNavbar({
    Key? key,
    this.onlyBack = false,
    this.leftWidget,
    this.title = "",
    this.rightWidget,
    this.onLeftClick,
    this.onRightClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // width: double.infinity,
      height: statusBarHeight + navHeight,
      padding: EdgeInsets.only(top: ScreenUtil.getInstance().statusBarHeight),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 23),
            child: _buildLeft(context),
          ),
          _buildTitle(),
          Padding(
            padding: const EdgeInsets.only(right: 30),
            child: _buildRight(),
          ),
        ],
      ),
    );
  }

  _buildLeft(context) {
    if (onlyBack) {
      return InkWell(
        child: YAssetImage(
          src: ImageUtils.getImgPath("back_white"),
          width: 30,
          height: 30,
        ),
        onTap: onLeftClick ?? () => Navigator.of(context).pop(),
      );
    } else {
      return InkWell(
        child: leftWidget ?? Gaps.empty,
        onTap: onLeftClick ?? () => Navigator.of(context).pop(),
      );
    }
  }

  _buildTitle() {
    return Text(
      title,
      style: TextStyle(color: Colors.white, fontSize: 23),
    );
  }

  _buildRight() {
    return InkWell(
      child: rightWidget ?? Gaps.empty,
      onTap: onRightClick ?? () => "",
    );
  }
}
