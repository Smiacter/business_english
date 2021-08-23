import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';

import 'custom_navbar.dart';

class PageLayout extends StatelessWidget {
  /// 是否只有返回，true：只显示返回按钮，默认点击返回上一页
  final bool onlyBack;

  /// 导航栏左边视图，只有当onlyBack为false时有效
  final Widget? leftWidget;

  /// 导航栏标题
  final String title;

  /// 导航栏右侧视图
  final Widget? rightWidget;
  final VoidCallback? onLeftClick;
  final VoidCallback? onRightClick;

  /// 除了导航栏的实际内容展示区
  final Widget child;

  const PageLayout({
    Key? key,
    this.onlyBack = false,
    this.leftWidget,
    this.title = "",
    this.rightWidget,
    this.onLeftClick,
    this.onRightClick,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil.getInstance().screenWidth,
      height: ScreenUtil.getInstance().screenHeight,
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage("assets/images/common_bg.png"), fit: BoxFit.fill),
      ),
      child: Column(
        children: [
          CustomNavbar(
            onlyBack: onlyBack,
            leftWidget: leftWidget,
            title: title,
            rightWidget: rightWidget,
            onLeftClick: onLeftClick,
            onRightClick: onRightClick,
          ),
          Divider(color: Colors.grey[300], height: 1),
          Expanded(child: child)
        ],
      ),
    );
  }
}
