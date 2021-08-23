// export 'package:multi_image_picker/multi_image_picker.dart';
import 'dart:typed_data';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
// import 'package:multi_image_picker/multi_image_picker.dart';

/// 图片加载（支持本地路径、网络图片、Uint8List、Asset格式）
/// 判断顺序依次为[本地路径||网络图片(String类型)]->[Uint8List]->[Asset]，确保只传一种类型
/// 支持圆角设置
/// 支持网络图片的Placeholder、加载错误的默认样式
// class YImage extends StatelessWidget {
//   /// 图片资源，可以是[网络url]或[完整本地资源路径]
//   final String src;
//   /// 二进制资源图片[Uint8List]
//   final Uint8List bytes;
//   /// [multi_image_picker]选中的[Asset]类型
//   final Asset asset;
//   /// placeholder样式，在NetworkImage和Asset类型中有效
//   final Widget placeholder;
//   /// 宽度
//   final double width;
//   /// 高度
//   final double height;
//   /// 圆角
//   final double cornerRadius;
//   /// contentMode，默认为BoxFit.cover
//   final BoxFit fit;
//   /// 加载错误显示样式
//   final Widget errorWidget;
//   final Color color;
//   /// 图片点击事件
//   final VoidCallback onPressed;

//   const YImage({
//     Key key,
//     this.src,
//     this.bytes,
//     this.asset,
//     this.placeholder,
//     this.width,
//     this.height,
//     this.cornerRadius = 0,
//     this.fit = BoxFit.cover,
//     this.errorWidget,
//     this.color,
//     this.onPressed,

//   }): super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       child: ClipRRect(
//         borderRadius: BorderRadius.circular(cornerRadius),
//         child: _image(),
//       ),
//       onTap: onPressed,
//     );
//   }

//   Widget _image() {
//     if (src != null) {
//       if (src.startsWith('http')) {
//         return YNetworkImage(
//           key: key,
//           src: src,
//           placeholder: placeholder,
//           width: width,
//           height: height,
//           fit: fit,
//           errorWidget: errorWidget,
//           color: color,
//         );
//     } else {
//         return YAssetImage(
//           key: key,
//           src: src,
//           width: width,
//           height: height,
//           fit: fit,
//           errorWidget: errorWidget,
//           color: color,
//         );
//       }
//     } else if (bytes != null) {
//       return YMemoryImage(
//         key: key,
//         bytes: bytes,
//         width: width,
//         height: height,
//         fit: fit,
//         errorWidget: errorWidget,
//       );
//     } else { // asset必定不为null
//       return YMultiAssetImage(
//         key: key == null ? Key(asset.identifier) : key, // key默认使用asset.identifier[因为使用了Stateful，保证更换Asset会刷新，必须传标识Key]
//         asset: asset,
//         width: width,
//         height: height,
//         fit: fit,
//         errorWidget: errorWidget,
//         placeholder: placeholder,
//       );
//     }
//   }
// }

/// 加载本地资源图片
class YAssetImage extends StatelessWidget {
  /// 资源路径名，一般为['assets/images/category/xxx.png']
  final String src;
  final double? width;
  final double? height;
  final BoxFit? fit;
  final Color? color;
  final Widget? errorWidget;

  /// 圆角
  final double cornerRadius;

  /// 图片点击事件
  final VoidCallback? onPressed;

  const YAssetImage({
    Key? key,
    required this.src,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.color,
    this.errorWidget,
    this.cornerRadius = 0,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(cornerRadius),
        child: Image.asset(
          src,
          height: height,
          width: width,
          fit: fit,
          color: color,

          /// 忽略图片语义
          excludeFromSemantics: true,
          errorBuilder: (context, error, stackTrace) =>
              _ErrorWidget(width, height, errorWidget),
        ),
      ),
      onTap: onPressed,
    );
  }
}

/// 加载网络图片
///
///
class YNetworkImage extends StatelessWidget {
  /// 图片网络地址
  final String src;
  final Widget? placeholder;
  final double? width;
  final double? height;
  final BoxFit? fit;
  final Widget? errorWidget;
  final Color? color;

  /// 圆角
  final double cornerRadius;

  /// 图片点击事件
  final VoidCallback? onPressed;

  YNetworkImage({
    Key? key,
    required this.src,
    this.placeholder,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.errorWidget,
    this.color,
    this.cornerRadius = 0,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(cornerRadius),
        child: CachedNetworkImage(
          imageUrl: src,
          placeholder: (context, url) =>
              _PlaceholderWidget(width, height, placeholder),
          width: width,
          height: height,
          fit: fit,
          // errorWidget: (context, url, error) => _ErrorWidget(width, height, errorWidget),
          color: color,
          errorWidget: (context, url, header) =>
              _PlaceholderWidget(width, height, placeholder),
        ),
      ),
      onTap: onPressed,
    );
  }
}

/// 加载二进制资源图片[Uint8List]
class YMemoryImage extends StatelessWidget {
  /// 图片资源数据
  final Uint8List bytes;
  final double? width;
  final double? height;
  final BoxFit? fit;
  final Color? color;
  final Widget? errorWidget;

  /// 圆角
  final double cornerRadius;

  /// 图片点击事件
  final VoidCallback? onPressed;

  const YMemoryImage({
    Key? key,
    required this.bytes,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.color,
    this.errorWidget,
    this.cornerRadius = 0,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(cornerRadius),
        child: Image.memory(
          bytes,
          width: width,
          height: height,
          fit: fit,
          color: color,
          errorBuilder: (context, error, stackTrace) =>
              _ErrorWidget(width, height, errorWidget),
        ),
      ),
      onTap: onPressed,
    );
  }
}

/// 显示[multi_image_picker]选中的[Asset]资源
/// 记得使用时传入唯一标识Key[因为是Stateful，传入Key确保能刷新，在YImage调用时已默认传入了asset.identifier]
// class YMultiAssetImage extends StatefulWidget {
//   /// 图片资源数据
//   final Asset asset;
//   final double width;
//   final double height;
//   final BoxFit fit;
//   final Color color;
//   final Widget placeholder;
//   final Widget errorWidget;

//   /// 圆角
//   final double cornerRadius;

//   /// 图片点击事件
//   final VoidCallback onPressed;

//   const YMultiAssetImage({
//     Key key,
//     @required this.asset,
//     this.width,
//     this.height,
//     this.fit = BoxFit.cover,
//     this.color,
//     this.placeholder,
//     this.errorWidget,
//     this.cornerRadius = 0,
//     this.onPressed,
//   }) : super(key: key);

//   @override
//   State<StatefulWidget> createState() => _YMultiAssetImageState();
// }

// class _YMultiAssetImageState extends State<YMultiAssetImage> {
//   Uint8List _bytes;

//   @override
//   void initState() {
//     super.initState();

//     _getImgBytes();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       child: ClipRRect(
//         borderRadius: BorderRadius.circular(widget.cornerRadius),
//         child: _bytes == null
//             ? _PlaceholderWidget(
//                 widget.width, widget.height, widget.placeholder)
//             : YMemoryImage(
//                 bytes: _bytes,
//                 width: widget.width,
//                 height: widget.height,
//                 fit: widget.fit,
//                 color: widget.color,
//                 errorWidget: widget.errorWidget,
//               ),
//       ),
//       onTap: widget.onPressed,
//     );
//   }

//   void _getImgBytes() async {
//     _bytes = await ImageUtils.getImgBytes(widget.asset);
//     setState(() {});
//   }
// }

/// 图片加载默认错误Widget
///
/// 用于AssetImage和NetworkImage中的errorWidget
class _ErrorWidget extends StatelessWidget {
  final double? width;
  final double? height;
  final Widget? widget;

  _ErrorWidget(this.width, this.height, this.widget);

  @override
  Widget build(BuildContext context) {
    return widget == null
        ? Container(
            width: width,
            height: height,
            color: Colors.grey[200],
            child: Center(
              child: Text(
                "加载❌",
                style: TextStyle(color: Colors.grey[700], fontSize: 14),
              ),
            ),
          )
        : Container(
            width: width,
            height: height,
            child: widget,
          );
  }
}

/// 图片加载Placeholder Widget
///
/// 用于NetworkImage中的placeholder
class _PlaceholderWidget extends StatelessWidget {
  final double? width;
  final double? height;
  final double cornerRadius;
  final Widget? widget;

  _PlaceholderWidget(this.width, this.height, this.widget,
      {this.cornerRadius = 0});

  @override
  Widget build(BuildContext context) {
    return widget == null
        ? YAssetImage(
            src: ImageUtils.getImgPath("default_avatar"),
            width: width,
            height: height,
            cornerRadius: cornerRadius,
          )
        : Container(
            width: width,
            height: height,
            child: widget,
          );
  }
}

class ImageUtils {
  /// 获取指定图片资源名和类型的可显示路径
  static String getImgPath(String name, {String format: 'png'}) {
    return 'assets/images/$name.$format';
  }

  /// 将[multi_image_picker]得到的[Asset]转化为[Uint8List]
  /// 方便直接使用[Image.memory]显示
  // static Future<Uint8List> getImgBytes(Asset asset) async {
  //   ByteData byteData = await asset.getByteData();
  //   return byteData.buffer.asUint8List();
  // }

  static ImageProvider getAssetImage(String name, {String format: 'png'}) {
    return AssetImage(getImgPath(name, format: format));
  }

  static ImageProvider getImageProvider(String imageUrl,
      {String holderImg: 'none'}) {
    if (TextUtil.isEmpty(imageUrl)) {
      return AssetImage(getImgPath(holderImg));
    }
    return CachedNetworkImageProvider(imageUrl);
  }
}
