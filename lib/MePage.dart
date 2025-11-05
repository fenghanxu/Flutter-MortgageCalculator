import 'package:flutter/material.dart';

class MePage extends StatefulWidget {
  const MePage({Key? key}) : super(key: key);

  @override
  State<MePage> createState() => _MePage();
}

class _MePage extends State<MePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(//手脚架组件
      appBar: AppBar(
        title: const Text('我的'),
        backgroundColor: Colors.blue[300],
      ),
      body: Center(// 设置剧中对齐
          child: Text('i am is text ')
      ),
    );
  }

}
