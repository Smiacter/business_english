import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dimens.dart';

/// 定义APP中所需的间距Widget
/// 常用于Column或row中的间距
class Gaps {
  
  /// 水平间隔
  static const Widget hGap4 = const SizedBox(width: Dimens.gap_dp4);
  static const Widget hGap5 = const SizedBox(width: Dimens.gap_dp5);
  static const Widget hGap8 = const SizedBox(width: Dimens.gap_dp8);
  static const Widget hGap10 = const SizedBox(width: Dimens.gap_dp10);
  static const Widget hGap12 = const SizedBox(width: Dimens.gap_dp12);
  static const Widget hGap15 = const SizedBox(width: Dimens.gap_dp15);
  static const Widget hGap16 = const SizedBox(width: Dimens.gap_dp16);
  static const Widget hGap32 = const SizedBox(width: Dimens.gap_dp32);
  
  /// 垂直间隔
  static const Widget vGap4 = const SizedBox(height: Dimens.gap_dp4);
  static const Widget vGap5 = const SizedBox(height: Dimens.gap_dp5);
  static const Widget vGap8 = const SizedBox(height: Dimens.gap_dp8);
  static const Widget vGap10 = const SizedBox(height: Dimens.gap_dp10);
  static const Widget vGap12 = const SizedBox(height: Dimens.gap_dp12);
  static const Widget vGap15 = const SizedBox(height: Dimens.gap_dp15);
  static const Widget vGap16 = const SizedBox(height: Dimens.gap_dp16);
  static const Widget vGap24 = const SizedBox(height: Dimens.gap_dp24);
  static const Widget vGap32 = const SizedBox(height: Dimens.gap_dp32);

  static Widget line = const Divider();

  static Widget vLine = const SizedBox(
    width: 0.6,
    height: 24.0,
    child: const VerticalDivider(),
  );
  
  static const Widget empty = const SizedBox.shrink();
}
