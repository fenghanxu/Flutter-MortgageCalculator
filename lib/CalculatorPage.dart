import 'package:flutter/material.dart';
import 'package:flutterdemols/Base/Extension/ColorApp.dart';
import 'package:flutterdemols/CalculatorDetailPage.dart';

class CalculatorPage extends StatefulWidget {
  const CalculatorPage({Key? key}) : super(key: key);

  @override
  State<CalculatorPage> createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  // 贷款方式相关变量
  int _selectedLoanMethod = 0; // 0: 商业贷款, 1: 公积金贷款, 2: 组合贷款

  // 计算方式相关变量
  int _selectedCalculateMethod = 0; // 0: 等额本息, 1: 等额本金, 2: 提前还款

  // 贷款金额相关变量
  final TextEditingController _loanAmountController = TextEditingController();
  double _loanAmountValue = 1.0;

  // 贷款期限相关变量
  final TextEditingController _loanTermController = TextEditingController();
  double _loanTermValue = 1.0;

  // 贷款利率相关变量
  final TextEditingController _loanInterestRateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loanAmountController.text = _loanAmountValue.toInt().toString();
    _loanTermController.text = _loanTermValue.toInt().toString();

    // 监听文本变化
    _loanAmountController.addListener(_onLoanAmountChanged);
    _loanTermController.addListener(_onLoanTermChanged);
  }

  @override
  void dispose() {
    _loanAmountController.dispose();
    _loanTermController.dispose();
    _loanInterestRateController.dispose();
    super.dispose();
  }

  void _onLoanAmountChanged() {
    final text = _loanAmountController.text;
    if (text.isNotEmpty) {
      final value = double.tryParse(text) ?? 1.0;
      setState(() {
        _loanAmountValue = value.clamp(1.0, 100.0);
      });
    }
  }

  void _onLoanTermChanged() {
    final text = _loanTermController.text;
    if (text.isNotEmpty) {
      final value = double.tryParse(text) ?? 1.0;
      setState(() {
        _loanTermValue = value.clamp(1.0, 30.0);
      });
    }
  }

  void _onLoanAmountSliderChanged(double value) {
    final roundedValue = value.roundToDouble();
    setState(() {
      _loanAmountValue = roundedValue;
      _loanAmountController.text = roundedValue.toInt().toString();
    });
  }

  void _onLoanTermSliderChanged(double value) {
    final roundedValue = value.roundToDouble();
    setState(() {
      _loanTermValue = roundedValue;
      _loanTermController.text = roundedValue.toInt().toString();
    });
  }

  void _onInterestRateButtonPressed(int index) {
    final rates = ['2.81', '3.0', '3.61', '4.26'];
    setState(() {
      _loanInterestRateController.text = rates[index];
    });
  }

  Widget _buildLoanMethodView() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            offset: const Offset(0, 2),
            blurRadius: 3,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '贷款方式',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 15),
          Row(
            children: [
              Expanded(
                child: _buildMethodButton(
                  '商业贷款',
                  0,
                  _selectedLoanMethod == 0,
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: _buildMethodButton(
                  '公积金贷款',
                  1,
                  _selectedLoanMethod == 1,
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: _buildMethodButton(
                  '组合贷款',
                  2,
                  _selectedLoanMethod == 2,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMethodButton(String text, int index, bool isSelected) {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          _selectedLoanMethod = index;
        });
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: isSelected ? ColorApp.themeWeak : Colors.white,
        foregroundColor: isSelected ? ColorApp.theme : const Color(0xFF8C8C8C),
        side: BorderSide(
          color: isSelected ? ColorApp.theme : const Color(0xFFD9D9D9),
          width: 1,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.symmetric(vertical: 12),
      ),
      child: Text(
        text,
        style: const TextStyle(fontSize: 14),
      ),
    );
  }

  Widget _buildCalculateView() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            offset: const Offset(0, 2),
            blurRadius: 3,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '计算方式',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 15),
          Row(
            children: [
              Expanded(
                child: _buildCalculateButton(
                  '等额本息',
                  0,
                  _selectedCalculateMethod == 0,
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: _buildCalculateButton(
                  '等额本金',
                  1,
                  _selectedCalculateMethod == 1,
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: _buildCalculateButton(
                  '提前还款',
                  2,
                  _selectedCalculateMethod == 2,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCalculateButton(String text, int index, bool isSelected) {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          _selectedCalculateMethod = index;
        });
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: isSelected ? ColorApp.themeWeak : Colors.white,
        foregroundColor: isSelected ? ColorApp.theme : const Color(0xFF8C8C8C),
        side: BorderSide(
          color: isSelected ? ColorApp.theme : const Color(0xFFD9D9D9),
          width: 1,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.symmetric(vertical: 12),
      ),
      child: Text(
        text,
        style: const TextStyle(fontSize: 14),
      ),
    );
  }

  Widget _buildLoanMessageView() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            offset: const Offset(0, 2),
            blurRadius: 3,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '贷款信息',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 30),
          // 贷款金额
          _buildLoanAmountSection(),
          const SizedBox(height: 30),
          // 贷款期限
          _buildLoanTermSection(),
          const SizedBox(height: 30),
          // 贷款利率
          _buildLoanInterestRateSection(),
        ],
      ),
    );
  }

  Widget _buildLoanAmountSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Text(
              '贷款金额',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            Text(
              '万元',
              style: TextStyle(
                fontSize: 14,
                color: Color(0xFFBFBFBF),
              ),
            ),
          ],
        ),
        const SizedBox(height: 15),
        TextField(
          controller: _loanAmountController,
          decoration: const InputDecoration(
            hintText: '请输入贷款金额',
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFFD9D9D9)),
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: ColorApp.theme),
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 10),
          ),
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
          keyboardType: TextInputType.number,
        ),
        const SizedBox(height: 20),
        Slider(
          value: _loanAmountValue,
          min: 1,
          max: 100,
          divisions: 99,
          activeColor: ColorApp.theme,
          inactiveColor: const Color(0xFFE5E5E5),
          onChanged: _onLoanAmountSliderChanged,
        ),
        const SizedBox(height: 13),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Text(
              '1万元',
              style: TextStyle(
                fontSize: 14,
                color: Color(0xFFBFBFBF),
              ),
            ),
            Text(
              '100万元',
              style: TextStyle(
                fontSize: 14,
                color: Color(0xFFBFBFBF),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildLoanTermSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Text(
              '贷款期限',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            Text(
              '年',
              style: TextStyle(
                fontSize: 14,
                color: Color(0xFFBFBFBF),
              ),
            ),
          ],
        ),
        const SizedBox(height: 15),
        TextField(
          controller: _loanTermController,
          decoration: const InputDecoration(
            hintText: '请输入贷款期限',
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFFD9D9D9)),
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: ColorApp.theme),
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 10),
          ),
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
          keyboardType: TextInputType.number,
        ),
        const SizedBox(height: 20),
        Slider(
          value: _loanTermValue,
          min: 1,
          max: 30,
          divisions: 29,
          activeColor: ColorApp.theme,
          inactiveColor: const Color(0xFFE5E5E5),
          onChanged: _onLoanTermSliderChanged,
        ),
        const SizedBox(height: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Text(
              '1年',
              style: TextStyle(
                fontSize: 14,
                color: Color(0xFFBFBFBF),
              ),
            ),
            Text(
              '30年',
              style: TextStyle(
                fontSize: 14,
                color: Color(0xFFBFBFBF),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildLoanInterestRateSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Text(
              '贷款利率',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            Text(
              '年',
              style: TextStyle(
                fontSize: 14,
                color: Color(0xFFBFBFBF),
              ),
            ),
          ],
        ),
        const SizedBox(height: 15),
        TextField(
          controller: _loanInterestRateController,
          decoration: const InputDecoration(
            hintText: '请输入贷款利率',
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFFD9D9D9)),
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: ColorApp.theme),
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 10),
          ),
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
          keyboardType: TextInputType.number,
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: _buildInterestRateButton('2.81%', 0),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _buildInterestRateButton('3.0%', 1),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _buildInterestRateButton('3.61%', 2),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _buildInterestRateButton('4.26%', 3),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildInterestRateButton(String text, int index) {
    return ElevatedButton(
      onPressed: () => _onInterestRateButtonPressed(index),
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFFF5F5F5),
        foregroundColor: const Color(0xFF8C8C8C),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.symmetric(vertical: 8),
      ),
      child: Text(
        text,
        style: const TextStyle(fontSize: 12),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('计算器'),
        backgroundColor: const Color(0xFFF9FAFB),
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      backgroundColor: const Color(0xFFF9FAFB),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: Column(
          children: [
            // 贷款方式
            _buildLoanMethodView(),
            const SizedBox(height: 15),
            // 计算方式
            _buildCalculateView(),
            const SizedBox(height: 15),
            // 贷款信息
            _buildLoanMessageView(),
            const SizedBox(height: 40),
            // 开始计算按钮
            Container(
              width: double.infinity,
              height: 60,
              margin: const EdgeInsets.symmetric(horizontal: 15),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CalculatorDetailPage(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorApp.theme,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: const Text(
                  '开始计算',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
