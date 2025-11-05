import 'package:flutter/material.dart';

class GetVC {
  /// 获取当前全局Context（需在MaterialApp中绑定navigatorKey）
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  /// 获取当前NavigatorState
  static NavigatorState? get navigator => navigatorKey.currentState;

  /// 获取当前Context
  static BuildContext? get context => navigatorKey.currentContext;

  /// 获取根路由（相当于RootViewController）
  static Widget? get rootWidget {
    final nav = navigator;
    if (nav == null) return null;
    return nav.widget;
  }

  /// 获取当前显示的Route
  static Route? get currentRoute {
    final nav = navigator;
    if (nav == null) return null;
    Route? current;
    nav.popUntil((route) {
      current = route;
      return true;
    });
    return current;
  }

  /// 获取当前页面Widget（相当于当前控制器）
  static Widget? get currentPage {
    final route = currentRoute;
    if (route is MaterialPageRoute) {
      return route.builder(navigatorKey.currentContext!);
    }
    return null;
  }

  /// 跳转到指定页面（等价于push）
  static Future<dynamic> push(Widget page) async {
    return navigator?.push(MaterialPageRoute(builder: (_) => page));
  }

  /// 返回上一个页面（等价于pop）
  static void pop<T extends Object?>([T? result]) {
    navigator?.pop(result);
  }

  /// 返回到根页面
  static void popToRoot() {
    navigator?.popUntil((route) => route.isFirst);
  }

  /// 通过GlobalKey获取Widget的State
  static T? getStateFromKey<T extends State>(GlobalKey<T> key) {
    return key.currentState;
  }

  /// 通过GlobalKey获取Widget
  static Widget? getWidgetFromKey(GlobalKey key) {
    return key.currentWidget;
  }

  /// 遍历Widget树（递归打印Widget结构）
  static void traverseWidgetTree(Element element, {int depth = 0}) {
    final indent = ' ' * depth;
    debugPrint('$indent${element.widget.runtimeType}');
    element.visitChildElements((child) {
      traverseWidgetTree(child, depth: depth + 2);
    });
  }

  /// 查找Widget树中指定类型的Widget
  static void findWidgetByType<T extends Widget>(Element element, List<T> result) {
    if (element.widget is T) {
      result.add(element.widget as T);
    }
    element.visitChildElements((child) {
      findWidgetByType(child, result);
    });
  }
}
