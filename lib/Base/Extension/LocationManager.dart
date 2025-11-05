import 'package:geolocator/geolocator.dart';

class LocationManager {
  // 单例模式，可选
  LocationManager._privateConstructor();
  static final LocationManager instance = LocationManager._privateConstructor();

  /// 判断是否打开定位服务，并且APP是否有权限
  static Future<bool> determineWhetherTheAPPOpensTheLocation() async {
    // 1. 检查设备定位服务是否开启
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return false; // 定位服务未开启
    }

    // 2. 检查APP权限
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      // 请求权限
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return false; // 用户拒绝权限
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // 用户永久拒绝权限
      return false;
    }

    // 3. 已授权定位
    return true;
  }
}
