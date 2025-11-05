import 'dart:math';

/// BinarySystem 工具类：
/// 实现任意进制（2~36）之间的互相转换。
class BinarySystem {
  /// 将 10 进制整数 [decimal] 转换为 N 进制字符串
  /// 例：BinarySystem.tenToN(255, 16) => "ff"
  static String tenToN(int decimal, int radix) {
    assert(radix >= 2 && radix <= 36, '进制数必须在 2~36 之间');

    if (decimal == 0) return "0";
    const digits = '0123456789abcdefghijklmnopqrstuvwxyz';
    var result = StringBuffer();

    var value = decimal;
    while (value > 0) {
      int remainder = value % radix;
      value ~/= radix; // 整除
      result.write(digits[remainder]);
    }

    // 翻转结果，因为计算时是从低位到高位
    return result.toString().split('').reversed.join('');
  }

  /// 将 N 进制字符串 [str] 转换为 10 进制整数
  /// 例：BinarySystem.nToTen("ff", 16) => 255
  static int nToTen(String str, int radix) {
    assert(radix >= 2 && radix <= 36, '进制数必须在 2~36 之间');

    const digits = '0123456789abcdefghijklmnopqrstuvwxyz';
    var lower = str.toLowerCase();
    int result = 0;

    for (int i = 0; i < lower.length; i++) {
      int digitValue = digits.indexOf(lower[i]);
      if (digitValue == -1 || digitValue >= radix) {
        throw FormatException("非法字符 '${lower[i]}' 对于 $radix 进制");
      }
      result += digitValue * pow(radix, lower.length - i - 1).toInt();
    }

    return result;
  }
}
