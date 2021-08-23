import 'package:flutter/material.dart';

/// 跳过 按钮
class SkipButton extends StatelessWidget {
  final VoidCallback? onPressed;
  const SkipButton({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: Text(
        "跳过",
        style: TextStyle(color: Colors.white),
      ),
      style: ButtonStyle(
        padding: MaterialStateProperty.all(EdgeInsets.symmetric(horizontal: 5)),
        backgroundColor: MaterialStateProperty.all(Colors.white10),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
      onPressed: onPressed,
    );
  }
}
