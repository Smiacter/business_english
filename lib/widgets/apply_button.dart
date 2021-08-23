import 'package:argon_buttons_flutter/argon_buttons_flutter.dart';
import 'package:flutter/material.dart';

/// 公用的报名按钮
class ApplyButton extends StatelessWidget {
  final double width;
  final double height;
  final String text;
  final Function? onTap;

  const ApplyButton(
      {Key? key,
      required this.width,
      required this.height,
      required this.text,
      this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ArgonButton(
      color: Color(0xFF540085),
      child: Text(
        text,
        style: TextStyle(color: Colors.white, fontSize: 16),
      ),
      width: width,
      height: height,
      borderRadius: 8,
      onTap: (f1, f2, state) {
        if (onTap != null) {
          onTap!();
        }
      },
    );
  }
}
