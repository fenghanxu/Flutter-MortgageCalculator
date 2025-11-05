import 'dart:convert';
import 'dart:typed_data';
import 'package:crypto/crypto.dart';
import 'package:pointycastle/export.dart';

class Encryp {
  static const String gKey = "EQwRjg3NEU5RDA3Q"; // 与OC中保持一致
  static const String gIv = "APs6\$^*(&(5sd1#^"; // 与OC中保持一致

  /// -------------------------------
  /// 🔹 MD5 加密（32位小写）
  /// -------------------------------
  static String md5Lower32(String input) {
    final bytes = utf8.encode(input);
    final digest = md5.convert(bytes);
    return digest.toString(); // 默认小写32位
  }

  /// -------------------------------
  /// 🔹 MD5 加密（32位大写）
  /// -------------------------------
  static String md5Upper32(String input) {
    return md5Lower32(input).toUpperCase();
  }

  /// -------------------------------
  /// 🔹 MD5 加密（16位小写）
  /// -------------------------------
  static String md5Lower16(String input) {
    final full = md5Lower32(input);
    return full.substring(8, 24);
  }

  /// -------------------------------
  /// 🔹 MD5 加密（16位大写）
  /// -------------------------------
  static String md5Upper16(String input) {
    return md5Lower16(input).toUpperCase();
  }

  /// -------------------------------
  /// 🔹 Base64 编码
  /// -------------------------------
  static String base64EncodeData(Uint8List data) {
    return base64.encode(data);
  }

  /// -------------------------------
  /// 🔹 Base64 解码
  /// -------------------------------
  static Uint8List base64DecodeData(String base64Str) {
    return base64.decode(base64Str);
  }

  /// -------------------------------
  /// 🔹 SHA1 加密
  /// -------------------------------
  static String sha1Encrypt(String input) {
    final bytes = utf8.encode(input);
    final digest = sha1.convert(bytes);
    return digest.toString();
  }

  /// -------------------------------
  /// 🔹 AES128 加密（补位）
  /// -------------------------------
  static String aes128Encrypt(String plainText) {
    final key = Uint8List.fromList(utf8.encode(gKey));
    final iv = Uint8List.fromList(utf8.encode(gIv));

    final blockCipher = CBCBlockCipher(AESFastEngine())
      ..init(
        true,
        ParametersWithIV(KeyParameter(key), iv),
      );

    final paddedData = _pkcs7Pad(Uint8List.fromList(utf8.encode(plainText)));

    final cipherText = _processBlocks(blockCipher, paddedData);
    return base64.encode(cipherText);
  }

  /// -------------------------------
  /// 🔹 AES128 解密
  /// -------------------------------
  static String aes128Decrypt(String base64Text) {
    final key = Uint8List.fromList(utf8.encode(gKey));
    final iv = Uint8List.fromList(utf8.encode(gIv));
    final cipherText = base64.decode(base64Text);

    final blockCipher = CBCBlockCipher(AESFastEngine())
      ..init(
        false,
        ParametersWithIV(KeyParameter(key), iv),
      );

    final decrypted = _processBlocks(blockCipher, cipherText);
    final unpadded = _pkcs7Unpad(decrypted);

    return utf8.decode(unpadded);
  }

  /// -------------------------------
  /// 🔹 内部方法：AES 分块处理
  /// -------------------------------
  static Uint8List _processBlocks(BlockCipher cipher, Uint8List input) {
    final output = Uint8List(input.length);
    var offset = 0;
    while (offset < input.length) {
      offset += cipher.processBlock(input, offset, output, offset);
    }
    return output;
  }

  /// -------------------------------
  /// 🔹 PKCS7 Padding
  /// -------------------------------
  static Uint8List _pkcs7Pad(Uint8List data) {
    final padLen = 16 - (data.length % 16);
    return Uint8List.fromList(data + List<int>.filled(padLen, padLen));
  }

  /// -------------------------------
  /// 🔹 PKCS7 Unpadding
  /// -------------------------------
  static Uint8List _pkcs7Unpad(Uint8List data) {
    final padLen = data.last;
    return data.sublist(0, data.length - padLen);
  }
}
