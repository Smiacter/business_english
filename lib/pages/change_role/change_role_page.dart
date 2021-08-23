import 'package:business_english/models/role_entity.dart';
import 'package:business_english/network/net.dart';
import 'package:business_english/network/net_api.dart';
import 'package:business_english/pages/change_role/create_role_page.dart';
import 'package:business_english/router/router.dart';
import 'package:business_english/utils/constant.dart';
import 'package:business_english/utils/gaps.dart';
import 'package:business_english/utils/preference_util.dart';
import 'package:business_english/widgets/page_layout.dart';
import 'package:business_english/widgets/y_image.dart';
import 'package:flutter/material.dart';

/// 切换账号页
class ChangeRolePage extends StatefulWidget {
  ChangeRolePage({Key? key}) : super(key: key);

  @override
  _ChangeRolePageState createState() => _ChangeRolePageState();
}

class _ChangeRolePageState extends State<ChangeRolePage> {
  double _vPadding = 40;
  List<RoleEntity> roleList = [];

  @override
  void initState() {
    super.initState();
    _getRoleList();
  }

  _getRoleList() {
    NetManager().request<RoleEntity>(
      Method.post,
      NetApi.getRoleList,
      isList: true,
      onSuccessList: (entities) {
        setState(() {
          roleList = entities;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageLayout(
        onlyBack: true,
        title: "切换账号",
        child: Center(
          child: Container(
            width: screenWidth / 1.5,
            height: screenHeight - statusBarHeight - navHeight - _vPadding * 2,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Color(0xB2012B79),
            ),
            child: GridView.count(
              crossAxisCount: 6,
              mainAxisSpacing: 15,
              // shrinkWrap: true,
              // physics: NeverScrollableScrollPhysics(),

              children: _widgetData(),
            ),
          ),
        ),
      ),
    );
  }

  _widgetData() {
    List<Widget> list = [];
    for (var item in roleList) {
      list.add(
        _accountItem(
          text: item.name,
          onPressed: () {
            PreferenceUtil.saveRole(item);
            MyRouter.pop(context);
          },
        ),
      );
    }
    list.add(
      _accountItem(
        src: "add_account",
        text: "",
        onPressed: () => MyRouter.push(context, CreateRolePage()),
      ),
    );
    return list;
  }

  _accountItem({
    String src = "default_avatar",
    String text = "",
    VoidCallback? onPressed,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: YAssetImage(
            src: ImageUtils.getImgPath(src),
            cornerRadius: 25,
            onPressed: onPressed,
          ),
        ),
        Gaps.hGap8,
        Text(
          text,
          style: TextStyle(color: Colors.white, fontSize: 18),
        )
      ],
    );
  }
}
