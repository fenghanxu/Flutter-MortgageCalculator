import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';

/// 字符串扩展工具类
class StringExtension {
  /// 字符串倒序
  static String reverse(String oldStr) {
    return oldStr.split('').reversed.join();
  }

  /// 字符串转 JSON 安全字符串
  /// 类似 OC 版本中的转义字符处理
  static String stringToJSONString(String input) {
    return input
        .replaceAll('"', '\\"')
        .replaceAll('/', '\\/')
        .replaceAll('\n', '\\n')
        .replaceAll('\b', '\\b')
        .replaceAll('\f', '\\f')
        .replaceAll('\r', '\\r')
        .replaceAll('\t', '\\t');
  }

  /// JSON 字符串转 Map
  static Map<String, dynamic>? convertToDictionary(String jsonString) {
    try {
      return json.decode(jsonString);
    } catch (e) {
      debugPrint('JSON decode error: $e');
      return null;
    }
  }

  /// 字典(Map) 转 JSON 字符串
  static String convertToJsonData(Map<String, dynamic> dict) {
    try {
      // pretty print -> false 去掉空格和换行
      return json.encode(dict);
    } catch (e) {
      debugPrint('JSON encode error: $e');
      return '';
    }
  }

  /// 返回文字的 size（用于 Text 渲染前计算）
  static Size textSize(String text, TextStyle style, {Size? maxSize}) {
    final TextPainter textPainter = TextPainter(
      text: TextSpan(text: text, style: style),
      maxLines: null,
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: maxSize?.width ?? double.infinity);

    return textPainter.size;
  }


  /// 生成随机字符串
  static String randomString(int len) {
    const letters =
        'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    final rand = Random.secure();
    return List.generate(len, (_) => letters[rand.nextInt(letters.length)])
        .join();
  }

  /// 指定字符集随机生成字符串
  static String randomStringWithLetters(int len, String letters) {
    final rand = Random.secure();
    return List.generate(len, (_) => letters[rand.nextInt(letters.length)])
        .join();
  }
}
