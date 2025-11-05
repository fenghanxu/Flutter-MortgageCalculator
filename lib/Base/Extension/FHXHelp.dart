import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/services.dart';
import 'dart:ui' as ui;
import 'package:flutter/rendering.dart';


class FHXHelp {
  /// 拨打电话
  static Future<void> makePhoneCall(String tel) async {
    final Uri url = Uri(scheme: 'tel', path: tel);
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw '无法拨打电话: $tel';
    }
  }

  /// 判断手机号运营商类型
  static String judgePhoneNumType(String mobile) {
    final regCM = RegExp(r'^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\d)\d{7}$');
    final regCU = RegExp(r'^1(3[0-2]|4[5]|5[256]|7[6]|8[56])\d{8}$');
    final regCT = RegExp(r'^1((33|53|8[09])[0-9]|349)\d{7}$');

    if (regCM.hasMatch(mobile)) return "中国移动";
    if (regCU.hasMatch(mobile)) return "中国联通";
    if (regCT.hasMatch(mobile)) return "中国电信";
    return "未知";
  }

  /// 时间字符串 -> 时间戳
  static String timeStringToTimestamp(String time) {
    final dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");
    final date = dateFormat.parse(time);
    return (date.millisecondsSinceEpoch / 1000).toInt().toString();
  }

  /// 时间戳 -> 时间字符串
  static String timestampToTimeString(String timestamp) {
    final date = DateTime.fromMillisecondsSinceEpoch(int.parse(timestamp) * 1000);
    final dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");
    return dateFormat.format(date);
  }

  /// 获取 [年,月,日]
  static List<String> getYearMonthDay(String time) {
    return [time.substring(0, 4), time.substring(5, 7), time.substring(8, 10)];
  }

  /// 今天和明天的日期
  static List<List<String>> recentDates() {
    final now = DateTime.now();
    final tomorrow = now.add(const Duration(days: 1));
    final fmt = DateFormat("yyyy-MM-dd HH:mm:ss");
    return [
      getYearMonthDay(fmt.format(now)),
      getYearMonthDay(fmt.format(tomorrow))
    ];
  }

  /// 当前界面截图（需要 BuildContext）
  static Future<Uint8List?> captureWidget(GlobalKey key) async {
    try {
      RenderRepaintBoundary boundary =
      key.currentContext!.findRenderObject() as RenderRepaintBoundary;
      // 注意：这里使用 ui.Image
      ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      return byteData?.buffer.asUint8List();
    } catch (e) {
      debugPrint("截图失败: $e");
      return null;
    }
  }


  /// 去掉HTML标签
  static String removeHtmlTags(String html) {
    return html.replaceAll(RegExp(r'<[^>]*>|{[^}]*}'), '');
  }

  /// 随机数
  static int randomInt(int from, int to) {
    final rnd = Random();
    return from + rnd.nextInt(to - from + 1);
  }

  /// 添加边框
  static BoxDecoration border({
    bool top = false,
    bool left = false,
    bool bottom = false,
    bool right = false,
    Color color = Colors.black,
    double width = 1.0,
  }) {
    return BoxDecoration(
      border: Border(
        top: top ? BorderSide(color: color, width: width) : BorderSide.none,
        left: left ? BorderSide(color: color, width: width) : BorderSide.none,
        bottom: bottom ? BorderSide(color: color, width: width) : BorderSide.none,
        right: right ? BorderSide(color: color, width: width) : BorderSide.none,
      ),
    );
  }

  /// 数组去重
  static List<T> unique<T>(List<T> list) => list.toSet().toList();

  /// 图片缩放
  static Future<Image> scaleImage(Image image, Size size) async {
    return Image(
      image: image.image,
      width: size.width,
      height: size.height,
      fit: BoxFit.cover,
    );
  }

  /// 格式化千分位
  static String formatThousands(String number) {
    final n = double.tryParse(number) ?? 0.0;
    final formatter = NumberFormat("#,##0.00", "en_US");
    return formatter.format(n);
  }

  /// 不四舍五入保留小数位
  static String noRound(double value, int fractionDigits) {
    final factor = pow(10, fractionDigits);
    final truncated = (value * factor).truncate() / factor;
    return truncated.toStringAsFixed(fractionDigits);
  }

  /// 获取手机信息
  static Future<Map<String, dynamic>> getUserPhoneInfo() async {
    final deviceInfo = DeviceInfoPlugin();
    Map<String, dynamic> data = {};

    if (Platform.isIOS) {
      final ios = await deviceInfo.iosInfo;
      data = {
        "mobiletype": ios.utsname.machine,
        "sysversion": ios.systemVersion,
        "logintype": "IOS",
        "appversion": ios.systemName,
        "devicenumber": ios.identifierForVendor,
      };
    } else if (Platform.isAndroid) {
      final android = await deviceInfo.androidInfo;
      data = {
        "mobiletype": android.model,
        "sysversion": android.version.release,
        "logintype": "Android",
        "appversion": android.version.sdkInt.toString(),
        "devicenumber": android.id,
      };
    }

    return data;
  }

  /// 手机号格式化 138 8888 9999
  static String formatPhone(String phone) {
    if (phone.length != 11) return phone;
    return "${phone.substring(0, 3)} ${phone.substring(3, 7)} ${phone.substring(7)}";
  }

  /// 银行卡中间空格
  static String formatCard(String str) {
    final buffer = StringBuffer();
    for (int i = 0; i < str.length; i++) {
      buffer.write(str[i]);
      if ((i + 1) % 4 == 0 && i != str.length - 1) buffer.write(' ');
    }
    return buffer.toString();
  }
}
