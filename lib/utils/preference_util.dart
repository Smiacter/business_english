import 'package:business_english/models/role_entity.dart';
import 'package:flustars/flustars.dart';

const String KeyToken = "KeyToken";
const String KeyRole = "KeyRole";
const String KeyTel = "KeyTel";
const String KeyIsRegister = "KeyIsRegister";

class PreferenceUtil {
  // --- 用户相关 ---
  static void saveUserToken(String token) {
    SpUtil.putString(KeyToken, token);
  }

  static void saveRole(RoleEntity role) {
    var roleJson = role.toJson();
    SpUtil.putObject(KeyRole, roleJson);
  }

  static void saveUserTel(String tel) {
    SpUtil.putString(KeyTel, tel);
  }

  static void saveIsRegister(bool val) {
    SpUtil.putBool(KeyIsRegister, val);
  }

  static String getUserToken() {
    String token = SpUtil.getString(KeyToken) ?? "";
    return token;
  }

  static RoleEntity? getRole() {
    var roleJson = SpUtil.getObject(KeyRole) as Map<String, dynamic>;
    return RoleEntity().fromJson(roleJson);
  }

  static String getUserTel() {
    String tel = SpUtil.getString(KeyTel) ?? "";
    return tel;
  }

  static bool getIsRegister() {
    bool val = SpUtil.getBool(KeyIsRegister) ?? false;
    return val;
  }
}
