import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';

// import 'package:flutter_inappwebview/flutter_inappwebview.dart';
// import 'package:flutter_inappwebview/flutter_inappwebview.dart';


// + flutter_inappwebview 6.1.5
// + flutter_inappwebview_android 1.1.3
// + flutter_inappwebview_internal_annotations 1.2.0
// + flutter_inappwebview_ios 1.1.2
// + flutter_inappwebview_macos 1.1.2
// + flutter_inappwebview_platform_interface 1.3.0+1
// + flutter_inappwebview_web 1.1.2
// + flutter_inappwebview_windows 0.6.0

class WebPage extends StatefulWidget {
  const WebPage({Key? key}) : super(key: key);

  @override
  State<WebPage> createState() => _WebPageState();
}

class _WebPageState extends State<WebPage> {

  @override
  void initState() {
    super.initState();
    _loadLocalHtml();
  }

  Future<void> _loadLocalHtml() async {
    // 1. 读取 assets 里的 html
    String htmlData = await rootBundle.loadString("assets/html/关于我们.html");

    // 2. 写入到临时目录
    Directory tempDir = await getTemporaryDirectory();
    File file = File("${tempDir.path}/关于我们.html");
    await file.writeAsString(htmlData, flush: true);

    // 3. 使用 url_launcher 以 file:// 方式打开
    final uri = Uri.file(file.path);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.inAppWebView);
      // mode 说明：
      // inAppWebView  = 内置网页打开（类似 WKWebView）
      // externalApp   = 跳浏览器
    } else {
      debugPrint("无法打开本地 HTML");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('用户服务协议'),
        backgroundColor: Colors.blue[300],
      ),
      body: const Center(
        child: Text("正在加载协议...", style: TextStyle(color: Colors.grey)),
      ),
    );
  }
}
