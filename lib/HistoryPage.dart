import 'package:flutter/material.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  State<HistoryPage> createState() => _HistoryPage();
}

class _HistoryPage extends State<HistoryPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(//手脚架组件
      appBar: AppBar(
        title: const Text('历史'),
        backgroundColor: Colors.blue[300],
      ),
      body: Center(// 设置剧中对齐
          child: Text('i am is text ')
      ),
    );
  }

}