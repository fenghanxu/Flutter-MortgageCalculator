//依赖的导入
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
//自定义底部TabbarView
import 'package:flutterdemols/TabbarItemView.dart';
//tabbar页面
import 'package:flutterdemols/CalculatorPage.dart';
import 'package:flutterdemols/CollectPage.dart';
import 'package:flutterdemols/HistoryPage.dart';
import 'package:flutterdemols/MePage.dart';
//普通页面
import 'package:flutterdemols/CalculatorDetail.dart';


//定义导航 Key（路由上下文）
final GlobalKey<NavigatorState> _calculatorTabNavigatorKey     = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> _collectTabNavigatorKey   = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> _historyTabNavigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> _meTabNavigatorKey    = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> _normalNavigatorKey      = GlobalKey<NavigatorState>();

final GoRouter router = GoRouter(
    navigatorKey: _normalNavigatorKey,
    initialLocation: '/calculator',//启动初始化显示路由地址
    routes: <RouteBase>[
      StatefulShellRoute.indexedStack(
          builder: (context, state, navigationShell) => TabbarItemView(navigationShell),//自定义底部TabbarView
          branches: [
            StatefulShellBranch(
                navigatorKey: _calculatorTabNavigatorKey,
                routes: <RouteBase>[
                  GoRoute(
                    path: '/calculator',
                    builder: (context, state) => CalculatorPage(),
                  ),
                ]
            ),
            StatefulShellBranch(
                navigatorKey: _collectTabNavigatorKey,
                routes: <RouteBase>[
                  GoRoute(
                    path: '/collect',
                    builder: (context, state) => CollectPage(),
                  )
                ]
            ),
            StatefulShellBranch(
                navigatorKey: _historyTabNavigatorKey,
                routes: <RouteBase>[
                  GoRoute(
                    path: '/history',
                    builder: (context, state) => HistoryPage(),
                  )
                ]
            ),
            StatefulShellBranch(
                navigatorKey: _meTabNavigatorKey,
                routes: <RouteBase>[
                  GoRoute(
                    path: '/me',
                    builder: (context, state) => const MePage(),
                  )
                ]
            ),
          ]
      ),
      GoRoute(
        parentNavigatorKey: _normalNavigatorKey,
        path: '/calculatorDetail',
        builder: (context, state) => CalculatorDetail(),
      )
    ]
);
