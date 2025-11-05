import 'package:flutter/material.dart';

class CalculatorDetail extends StatefulWidget {
  const CalculatorDetail({Key? key}) : super(key: key);

  @override
  State<CalculatorDetail> createState() => _CalculatorDetail();
}

class _CalculatorDetail extends State<CalculatorDetail> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(//手脚架组件
      appBar: AppBar(
        title: const Text('Flutter'),
        backgroundColor: Colors.blue[300],
      ),
      body: Center(// 设置剧中对齐
        child: Text('i am is text ')
      ),
    );
  }
  
}
