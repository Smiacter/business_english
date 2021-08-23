import 'package:bot_toast/bot_toast.dart';
import 'package:business_english/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

/// Toast显示位置
/// 统一传该参数，若更换了toast插件，需要做对应的转换
enum YToastPosition {
  top,
  center,
  bottom,
}

extension on YToastPosition {
  Alignment get value {
    if (this == YToastPosition.top) {
      return Alignment.topCenter;
    } else if (this == YToastPosition.center) {
      return Alignment.center;
    } else {
      return Alignment.bottomCenter;
    }
  }
}

/// Alert types
/// 对应使用插件rflutter_alert中的AlertType
enum YAlertType { error, success, info, warning, none }

extension on YAlertType {
  AlertType get value {
    switch (this) {
      case YAlertType.error:
        return AlertType.error;
      case YAlertType.success:
        return AlertType.success;
      case YAlertType.info:
        return AlertType.info;
      case YAlertType.warning:
        return AlertType.warning;
      default:
        return AlertType.none;
    }
  }
}

/// 包含Toast和Alert弹框的封装
class Hud {
  /// 显示普通的Alert弹框
  /// type：成功、错误、警告等，非none会在顶部显示对应图标，具体可参照rflutter_alert说明
  /// cancelText：默认为nil即不显示取消按钮，设置了才会显示
  /// confirmCallback：点击确认按钮的回调
  static void showAlert({
    required BuildContext context,
    required String msg,
    YAlertType type = YAlertType.none,
    String title = '提示',
    String? cancelText,
    String confirmText = '确定',
    Function? confirmCallback,
  }) {
    Alert(
      context: context,
      title: title,
      desc: msg,
      type: type.value,
      style: AlertStyle(
        isCloseButton: false,
        animationType: AnimationType.grow,
        isOverlayTapDismiss: false,
        overlayColor: Color.fromRGBO(0, 0, 0, 0.6),
      ),
      buttons: cancelText == null
          ? [
              DialogButton(
                child: Text(confirmText, style: TextStyles.textWhite14),
                onPressed: () {
                  Navigator.pop(context);
                  confirmCallback?.call();
                },
              )
            ]
          : [
              DialogButton(
                color: Colors.grey[400],
                child: Text(
                  cancelText,
                  style: TextStyles.textWhite14,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              DialogButton(
                child: Text(confirmText, style: TextStyles.textWhite14),
                onPressed: () {
                  Navigator.pop(context);
                  confirmCallback?.call();
                },
              )
            ],
    ).show();
  }

  /// 显示带自定义Alert
  /// 有title，取消和确定按钮，中间内容content为自定义
  static showCustomAlert({
    required BuildContext context,
    required String title,
    required Widget content,
    Function? confirmCallback,
  }) {
    Alert(
        context: context,
        title: title,
        style: AlertStyle(
          isCloseButton: false,
          animationType: AnimationType.grow,
          isOverlayTapDismiss: false,
          overlayColor: Color.fromRGBO(0, 0, 0, 0.6),
        ),
        content: content,
        buttons: [
          DialogButton(
            color: Colors.grey[400],
            child: Text(
              "取消",
              style: TextStyles.textWhite14,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          DialogButton(
            color: Colors.blue,
            child: Text("确定", style: TextStyles.textWhite14),
            onPressed: () {
              Navigator.pop(context);
              confirmCallback?.call();
            },
          )
        ]).show();
  }

  /// 显示Toast提示
  static showToast({
    required String text,
    YToastPosition position = YToastPosition.bottom,
    Color bgColor = const Color(0xFF616161),
    Color txtColor = Colors.white,
    int duration = 2000,
  }) {
    BotToast.showText(
      text: text,
      align: position.value,
      contentColor: bgColor,
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
      borderRadius: BorderRadius.all(Radius.circular(20)),
      textStyle: TextStyle(color: txtColor, fontSize: 14),
      duration: Duration(milliseconds: duration),
      onlyOne: true,
    );
  }

  /// 取消Toast显示
  static void cancelToast() {
    BotToast.cleanAll();
  }

  static showLoading() {
    BotToast.showLoading(
      allowClick: true,
      clickClose: true,
    );
  }

  static void cancelLoading() {
    BotToast.closeAllLoading();
  }
}
