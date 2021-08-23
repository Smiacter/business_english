import 'package:argon_buttons_flutter/argon_buttons_flutter.dart';
import 'package:business_english/models/login_entity.dart';
import 'package:business_english/models/raw_response_entity.dart';
import 'package:business_english/network/net.dart';
import 'package:business_english/network/net_api.dart';
import 'package:business_english/pages/home/home_page.dart';
import 'package:business_english/router/router.dart';
import 'package:business_english/utils/constant.dart';
import 'package:business_english/utils/gaps.dart';
import 'package:business_english/utils/preference_util.dart';
import 'package:business_english/widgets/confirm_button.dart';
import 'package:business_english/widgets/hud.dart';
import 'package:business_english/widgets/page_layout.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:keyboard_actions/keyboard_actions.dart';

/// 修改密码
class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
        title: "登录",
        onRightClick: () => print("兑换记录"),
        child: Center(
          child: Container(
            width: screenWidth / 1.5,
            height: screenHeight - statusBarHeight - navHeight - _vPadding * 2,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Color(0xB2012B79),
            ),
            child: KeyboardActions(
              config: KeyboardActionsConfig(
                keyboardActionsPlatform: KeyboardActionsPlatform.ALL,
                nextFocus: false,
                actions: [],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _menuItem("手机号", _telTextController,
                      inputType: TextInputType.phone),
                  _codeItem(),
                  PreferenceUtil.getIsRegister()
                      ? Gaps.empty
                      : _menuItem("激活码", _pwdTextController),
                  _button(onTap: () {
                    PreferenceUtil.getIsRegister() ? _login() : _register();
                  }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _sendSms() {
    NetManager().request<RawResponseEntity>(
      Method.post,
      NetApi.sendSms,
      isRaw: true,
      postParams: {
        "mobile": _telTextController.text,
      },
      onSuccess: (entity) {
        if (entity != null) {
          Hud.showToast(text: entity.msg ?? "");
        }
      },
    );
  }

  /// 注册
  _register() {
    if (!RegexUtil.isMobileExact(_telTextController.text)) {
      Hud.showToast(text: "手机号格式不正确");
      return;
    }
    if (_codeTextController.text.isEmpty) {
      Hud.showToast(text: "请输入验证码");
      return;
    }
    if (_pwdTextController.text.isEmpty) {
      Hud.showToast(text: "请输入邀请码");
      return;
    }
    NetManager()
        .request<LoginEntity>(Method.post, NetApi.register, postParams: {
      "mobile": _telTextController.text,
      "code": _codeTextController.text,
      "codkey": _pwdTextController.text,
    }, onSuccess: (entity) {
      PreferenceUtil.saveUserToken(entity?.token ?? "");
      PreferenceUtil.saveUserTel(_telTextController.text);
      PreferenceUtil.saveIsRegister(true);
      MyRouter.switchRoot(context, HomePage());
    }, onError: (code, msg) {
      // 如果是已登录的账号，重新更新
      if (code == 201) {
        setState(() {
          PreferenceUtil.saveIsRegister(true);
        });
      }
    });
  }

  _login() {
    if (!RegexUtil.isMobileExact(_telTextController.text)) {
      Hud.showToast(text: "手机号格式不正确");
      return;
    }
    if (_codeTextController.text.isEmpty) {
      Hud.showToast(text: "请输入验证码");
      return;
    }
    NetManager().request<LoginEntity>(
      Method.post,
      NetApi.login,
      postParams: {
        "mobile": _telTextController.text,
        "code": _codeTextController.text,
      },
      onSuccess: (entity) {
        PreferenceUtil.saveUserToken(entity?.token ?? "");
        PreferenceUtil.saveUserTel(_telTextController.text);
        MyRouter.switchRoot(context, HomePage());
      },
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
                _sendSms();
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

  _menuItem(String text, TextEditingController controller,
      {TextInputType? inputType}) {
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
              keyboardType: inputType,
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
