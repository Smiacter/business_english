import 'package:business_english/widgets/hud.dart';

import '../../generated/json/base/json_convert_content.dart';
import 'net_config.dart';

/// 基础模型定义与解析
/// 需配合Android Studio插件FlutterJsonBeanFactory
class BaseEntity<T> {
  //! 一般情况下服务器返回的code都是int类型，也有遇到过是String的，需根据实际情况定义
  late int code; // 信息编码，0-失败；20-成功
  late String msg; // 提示文本，通常其他系统定义为msg
  late T data;
  List<T> listData = [];

  BaseEntity(this.code, this.msg, this.data);

  BaseEntity.fromJson(Map<String, dynamic> json, {bool isRaw: false}) {
    // 不管isRaw的值，这里统一都处理code和msg，方便netManager统一处理
    code = json[NetConfig.code];
    msg = json[NetConfig.message];

    if (json.containsKey(NetConfig.data)) {
      // 如果是返回所有数据，则将整个json解析返回
      print("data数据：${json[NetConfig.data]}");
      // 如果isRaw为true，则返回所有数据
      // 其他情况不管isRaw是否为true，只要返回的data为null，则处理整个返回数据，确保RawResponseEntity能构造成功，在result处拦截code等错误码给出提示！
      if (isRaw || json[NetConfig.data] == null) {
        data = _generateOBJ(json);
      } else {
        if (json[NetConfig.data] is List) {
          (json[NetConfig.data] as List).forEach((item) {
            listData.add(_generateOBJ<T>(item));
          });
        } else {
          data = _generateOBJ(json[NetConfig.data]);
        }
      }
    } else {
      //! 后台没有返回data字段，确认必须传该字段
      Hud.showToast(text: "数据返回格式不正确");
    }
  }

  S _generateOBJ<S>(json) {
    if (S.toString() == 'String') {
      return json.toString() as S;
    } else if (T.toString() == 'Map<dynamic, dynamic>') {
      return json as S;
    } else {
      return JsonConvert.fromJsonAsT<S>(json);
    }
  }
}
