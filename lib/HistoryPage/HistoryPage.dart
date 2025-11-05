import 'package:flutter/material.dart';
import 'package:flutterdemols/HistoryPage/HistoryCell.dart';
import 'package:flutterdemols/HistoryPage/HistoryHeaderView.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  final List<Map<String, dynamic>> _historyData = [
    {
      'title': '商业贷款 - 等额本息',
      'time': '2023-10-11 14:30',
      'loanAmount': '100万',
      'loanTerm': '30年',
      'interestRate': '4.9%',
      'monthlyPayment': '5320',
      'isCollected': false,
    },
    {
      'title': '公积金贷款 - 等额本金',
      'time': '2023-10-10 09:15',
      'loanAmount': '80万',
      'loanTerm': '20年',
      'interestRate': '3.25%',
      'monthlyPayment': '4532',
      'isCollected': true,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('历史'),
        backgroundColor: const Color(0xFFF9FAFB),
        elevation: 0,
      ),
      backgroundColor: const Color(0xFFF9FAFB),
      body: Column(
        children: [
          // 搜索头部
          const HistoryHeaderView(),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.only(bottom: 20),
              itemCount: _historyData.length,
              itemBuilder: (context, index) {
                return HistoryCell(
                  data: _historyData[index],
                  onCollect: () {
                    setState(() {
                      _historyData[index]['isCollected'] =
                      !_historyData[index]['isCollected'];
                    });
                  },
                  onDelete: () {
                    setState(() {
                      _historyData.removeAt(index);
                    });
                  },
                  onTap: () {
                    print('点击了第$index个cell');
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}