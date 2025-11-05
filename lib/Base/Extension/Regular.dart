import 'package:flutter/foundation.dart';

class Regular {
  /// 纳税号（15-20位，必须同时包含字母和数字）
  static bool validateTaxNumber(String? code) {
    if (code == null || code.isEmpty) return false;
    final pattern = RegExp(r'^(?![0-9]+$)(?![a-zA-Z]+$)[a-zA-Z0-9]{15,20}$');
    return pattern.hasMatch(code);
  }

  /// 银行卡账号（9-30位纯数字）
  static bool validateBankCode(String? code) {
    if (code == null || code.length <= 8 || code.length > 30) return false;
    final pattern = RegExp(r'^[0-9]+$');
    return pattern.hasMatch(code);
  }

  /// 手机号简单判断：1开头、11位、全数字
  static bool validateMobileNH(String? mobile) {
    if (mobile == null || mobile.isEmpty || mobile.length != 11) return false;
    final pattern = RegExp(r'^[0-9]+$');
    if (!pattern.hasMatch(mobile)) return false;
    return mobile.startsWith('1');
  }

  /// 手机号精确判断（移动/联通/电信/虚拟号段）
  static bool validateMobile(String? mobile) {
    if (mobile == null || mobile.isEmpty) return false;
    final pattern = RegExp(r'^1(3[0-9]|4[579]|5[0-35-9]|7[01356]|8[0-9])\d{8}$');
    return pattern.hasMatch(mobile);
  }

  /// 身份证号判断（15位或18位，最后一位可能是X/x）
  static bool validateIdentityCard(String? idCard) {
    if (idCard == null || idCard.isEmpty) return false;
    final pattern = RegExp(r'^(\d{14}|\d{17})(\d|[xX])$');
    return pattern.hasMatch(idCard);
  }

  /// 邮箱判断
  static bool validateEmail(String? email) {
    if (email == null || email.isEmpty) return false;
    final pattern = RegExp(r'^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,4}$');
    return pattern.hasMatch(email);
  }

  /// 7-12位纯数字
  static bool validateNum(String? number) {
    if (number == null || number.length < 7 || number.length > 12) return false;
    final pattern = RegExp(r'^[0-9]+$');
    return pattern.hasMatch(number);
  }
}
