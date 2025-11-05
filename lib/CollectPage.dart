import 'package:flutter/material.dart';

class CollectPage extends StatefulWidget {
  const CollectPage({Key? key}) : super(key: key);

  @override
  State<CollectPage> createState() => _CollectPage();
}

class _CollectPage extends State<CollectPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(//手脚架组件
      appBar: AppBar(
        title: const Text('收藏'),
        backgroundColor: Colors.blue[300],
      ),
      body: Center(// 设置剧中对齐
        child: Text('i am is text ')
      ),
    );
  }

}
