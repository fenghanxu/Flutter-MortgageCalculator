import 'package:flutter/material.dart';
import 'package:flutterdemols/Base/Extension/ColorApp.dart';
import 'package:intl/intl.dart';

class CalculatorDetailPage extends StatefulWidget {
  const CalculatorDetailPage({Key? key}) : super(key: key);

  @override
  State<CalculatorDetailPage> createState() => _CalculatorDetailPageState();
}

class _CalculatorDetailPageState extends State<CalculatorDetailPage> {
  final int number = 5;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text('计算结果'),
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: ColorApp.textBlank,
      ),
      backgroundColor: ColorApp.background,
      body: SingleChildScrollView(
        child: Container(
          width: screenWidth,
          height: screenHeight + 10,
          color: ColorApp.background,
          child: Column(
            children: [
              // 结果视图
              _buildResultView(screenWidth),
              const SizedBox(height: 15),
              // 贷款信息视图
              _buildLoanInformationView(screenWidth),
              const SizedBox(height: 15),
              // 还款明细视图
              _buildRepaymentDetailView(screenWidth),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildResultView(double screenWidth) {
    return Container(
      width: screenWidth - 30,
      height: 200,
      margin: const EdgeInsets.only(top: 5, left: 15, right: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: const LinearGradient(
          begin: Alignment.centerRight,
          end: Alignment.centerLeft,
          colors: [Color(0xFF228B22), ColorApp.theme],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            offset: const Offset(0, 2),
            blurRadius: 3,
          ),
        ],
      ),
      child: Stack(
        children: [
          // 标题和副标题
          Positioned(
            left: 15,
            top: 15,
            child: Text(
              '等额本息还款',
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
              ),
            ),
          ),
          // 每月还款标题
          Positioned(
            top: 40,
            left: 0,
            right: 0,
            child: Center(
              child: Text(
                '每月还款',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
            ),
          ),
          // 还款金额
          Positioned(
            top: 70,
            left: 0,
            right: 0,
            child: Center(
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: _formatNumberString('5320'),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: '元/月',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // 底部信息
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Row(
              children: [
                // 总利息
                Container(
                  width: (screenWidth - 30) * 0.5,
                  height: 70,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '总利息',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        '91.05万',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                // 还款总额
                Container(
                  width: (screenWidth - 30) * 0.5,
                  height: 70,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '还款总额',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        '191.05万',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoanInformationView(double screenWidth) {
    return Container(
      width: screenWidth - 30,
      height: 180,
      margin: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            offset: const Offset(0, 2),
            blurRadius: 3,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            // 标题
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                '贷款信息',
                style: TextStyle(
                  color: ColorApp.textBlank,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 20),
            // 贷款金额
            _buildLoanInfoRow(
              '贷款金额',
              '100万',
            ),
            const SizedBox(height: 10),
            // 贷款期限
            _buildLoanInfoRow(
              '贷款期限',
              '30年(360期)',
            ),
            const SizedBox(height: 10),
            // 贷款利率
            _buildLoanInfoRow(
              '贷款利率',
              '4.90%',
            ),
            const SizedBox(height: 10),
            // 贷款方式
            _buildLoanInfoRow(
              '贷款方式',
              '等额本息',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoanInfoRow(String title, String value) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: TextStyle(
              color: ColorApp.textSub,
              fontSize: 14,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            textAlign: TextAlign.right,
            style: TextStyle(
              color: ColorApp.textBlank,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRepaymentDetailView(double screenWidth) {
    // 计算实际可用宽度（减去左右内边距）
    final availableWidth = screenWidth - 30 - 30; // 容器宽度减去左右内边距

    return Container(
      width: screenWidth - 30,
      margin: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            offset: const Offset(0, 2),
            blurRadius: 3,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            // 标题
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                '还款明细',
                style: TextStyle(
                  color: ColorApp.textBlank,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 15),
            // 表头
            CalculatorDetailHeaderView(availableWidth: availableWidth),
            // 还款明细项
            ...List.generate(number, (index) => RepaymentDetailSubView(
              availableWidth: availableWidth,
              period: '第${index + 1}期',
              monthlyPayment: '5307',
              principal: '1224',
              interest: '4083',
            )),
          ],
        ),
      ),
    );
  }

  String _formatNumberString(String numberString) {
    // 简单的数字格式化实现
    try {
      final number = double.tryParse(numberString);
      if (number != null) {
        final formatter = NumberFormat('#,###');
        return formatter.format(number);
      }
    } catch (e) {
      debugPrint('Format number error: $e');
    }
    return numberString;
  }
}

// 表头组件
class CalculatorDetailHeaderView extends StatelessWidget {
  final double availableWidth;

  const CalculatorDetailHeaderView({
    Key? key,
    required this.availableWidth,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44,
      color: Colors.white,
      child: Row(
        children: [
          // 期数
          Container(
            width: availableWidth * 0.2,
            child: Text(
              '期数',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: ColorApp.textSub,
                fontSize: 14,
              ),
            ),
          ),
          // 空白区域
          Container(
            width: availableWidth * 0.08,
            color: Colors.white,
          ),
          // 月供
          Container(
            width: availableWidth * 0.24,
            child: Text(
              '月供(元)',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: ColorApp.textSub,
                fontSize: 14,
              ),
            ),
          ),
          // 本金
          Container(
            width: availableWidth * 0.24,
            child: Text(
              '本金(元)',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: ColorApp.textSub,
                fontSize: 14,
              ),
            ),
          ),
          // 利息
          Container(
            width: availableWidth * 0.24,
            child: Text(
              '利息(元)',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: ColorApp.textSub,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// 还款明细子项组件
class RepaymentDetailSubView extends StatelessWidget {
  final double availableWidth;
  final String period;
  final String monthlyPayment;
  final String principal;
  final String interest;

  const RepaymentDetailSubView({
    Key? key,
    required this.availableWidth,
    required this.period,
    required this.monthlyPayment,
    required this.principal,
    required this.interest,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44,
      color: Colors.white,
      child: Row(
        children: [
          // 期数
          Container(
            width: availableWidth * 0.2,
            child: Text(
              period,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: ColorApp.textBlank,
                fontSize: 14,
              ),
            ),
          ),
          // 空白区域
          Container(
            width: availableWidth * 0.08,
            color: Colors.white,
          ),
          // 月供
          Container(
            width: availableWidth * 0.24,
            child: Text(
              monthlyPayment,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: ColorApp.textBlank,
                fontSize: 14,
              ),
            ),
          ),
          // 本金
          Container(
            width: availableWidth * 0.24,
            child: Text(
              principal,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: ColorApp.textBlank,
                fontSize: 14,
              ),
            ),
          ),
          // 利息
          Container(
            width: availableWidth * 0.24,
            child: Text(
              interest,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: ColorApp.textBlank,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}