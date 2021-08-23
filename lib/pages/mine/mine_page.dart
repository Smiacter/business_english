import 'package:argon_buttons_flutter/argon_buttons_flutter.dart';
import 'package:business_english/pages/change_role/change_role_page.dart';
import 'package:business_english/pages/login/login_page.dart';
import 'package:business_english/pages/mine/about_page.dart';
import 'package:business_english/pages/mine/change_pwd_page.dart';
import 'package:business_english/pages/mine/exchange_page.dart';
import 'package:business_english/router/router.dart';
import 'package:business_english/utils/constant.dart';
import 'package:business_english/utils/gaps.dart';
import 'package:business_english/utils/preference_util.dart';
import 'package:business_english/widgets/customer_service.dart';
import 'package:business_english/widgets/page_layout.dart';
import 'package:business_english/widgets/y_image.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';

class MinePage extends StatefulWidget {
  MinePage({Key? key}) : super(key: key);

  @override
  _MinePageState createState() => _MinePageState();
}

class _MinePageState extends State<MinePage> {
  double _vPadding = 40;
  double _menuHpadding = 50;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageLayout(
        onlyBack: true,
        rightWidget: CustomerService(),
        onRightClick: () => print("联系客服"),
        child: Center(
          child: Container(
            width: screenWidth / 2,
            height: screenHeight - statusBarHeight - navHeight - _vPadding * 2,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/mine_bg.png"),
                    fit: BoxFit.fill)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _title(),
                _menuItem("年卡兑换", onTap: () {
                  MyRouter.push(context, ExchangePage());
                }),
                _menuItem("密码修改",
                    onTap: () => MyRouter.push(context, ChangePwdPage())),
                _menuItem("关于我们",
                    onTap: () => MyRouter.push(context, AboutPage())),
                _menuItem("意见反馈"),
                _menuItem("切换账号",
                    onTap: () => MyRouter.push(context, ChangeRolePage())),
                _menuItem("退出登录", onTap: () {
                  PreferenceUtil.saveUserToken("");
                  MyRouter.switchRoot(context, LoginPage());
                }),
                SizedBox(height: 20)
              ],
            ),
          ),
        ),
      ),
    );
  }

  _title() {
    return Container(
      width: screenWidth / 2 - _menuHpadding * 2 - 100,
      height: 50,
      padding: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/mine_title_bg.png"),
              fit: BoxFit.fill)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.person,
            size: 25,
            color: Colors.white,
          ),
          Gaps.hGap5,
          Text(
            "个人中心",
            style: TextStyle(color: Colors.white, fontSize: 20),
          )
        ],
      ),
    );
  }

  /// 个人中心菜单按钮，如果其他地方有使用，可抽离
  _menuItem(String text, {Function? onTap}) {
    return InkWell(
      child: Container(
        width: screenWidth / 2 - _menuHpadding * 2,
        height: 50,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/mine_item_bg.png"),
            fit: BoxFit.fill,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text,
              style: TextStyle(color: Colors.white, fontSize: 18),
            )
          ],
        ),
      ),
      onTap: () {
        if (onTap != null) {
          onTap();
        }
      },
    );
  }
}
