import 'package:argon_buttons_flutter/argon_buttons_flutter.dart';
import 'package:business_english/utils/constant.dart';
import 'package:business_english/utils/gaps.dart';
import 'package:business_english/widgets/confirm_button.dart';
import 'package:business_english/widgets/hud.dart';
import 'package:business_english/widgets/page_layout.dart';
import 'package:business_english/widgets/skip_button.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';

/// 修改密码
class ChangePwdPage extends StatefulWidget {
  ChangePwdPage({Key? key}) : super(key: key);

  @override
  _ChangePwdPageState createState() => _ChangePwdPageState();
}

class _ChangePwdPageState extends State<ChangePwdPage> {
  TextEditingController _telTextController = TextEditingController();
  TextEditingController _codeTextController = TextEditingController();
  TextEditingController _pwdTextController = TextEditingController();
  double _vPadding = 40;
  double _menuHpadding = 100;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _telTextController.dispose();
    _codeTextController.dispose();
    _pwdTextController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageLayout(
        onlyBack: true,
        title: "修改密码",
        onRightClick: () => print("兑换记录"),
        child: Stack(children: [
          Center(
            child: Container(
              width: screenWidth / 1.5,
              height:
                  screenHeight - statusBarHeight - navHeight - _vPadding * 2,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Color(0xB2012B79),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _menuItem("手机号", _telTextController),
                  _codeItem(),
                  _menuItem("新密码", _pwdTextController),
                  _button(onTap: () => print("完成...")),
                ],
              ),
            ),
          ),
          Positioned(
            top: 10,
            right: 15,
            child: SkipButton(
              onPressed: () {
                print("跳过兑换");
              },
            ),
          )
        ]),
      ),
    );
  }

  _codeItem() {
    return Stack(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(width: _menuHpadding),
            Text(
              "验证码",
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
            Gaps.hGap15,
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/textfield_bg.png"),
                    fit: BoxFit.fill,
                  ),
                ),
                child: TextField(
                  controller: _codeTextController,
                  textAlign: TextAlign.start,
                  keyboardType: TextInputType.number,
                  style: TextStyle(color: Colors.white, fontSize: 16),
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                    enabledBorder: InputBorder.none,
                    // OutlineInputBorder(
                    //   borderRadius: BorderRadius.all(Radius.circular(10)),
                    //   borderSide: BorderSide(color: Colors.blue[200]!),
                    // ),
                    focusedBorder: InputBorder.none,
                    // OutlineInputBorder(
                    //   borderRadius: BorderRadius.all(Radius.circular(10)),
                    //   borderSide: BorderSide(color: Colors.purple[200]!),
                    // ),
                  ),
                ),
              ),
            ),
            SizedBox(width: _menuHpadding),
          ],
        ),
        Positioned(
          top: 0,
          right: _menuHpadding + 10,
          bottom: 0,
          child: ArgonTimerButton(
            borderSide:
                BorderSide.none, //BorderSide(color: Colors.orange, width: 0.5),
            height: 35,
            width: 90,
            minWidth: 90,
            highlightColor: Colors.transparent,
            highlightElevation: 0,
            roundLoadingShape: false,
            splashColor: Colors.transparent,
            onTap: (startTimer, btnState) async {
              if (!RegexUtil.isMobileExact(_telTextController.text)) {
                Hud.showToast(text: "手机号格式不正确");
                return;
              }
              if (btnState == ButtonState.Idle) {
                startTimer(60);
                // _getLoginCode();
              }
            },
            child: Text(
              "获取验证码",
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
              ),
            ),
            loader: (timeLeft) {
              return Text(
                "$timeLeft秒后重新获取",
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 12,
                ),
              );
            },
            // borderRadius: 5.0,
            color: Colors.transparent,
            elevation: 0,
          ),
        )
      ],
    );
  }

  _menuItem(String text, TextEditingController controller) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(width: _menuHpadding),
        Text(
          text,
          style: TextStyle(color: Colors.white, fontSize: 24),
        ),
        Gaps.hGap15,
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/textfield_bg.png"),
                fit: BoxFit.fill,
              ),
            ),
            child: TextField(
              controller: controller,
              // focusNode: _nodeText3,
              textAlign: TextAlign.start,
              keyboardType: TextInputType.number,
              style: TextStyle(color: Colors.white, fontSize: 16),
              decoration: InputDecoration(
                // hintText: "请输入卡号",
                contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                enabledBorder: InputBorder.none,
                // OutlineInputBorder(
                //   borderRadius: BorderRadius.all(Radius.circular(10)),
                //   borderSide: BorderSide(color: Colors.blue[200]!),
                // ),
                focusedBorder: InputBorder.none,
                // OutlineInputBorder(
                //   borderRadius: BorderRadius.all(Radius.circular(10)),
                //   borderSide: BorderSide(color: Colors.purple[200]!),
                // ),
              ),
            ),
          ),
        ),
        SizedBox(width: _menuHpadding),
      ],
    );
  }

  _button({Function? onTap}) {
    return ConfirmButton(
      width: screenWidth / 2 - _menuHpadding * 2,
      height: 60,
      text: "完成",
      onTap: onTap,
    );
  }
}
