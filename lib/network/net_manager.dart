import 'dart:convert';
import 'package:business_english/utils/app_config.dart';
import 'package:business_english/utils/log_util.dart';
import 'package:business_english/utils/preference_util.dart';
import 'package:business_english/widgets/hud.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'base_entity.dart';
import 'error_handle.dart';
import 'intercept.dart';
import 'net_config.dart';

class NetManager {
  static final NetManager _singleton = NetManager._();

  static NetManager get instance => NetManager();

  factory NetManager() => _singleton;

  static late Dio _dio;

  Dio get dio => _dio;

  NetManager._() {
    var options = BaseOptions(
        baseUrl: NetConfig.baseUrl,
        connectTimeout: NetConfig.connectTimeout,
        receiveTimeout: NetConfig.receiveTimeout,
        responseType: ResponseType.plain,
        // contentType: ContentType('application', 'x-www-form-urlencoded', charset: 'utf-8'),
        validateStatus: (status) {
          // 不使用http状态码判断状态，使用AdapterInterceptor来处理（适用于标准REST风格）
          return true;
        },
        headers: {"Content-Type": "application/x-www-form-urlencoded"});
    _dio = Dio(options);

    // 打印Log(非生产模式)
    if (!AppConfig.inProduction) {
      _dio.interceptors.add(LoggingInterceptor());
    }

    /// 统一添加身份验证请求头【可选】
    // _dio.interceptors.add(AuthInterceptor());
    /// 刷新Token【可选】
    // _dio.interceptors.add(TokenInterceptor());
    /// 适配数据(根据自己的数据结构，可自行选择添加)【可选】
    // _dio.interceptors.add(AdapterInterceptor());
  }

  /// 网络请求
  /// method：请求方式，如get, post
  /// url：当前请求功能地址
  /// postParams：method为post时该参数传参
  /// getParams：method为get时该参数传参
  /// isList：是否是返回列表，若为true，则data内容为列表，使用onSuccessList回调
  /// isRaw：是否返回原始数据，而不是返回data数据。若为true，传入泛型必须时后台定义的固定规范字符，一般是code, msg, data
  /// onSuccess：非list成功回调，返回已转换的传入类型entity
  /// onSuccessList：list成功回调，返回已转换的传入类型[entity]数组
  /// onError：错误回调
  /// cancelToken：暂时没用 - 扩展字段
  /// options：暂时没用 - 扩展字段
  Future request<T>(
    Method method,
    String url, {
    bool isLoading: true,
    bool isList: false,
    bool isRaw: false,
    Map<String, dynamic>? postParams,
    Map<String, dynamic>? getParams,
    Function(T? t)? onSuccess,
    Function(List<T> list)? onSuccessList,
    Function(int code, String msg)? onError,
    CancelToken? cancelToken,
    Options? options,
  }) {
    return _request<T>(
      method.value,
      url,
      isLoading: isLoading,
      isRaw: isRaw,
      postParams: postParams,
      getParams: getParams,
      options: options,
      cancelToken: cancelToken,
    ).then((BaseEntity<T>? result) {
      if (result?.code == 200) {
        if (isList) {
          onSuccessList?.call(result!.listData);
        } else {
          onSuccess?.call(result!.data);
        }
      } else {
        _onError(result!.code, result.msg, onError);
        Hud.showToast(text: result.msg);
      }
    }, onError: (e, _) {
      Hud.cancelLoading();
      _cancelLogPrint(e, url);
      NetError error = ExceptionHandle.handleException(e);
      _onError(error.code, error.msg, onError);
    });
  }

  Future<BaseEntity<T>?> _request<T>(
    String method,
    String url, {
    bool isLoading: true,
    bool isRaw: false,
    Map<String, dynamic>? postParams,
    Map<String, dynamic>? getParams,
    CancelToken? cancelToken,
    Options? options,
  }) async {
    if (isLoading) Hud.showLoading();
    int tiemstamp = (DateTime.now().microsecondsSinceEpoch ~/ 1000).toInt();
    print(tiemstamp);
    _dio.options.headers["timestamp"] = tiemstamp;
    _dio.options.headers["token"] = PreferenceUtil.getUserToken();
    _dio.options.headers["signature"] = "";
    var response = await _dio.request(
      url,
      data: postParams,
      queryParameters: getParams,
      options: _checkOptions(method, options),
      cancelToken: cancelToken,
    );
    try {
      // 集成测试无法使用 isolate https://github.com/flutter/flutter/issues/24703
      // 如果isRaw为true，即返回原始数据，否则返回data数据
      Map<String, dynamic> _map = AppConfig.isDriverTest
          ? parseData(response.data.toString())
          : await compute(parseData, response.data.toString());
      Hud.cancelLoading();
      return BaseEntity.fromJson(_map, isRaw: isRaw);
    } catch (e, _) {
      Hud.cancelLoading();
      return null; //BaseEntity(ExceptionHandle.parse_error, '数据解析错误', null);
    }
  }

  Options _checkOptions(method, options) {
    if (options == null) {
      options = Options();
    }
    options.method = method;

    return options;
  }

  _cancelLogPrint(dynamic e, String url) {
    if (e is DioError && CancelToken.isCancel(e)) {
      Log.e('取消请求接口： $url');
    }
  }

  _onError(int code, String msg, Function(int code, String mag)? onError) {
    if (code == null) {
      code = ExceptionHandle.unknown_error;
      msg = '未知异常';
    }
    Log.e('接口请求异常： code: $code, msg: $msg');
    Hud.showToast(text: msg);
    onError?.call(code, msg);
  }

// --- 针对data字段不是返回JSON格式而是直接返回数据或者null，甚至直接没有data字段，通过code等来判断成功失败的网络处理，不再适用于以上的泛型封装

  /// 数据返回格式统一，统一处理异常
  /// data：用于post参数，queryParameters：用于get请求参数
  Future requestPlain(
    Method method,
    String url, {
    Function(dynamic t)? onSuccess,
    Function(int code, String msg)? onError,
    dynamic params,
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
    Options? options,
  }) async {
    Hud.showLoading();
    var response = await _dio.request(url,
        data: params,
        queryParameters: queryParameters,
        options: _checkOptions(method.value, options),
        cancelToken: cancelToken);

    Hud.cancelLoading();
    Log.e('原始返回数据： $response');

    Log.e('原始返回数据转String： ${response.toString()}');
    // try {
    //   Hud.cancelLoading();
    //   Log.e('原始返回数据： $response');
    // } catch (e, s) {
    //   Hud.cancelLoading();
    //   return BaseEntity(ExceptionHandle.parse_error, '数据解析错误', null);
    // }

    // return _request<T>(method.value, url,
    //         data: params,
    //         queryParameters: queryParameters,
    //         options: options,
    //         cancelToken: cancelToken)
    //     .then((BaseEntity<T> result) {
    //   if (result.infocode == 200) {
    //     if (isList) {
    //       onSuccessList?.call(result.listData);
    //     } else {
    //       onSuccess?.call(result.data);
    //     }
    //   } else {
    //     _onError(result.infocode, result.info, onError);
    //   }
    // }, onError: (e, _) {
    //   Hud.cancelLoading();
    //   _cancelLogPrint(e, url);
    //   NetError error = ExceptionHandle.handleException(e);
    //   _onError(error.code, error.msg, onError);
    // });
  }
}

Map<String, dynamic> parseData(String data) {
  return json.decode(data);
}

/// 网络请求方式
enum Method { get, post, put, patch, delete, head }

/// Method私有extension
/// 返回它的String value
extension on Method {
  String get value {
    switch (this) {
      case Method.get:
        return 'GET';
      case Method.post:
        return 'POST';
      case Method.put:
        return 'PUT';
      case Method.patch:
        return 'PATCH';
      case Method.delete:
        return 'DELETE';
      case Method.head:
        return 'HEAD';
      default:
        return 'GET';
    }
  }
}
