import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

enum NetworkType {
  none,
  wifi,
  cellular,
}

class NetworkManager {
  NetworkManager._internal();
  static final NetworkManager _instance = NetworkManager._internal();
  static NetworkManager get shared => _instance;

  final Connectivity _connectivity = Connectivity();

  // 订阅使用 dynamic，以兼容 ConnectivityResult 或 List<ConnectivityResult>
  StreamSubscription<dynamic>? _subscription;

  NetworkType _lastNetworkType = NetworkType.none;
  bool _isFirst = true;

  // 用 stream 模拟 NotificationCenter（广播）
  final StreamController<Map<String, dynamic>> _networkChangedController =
  StreamController<Map<String, dynamic>>.broadcast();

  Stream<Map<String, dynamic>> get onNetworkChanged =>
      _networkChangedController.stream;

  final StreamController<Map<String, dynamic>> _networkTrendController =
  StreamController<Map<String, dynamic>>.broadcast();

  Stream<Map<String, dynamic>> get onNetworkTrend =>
      _networkTrendController.stream;

  /// 启动监听
  void startMonitoring() {
    _subscription?.cancel();

    _subscription = _connectivity.onConnectivityChanged.listen((dynamic event) async {
      // 先规范化为 ConnectivityResult
      ConnectivityResult result;
      if (event is List && event.isNotEmpty) {
        // event 可能是 List<ConnectivityResult>
        final first = event.first;
        if (first is ConnectivityResult) {
          result = first;
        } else {
          // 万一 first 不是枚举，降级处理
          result = ConnectivityResult.none;
        }
      } else if (event is ConnectivityResult) {
        result = event;
      } else if (event is String) {
        // 有些平台/版本可能返回字符串，做个防御性解析
        result = _parseConnectivityResultFromString(event);
      } else {
        result = ConnectivityResult.none;
      }

      // 以下为你原来的逻辑（将 result 映射为 NetworkType 等）
      final currentType = await _mapConnectivityResult(result);
      _notifyNetworkChanged(currentType);

      if (_isFirst) {
        _isFirst = false;
        _lastNetworkType = currentType;
        return;
      }

      if (currentType != _lastNetworkType) {
        int trendType = 0;
        if (currentType == NetworkType.none && _lastNetworkType == NetworkType.wifi) {
          trendType = 1;
        } else if (currentType == NetworkType.wifi && _lastNetworkType == NetworkType.cellular) {
          trendType = 2;
        } else if (currentType == NetworkType.cellular && _lastNetworkType == NetworkType.wifi) {
          trendType = 3;
        }

        if (trendType != 0) _notifyNetworkTrend(trendType);
        _lastNetworkType = currentType;
      }
    });
  }

  ConnectivityResult _parseConnectivityResultFromString(String s) {
    final lower = s.toLowerCase();
    if (lower.contains('wifi')) return ConnectivityResult.wifi;
    if (lower.contains('mobile') || lower.contains('cell')) return ConnectivityResult.mobile;
    if (lower.contains('ethernet')) return ConnectivityResult.ethernet;
    if (lower.contains('none') || lower.contains('disconnected')) return ConnectivityResult.none;
    return ConnectivityResult.none;
  }

  /// 停止监听（保留 stream 控制器，可继续订阅）
  void stopMonitoring() {
    _subscription?.cancel();
    _subscription = null;
  }

  /// 如果需要彻底释放资源（可选）
  void dispose() {
    stopMonitoring();
    _networkChangedController.close();
    _networkTrendController.close();
  }

  /// 获取当前网络类型（兼容 checkConnectivity 返回 list 的情况）
  Future<NetworkType> currentNetworkType() async {
    final dynamic res = await _connectivity.checkConnectivity();
    ConnectivityResult result;
    if (res is List && res.isNotEmpty) {
      result = res.first as ConnectivityResult;
    } else if (res is ConnectivityResult) {
      result = res;
    } else {
      result = ConnectivityResult.none;
    }
    return _mapConnectivityResult(result);
  }

  /// 是否能连通互联网（真实可访问）
  Future<bool> isNetworkReachable() async {
    return await InternetConnectionChecker().hasConnection;
  }

  Future<NetworkType> _mapConnectivityResult(ConnectivityResult result) async {
    switch (result) {
      case ConnectivityResult.mobile:
        return NetworkType.cellular;
      case ConnectivityResult.wifi:
      case ConnectivityResult.ethernet:
      // ethernet 也把它当作有线/WiFi 类网络来处理
        return NetworkType.wifi;
      case ConnectivityResult.bluetooth:
      case ConnectivityResult.vpn:
      case ConnectivityResult.other:
      // 这些视情况而定，这里视作有网络（归类为 wifi），你也可以单独处理
        return NetworkType.wifi;
      case ConnectivityResult.none:
      default:
        return NetworkType.none;
    }
  }

  void _notifyNetworkChanged(NetworkType type) {
    _networkChangedController.add({"type": type.index});
  }

  void _notifyNetworkTrend(int trendType) {
    _networkTrendController.add({"type": trendType});
  }
}
