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

/// 创建角色页
class CreateRolePage extends StatefulWidget {
  CreateRolePage({Key? key}) : super(key: key);

  @override
  _CreateRolePageState createState() => _CreateRolePageState();
}

class _CreateRolePageState extends State<CreateRolePage> {
  TextEditingController _nameTextController = TextEditingController();
  TextEditingController _ageTextController = TextEditingController();
  TextEditingController _genderTextController = TextEditingController();
  TextEditingController _jobTextController = TextEditingController();
  double _vPadding = 30;
  double _menuHpadding = 40;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _nameTextController.dispose();
    _ageTextController.dispose();
    _genderTextController.dispose();
    _jobTextController.dispose();

    super.dispose();
  }

  _createRole() {
    if (_nameTextController.text.isEmpty) {
      Hud.showToast(text: "请输入角色名称");
      return;
    }
    if (_ageTextController.text.isEmpty) {
      Hud.showToast(text: "请输入年龄");
      return;
    }
    if (_genderTextController.text.isEmpty) {
      Hud.showToast(text: "请输入性别");
      return;
    }
    if (_jobTextController.text.isEmpty) {
      Hud.showToast(text: "请输入职业");
      return;
    }
    NetManager().request<RawResponseEntity>(Method.post, NetApi.createRole,
        isRaw: true,
        postParams: {
          "name": _nameTextController.text,
          "age": _ageTextController.text,
          "sex": _genderTextController.text,
          "job": _jobTextController.text,
        }, onSuccess: (entity) {
      if (entity != null) {
        Hud.showToast(text: entity.msg ?? "角色创建成功");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageLayout(
        onlyBack: true,
        title: "创建角色",
        child: Stack(children: [
          Center(
            child: Container(
              width: screenWidth / 2,
              height:
                  screenHeight - statusBarHeight - navHeight - _vPadding * 2,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Color(0xB2012B79),
              ),
              child: SingleChildScrollView(
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Gaps.vGap10,
                    _avatar(),
                    Gaps.vGap10,
                    _menuItem("角色名称", _nameTextController),
                    Gaps.vGap10,
                    _menuItem("年龄", _ageTextController),
                    Gaps.vGap10,
                    _menuItem("性别", _genderTextController),
                    Gaps.vGap10,
                    _menuItem("职业", _jobTextController),
                    Gaps.vGap10,
                    _button(onTap: () => _createRole()),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 10,
            right: 15,
            child: SkipButton(
              onPressed: () => print("跳过创建角色"),
            ),
          )
        ]),
      ),
    );
  }

  _avatar() {
    return YAssetImage(
      src: ImageUtils.getImgPath("default_avatar"),
      width: 80,
      height: 80,
      cornerRadius: 8,
    );
  }

  _menuItem(String text, TextEditingController controller) {
    return Row(
      children: [
        SizedBox(width: _menuHpadding),
        Container(
          width: 100,
          child: Text(
            text,
            style: TextStyle(color: Colors.white, fontSize: 20),
            textAlign: TextAlign.end,
          ),
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
                // hintText: "请输入卡号",
                contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                enabledBorder: InputBorder.none,
                // OutlineInputBorder(
                //   borderRadius: BorderRadius.all(Radius.circular(8)),
                //   borderSide: BorderSide(color: Colors.blue[200]!),
                // ),
                focusedBorder: InputBorder.none,
                // OutlineInputBorder(
                //   borderRadius: BorderRadius.all(Radius.circular(8)),
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
      width: screenWidth / 3,
      height: 60,
      text: "创建",
      onTap: onTap,
    );
  }
}
