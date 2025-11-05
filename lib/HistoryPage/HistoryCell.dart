// history_cell.dart
import 'package:flutter/material.dart';
import 'package:flutterdemols/Base/Extension/ColorApp.dart';

class HistoryCell extends StatelessWidget {
  final Map<String, dynamic> data;
  final VoidCallback onCollect;
  final VoidCallback onDelete;
  final VoidCallback onTap;

  const HistoryCell({
    Key? key,
    required this.data,
    required this.onCollect,
    required this.onDelete,
    required this.onTap,
  }) : super(key: key);

  String _formatNumberString(String numberString) {
    try {
      // 移除非数字字符（除了数字和小数点）
      String cleanString = numberString.replaceAll(RegExp(r'[^\d.]'), '');

      // 格式化数字，添加千位分隔符
      if (cleanString.isNotEmpty) {
        double number = double.parse(cleanString);
        String formatted = number.toStringAsFixed(0).replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
              (Match m) => '${m[1]},',
        );
        return formatted;
      }
      return numberString;
    } catch (e) {
      return numberString;
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final itemWidth = (screenWidth - 30) * 0.333;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              offset: const Offset(0, 2),
              blurRadius: 3,
              spreadRadius: 0,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 标题行
            Padding(
              padding: const EdgeInsets.all(15),
              child: Row(
                children: [
                  Text(
                    data['title'] ?? '',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const Spacer(),
                  // 收藏按钮
                  IconButton(
                    icon: Icon(
                      data['isCollected'] == true
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: data['isCollected'] == true
                          ? Colors.red
                          : ColorApp.textSub,
                      size: 20,
                    ),
                    onPressed: onCollect,
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(
                      minWidth: 30,
                      minHeight: 30,
                    ),
                  ),
                  // 删除按钮
                  IconButton(
                    icon: Icon(
                      Icons.delete_outline,
                      color: ColorApp.textSub,
                      size: 20,
                    ),
                    onPressed: onDelete,
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(
                      minWidth: 30,
                      minHeight: 30,
                    ),
                  ),
                ],
              ),
            ),
            // 时间
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
              child: Text(
                data['time'] ?? '',
                style: TextStyle(
                  fontSize: 14,
                  color: ColorApp.textSub,
                ),
              ),
            ),
            // 贷款信息三列
            Container(
              height: 70,
              child: Row(
                children: [
                  // 贷款金额
                  SizedBox(
                    width: itemWidth,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '贷款金额',
                          style: TextStyle(
                            fontSize: 14,
                            color: ColorApp.textSub,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          data['loanAmount'] ?? '',
                          style: TextStyle(
                            fontSize: 14,
                            color: ColorApp.textBlank,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // 贷款期限
                  SizedBox(
                    width: itemWidth,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '贷款期限',
                          style: TextStyle(
                            fontSize: 14,
                            color: ColorApp.textSub,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          data['loanTerm'] ?? '',
                          style: TextStyle(
                            fontSize: 14,
                            color: ColorApp.textBlank,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // 贷款利率
                  SizedBox(
                    width: itemWidth,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '贷款利率',
                          style: TextStyle(
                            fontSize: 14,
                            color: ColorApp.textSub,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          data['interestRate'] ?? '',
                          style: TextStyle(
                            fontSize: 14,
                            color: ColorApp.textBlank,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // 月供和详情按钮
            Padding(
              padding: const EdgeInsets.all(15),
              child: Row(
                children: [
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: _formatNumberString(data['monthlyPayment'] ?? ''),
                          style: const TextStyle(
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
                      onPressed: onTap,
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
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}