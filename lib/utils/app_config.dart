import 'package:flutter/foundation.dart';

/// 定义APP中一些常量
class AppConfig {
  /// debug开关，上线需要关闭
  /// App运行在Release环境时，inProduction为true；当App运行在Debug和Profile环境时，inProduction为false
  static const bool inProduction = kReleaseMode;

  static const String logTag = "FleetCard-LOG";

  static const bool isDriverTest = false;
  static const bool isUnitTest = false;

  /// Tabbar默认选中index
  static const int defaultTabIndex = 1;

  /// 主题Key
  static const String keyTheme = 'keyTheme';

  /// light主题
  static const String lightTheme = 'Light';

  /// dark主题
  static const String darkTheme = 'Dark';

  /// system主题
  static const String systemTheme = 'System';

  ///
  static const int pageZero = 0;

  ///
  static const int pageSize = 20;
}
