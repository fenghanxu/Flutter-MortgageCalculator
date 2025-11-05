import 'package:flutter/material.dart';
import 'package:flutterdemols/AppRouter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter',
      theme: ThemeData(// 主题
        primarySwatch: Colors.blue,//导航栏颜色
        scaffoldBackgroundColor: Colors.greenAccent,//页面背景色
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),//
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      showPerformanceOverlay: false,
      debugShowMaterialGrid: false,//开启网格 例如: true false
      routerConfig: router,
    );
  }

}

