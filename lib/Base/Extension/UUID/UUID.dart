import 'dart:async';
import 'package:uuid/uuid.dart';
import 'package:flutterdemols/Base/Extension/UUID/KeyChainStore.dart';

class UUID {
  static const String _service = "com.company.app.usernamepassword";

  static Future<String> getUUID() async {
    // 尝试读取
    String? strUUID = await KeyChainStore.load(_service);

    if (strUUID == null || strUUID.isEmpty) {
      // 生成新的 UUID
      strUUID = const Uuid().v4();

      // 保存到 Keychain
      await KeyChainStore.save(_service, strUUID);
    }

    return strUUID;
  }
}
