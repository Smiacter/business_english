/// 应用中网络请求url配置
///
class NetApi {
  /// 发送验证码
  static const String sendSms = "/api/common/send_sms";

  /// 用户注册
  static const String register = "/api/login/register";

  /// 用户登录
  static const String login = "/api/login/login";

  /// 获取用户会员信息
  static const String getMemberInfo = "/api/member/info";

  /// 兑换年卡
  static const String exchangeCard = "/api/member/getcard";

  /// 获取角色列表
  static const String getRoleList = "/api/member/role";

  /// 创建角色
  static const String createRole = "/api/member/add_role";

  /// 课程列表
  static const String courseList = "/api/course/list";

  /// 课程详情
  static const String courseDetail = "/api/course/detail";

  /// 报名课程
  static const String signupCourse = "/api/course/signup";
}
