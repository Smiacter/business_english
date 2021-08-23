import 'package:bot_toast/bot_toast.dart';
import 'package:business_english/pages/home/home_page.dart';
import 'package:business_english/pages/login/login_page.dart';
import 'package:business_english/utils/preference_util.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 初始化SharedReference
  await SpUtil.getInstance();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    String token = PreferenceUtil.getUserToken();
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false, // 去除右上角debug的标签
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: token.isEmpty ? LoginPage() : HomePage(),
      builder: BotToastInit(),
      navigatorObservers: [BotToastNavigatorObserver()],
    );
  }
}
