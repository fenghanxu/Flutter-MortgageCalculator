import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class KeyChainStore {
  static const FlutterSecureStorage _storage = FlutterSecureStorage();

  /// 保存数据
  static Future<void> save(String service, String data) async {
    await _storage.write(key: service, value: data);
  }

  /// 读取数据
  static Future<String?> load(String service) async {
    return await _storage.read(key: service);
  }

  /// 删除数据
  static Future<void> deleteKeyData(String service) async {
    await _storage.delete(key: service);
  }
}
