import 'package:flutter/material.dart';

class CalculatorPage extends StatefulWidget {
  const CalculatorPage({Key? key}) : super(key: key);

  @override
  State<CalculatorPage> createState() => _CalculatorPage();
}

class _CalculatorPage extends State<CalculatorPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(//手脚架组件
      appBar: AppBar(
        title: const Text('计算'),
        backgroundColor: Colors.blue[300],
      ),
      body: Center(// 设置剧中对齐
        child: Text('i am is text ')
      ),
    );
  }
  
}
