import 'dart:convert';
import 'package:encrypt/encrypt.dart';
import 'package:pointycastle/asymmetric/api.dart';
import 'package:flutter/services.dart' show rootBundle;

class RSAEncryptor {
  /// -----------------------
  /// 🔹 公钥字符串加密
  /// -----------------------
  static String encryptWithPublicKey(String plainText, String publicKeyPem) {
    final publicKey = RSAKeyParser().parse(publicKeyPem) as RSAPublicKey;
    final encrypter = Encrypter(RSA(publicKey: publicKey, encoding: RSAEncoding.PKCS1));
    final encrypted = encrypter.encrypt(plainText);
    return encrypted.base64;
  }

  /// -----------------------
  /// 🔹 私钥字符串解密
  /// -----------------------
  static String decryptWithPrivateKey(String base64Cipher, String privateKeyPem) {
    final privateKey = RSAKeyParser().parse(privateKeyPem) as RSAPrivateKey;
    final encrypter = Encrypter(RSA(privateKey: privateKey, encoding: RSAEncoding.PKCS1));
    final decrypted = encrypter.decrypt(Encrypted.fromBase64(base64Cipher));
    return decrypted;
  }

  /// -----------------------
  /// 🔹 从 `.der` 文件加载公钥并加密
  /// -----------------------
  static Future<String> encryptWithDerFile(String plainText) async {
    // 从 assets 加载 DER 文件
    final derData = await rootBundle.load('assets/keys/public_key.der');
    final bytes = derData.buffer.asUint8List();

    // DER 转 PEM
    final publicKeyPem = _convertDerToPem(bytes, 'PUBLIC KEY');

    // 使用公钥加密
    return encryptWithPublicKey(plainText, publicKeyPem);
  }

  /// -----------------------
  /// 🔹 从 `.p12` 文件加载私钥并解密
  /// -----------------------
  static Future<String> decryptWithP12File(
      String base64Cipher, String p12Path, String password) async {
    // ⚠️ 注意：Flutter/Dart 没有原生解析 .p12 功能，
    // 可在后端或原生层提取 PEM 格式私钥后传入此函数。
    throw UnimplementedError(
        'Dart 暂不支持直接解析 .p12 文件，请在服务器或原生层转换为 PEM 格式。');
  }

  /// -----------------------
  /// 工具方法：DER → PEM
  /// -----------------------
  static String _convertDerToPem(List<int> bytes, String type) {
    final base64Str = base64.encode(bytes);
    final chunks = <String>[];
    for (var i = 0; i < base64Str.length; i += 64) {
      chunks.add(base64Str.substring(i, i + 64 > base64Str.length ? base64Str.length : i + 64));
    }
    return '-----BEGIN $type-----\n${chunks.join('\n')}\n-----END $type-----';
  }
}
