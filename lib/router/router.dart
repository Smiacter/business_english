import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyRouter {
  static void push(BuildContext context, Widget page, {String? pageName}) {
    Navigator.push(
      context,
      new CupertinoPageRoute<void>(builder: (ctx) => page),
    );
  }

  static void pop(BuildContext context) {
    Navigator.of(context).pop();
  }

  //* 切换根路由，用于登录后跳到主页面或退出后跳到登录页等场景
  static switchRoot(BuildContext context, Widget scene) {
    Navigator.of(context).pushAndRemoveUntil(
      FadeRoute(page: scene),
      (route) => route == null,
    );
  }
}

//* 渐隐效果过渡的路由转场
class FadeRoute extends PageRouteBuilder {
  final Widget page;
  FadeRoute({required this.page})
      : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              page,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              FadeTransition(
            opacity: animation,
            child: child,
          ),
        );
}
