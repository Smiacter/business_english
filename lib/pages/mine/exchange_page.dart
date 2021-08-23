import 'package:argon_buttons_flutter/argon_buttons_flutter.dart';
import 'package:business_english/models/raw_response_entity.dart';
import 'package:business_english/network/net.dart';
import 'package:business_english/network/net_api.dart';
import 'package:business_english/utils/constant.dart';
import 'package:business_english/utils/gaps.dart';
import 'package:business_english/widgets/confirm_button.dart';
import 'package:business_english/widgets/hud.dart';
import 'package:business_english/widgets/page_layout.dart';
import 'package:business_english/widgets/skip_button.dart';
import 'package:business_english/widgets/y_image.dart';
import 'package:flutter/material.dart';

/// 年卡兑换
class ExchangePage extends StatefulWidget {
  ExchangePage({Key? key}) : super(key: key);

  @override
  _ExchangePageState createState() => _ExchangePageState();
}

class _ExchangePageState extends State<ExchangePage> {
  TextEditingController _numTextController = TextEditingController();
  TextEditingController _pwdTextController = TextEditingController();
  double _vPadding = 40;
  double _menuHpadding = 50;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _numTextController.dispose();
    _pwdTextController.dispose();

    super.dispose();
  }

  _exchangeCard() {
    if (_numTextController.text.isEmpty) {
      Hud.showToast(text: "请输入卡号");
      return;
    }
    if (_pwdTextController.text.isEmpty) {
      Hud.showToast(text: "请输入密码");
      return;
    }
    NetManager().request<RawResponseEntity>(Method.post, NetApi.exchangeCard,
        isRaw: true,
        postParams: {
          "card_no": _numTextController.text,
          "card_pwd": _pwdTextController.text,
        }, onSuccess: (entity) {
      if (entity != null) {
        Hud.showToast(text: entity.msg ?? "年卡兑换成功");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageLayout(
        onlyBack: true,
        rightWidget: _rightWidget(),
        onRightClick: () => print("兑换记录"),
        child: Stack(children: [
          Center(
            child: Container(
              width: screenWidth / 2,
              height:
                  screenHeight - statusBarHeight - navHeight - _vPadding * 2,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/alpha_blue_bg.png"),
                    fit: BoxFit.fill),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _title(),
                  _menuItem("卡号", _numTextController),
                  _menuItem("密码", _pwdTextController),
                  _button(onTap: () => _exchangeCard()),
                  Gaps.vGap10,
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

  _title() {
    return Container(
      width: screenWidth / 2 - _menuHpadding * 2 - 150,
      height: 50,
      padding: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/exchange_title_bg.png"),
          fit: BoxFit.fill,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "年卡兑换",
            style: TextStyle(color: Colors.white, fontSize: 20),
          )
        ],
      ),
    );
  }

  _menuItem(String text, TextEditingController controller, {Function? onTap}) {
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
              // keyboardType: TextInputType.number,
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
    );
  }

  _button({Function? onTap}) {
    return ConfirmButton(
      width: screenWidth / 2 - _menuHpadding * 2,
      height: 50,
      text: "兑换",
      onTap: onTap,
    );
  }

  _rightWidget() {
    return Text(
      "兑换记录",
      style: TextStyle(color: Colors.white, fontSize: 24),
    );
  }
}
