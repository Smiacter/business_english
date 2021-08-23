/// 网路相关常量配置
class NetConfig {
  /// 网络请求根路径
  static String baseUrl = NetEnv.dev.url;

  // 连接和接收超时时间
  static const int connectTimeout = 15000;
  static const int receiveTimeout = 15000;

  /// 网络返回顶层JSON key【//!注意：确保一定和网络返回的一致，不同开发人员对code和message的key值定义可能不同】
  static const String data = 'result';
  static const String message = 'msg';
  static const String code = 'code';

  /// token相关
  static const String accessToken = 'accessToken';
  static const String refreshToken = 'refreshToken';
}

/// 网络环境配置
/// dev: 开发，test: 测试，release: 线上
enum NetEnv {
  /// 开发
  dev,

  /// 测试
  test,

  /// 正式
  release,
}

/// 网络环境私有extension
/// 方便以枚举的形式配置网络环境，而不是字符串
extension on NetEnv {
  String get url {
    switch (this) {
      case NetEnv.release:
        return "TODO: 配置线上地址";
      case NetEnv.test:
        return "http://enterprisecardcs.95504.net";
      default: // NetEnv.dev开发环境
        return "http://mach.aieye8.com"; //"https://devapi.heweather.net/v7/weather/";
    }
  }
}
