import 'package:argon_buttons_flutter/argon_buttons_flutter.dart';
import 'package:flutter/material.dart';

/// 用于通用的确认按钮，如创建角色、需改密码、年度兑换等按钮
class ConfirmButton extends StatelessWidget {
  final double width;
  final double height;
  final String text;
  final Function? onTap;
  const ConfirmButton(
      {Key? key,
      required this.width,
      required this.height,
      required this.text,
      this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/gradient_btn_bg.png"))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text,
              style: TextStyle(color: Colors.white, fontSize: 18),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
      onTap: () {
        if (onTap != null) {
          onTap!();
        }
      },
    );
    // ArgonButton(
    //   color: Colors.lightBlue,
    //   child: Text(
    //     text,
    //     style: TextStyle(color: Colors.white, fontSize: 24),
    //   ),
    //   width: width,
    //   height: height,
    //   borderRadius: 8,
    //   onTap: (f1, f2, state) {
    //     if (onTap != null) {
    //       onTap!();
    //     }
    //   },
    // );
  }
}
