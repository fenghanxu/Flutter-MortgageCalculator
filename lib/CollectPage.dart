import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutterdemols/Base/Extension/ColorApp.dart';

class CollectPage extends StatefulWidget {
  const CollectPage({Key? key}) : super(key: key);

  @override
  State<CollectPage> createState() => _CollectPageState();
}

class _CollectPageState extends State<CollectPage> {
  int _selectedIndex = 0;
  final List<String> _categories = ['全部收藏', '商业贷款', '公积金贷款', '组合贷款'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('收藏'),
        backgroundColor:const Color(0xFFF9FAFB),
      ),
      body: Container(
        color: const Color(0xFFF9FAFB),
        child: Column(
          children: [
            // 分类滚动区域
            _buildCategoryScroll(),
            // 列表区域
            Expanded(
              child: _buildListView(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryScroll() {
    return Container(
      height: 70,
      color: const Color(0xFFF9FAFB),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: List.generate(_categories.length, (index) {
            return Padding(
              padding: EdgeInsets.only(
                left: index == 0 ? 15 : 10,
                right: index == _categories.length - 1 ? 15 : 0,
              ),
              child: _buildCategoryButton(_categories[index], index),
            );
          }),
        ),
      ),
    );
  }

  Widget _buildCategoryButton(String title, int index) {
    bool isSelected = _selectedIndex == index;

    return Container(
      width: _getButtonWidth(title),
      height: 40,
      decoration: BoxDecoration(
        color: isSelected ? ColorApp.themeWeak : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: isSelected ? null : Border.all(color: ColorApp.line, width: 1),
      ),
      child: TextButton(
        onPressed: () {
          setState(() {
            _selectedIndex = index;
          });
        },
        child: Text(
          title,
          style: TextStyle(
            fontSize: 14,
            color: isSelected ? ColorApp.theme : ColorApp.textSub,
          ),
        ),
      ),
    );
  }

  double _getButtonWidth(String title) {
    switch (title) {
      case '全部收藏':
        return 90;
      case '商业贷款':
        return 90;
      case '公积金贷款':
        return 110;
      case '组合贷款':
        return 90;
      default:
        return 90;
    }
  }

  Widget _buildListView() {
    return ListView.builder(
      padding: const EdgeInsets.all(0),
      itemCount: 2, // 模拟数据
      itemBuilder: (context, index) {
        return _buildListItem();
      },
    );
  }

  Widget _buildListItem() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
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
          // 标题行
          _buildTitleRow(),
          // 时间
          _buildTimeRow(),
          // 贷款信息
          _buildLoanInfoRow(),
          // 底部信息
          _buildBottomRow(),
        ],
      ),
    );
  }

  Widget _buildTitleRow() {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Row(
        children: [
          Text(
            '商业贷款 - 等额本息',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const Spacer(),
          IconButton(
            icon: Icon(
              Icons.favorite,
              color: ColorApp.theme,
              size: 24,
            ),
            onPressed: () {
              // 收藏按钮点击事件
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTimeRow() {
    return Padding(
      padding: const EdgeInsets.only(left: 15, bottom: 15),
      child: Text(
        '2023-10-11 14:30',
        style: TextStyle(
          fontSize: 14,
          color: ColorApp.textSub,
        ),
      ),
    );
  }

  Widget _buildLoanInfoRow() {
    return Row(
      children: [
        _buildInfoItem('贷款金额', '100万', 0.333),
        _buildInfoItem('贷款期限', '30年', 0.333),
        _buildInfoItem('贷款利率', '4.9%', 0.333),
      ],
    );
  }

  Widget _buildInfoItem(String title, String value, double widthFactor) {
    double screenWidth = MediaQuery.of(context).size.width;
    double itemWidth = (screenWidth - 30) * widthFactor;

    return Container(
      width: itemWidth,
      height: 70,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              color: ColorApp.textSub,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              color: ColorApp.textBlank,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomRow() {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Row(
        children: [
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: _formatNumberString('5320'),
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                TextSpan(
                  text: ' 元/月',
                  style: TextStyle(
                    fontSize: 14,
                    color: ColorApp.textSub,
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
          Container(
            width: 90,
            height: 30,
            child: TextButton.icon(
              onPressed: () {
                // 查看详情点击事件
              },
              icon: Icon(
                Icons.arrow_forward_ios,
                size: 14,
                color: ColorApp.theme,
              ),
              label: Text(
                '查看详情',
                style: TextStyle(
                  fontSize: 14,
                  color: ColorApp.theme,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _formatNumberString(String numberString) {
    try {
      // 移除可能存在的非数字字符（除了数字和小数点）
      String cleanString = numberString.replaceAll(RegExp(r'[^\d.]'), '');

      // 解析数字
      double number = double.parse(cleanString);

      // 格式化数字
      final formatter = NumberFormat('#,###');
      return formatter.format(number);
    } catch (e) {
      // 如果格式化失败，返回原始字符串
      return numberString;
    }
  }
}
