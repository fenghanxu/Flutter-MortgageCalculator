import 'package:flutter/material.dart';
import 'package:flutterdemols/Base/Extension/AppColor.dart';
import 'package:go_router/go_router.dart';
import 'package:flutterdemols/Base/Base.dart';

class TabbarItemView extends StatelessWidget {
  const TabbarItemView(this.navigationShell, {super.key});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    // final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: navigationShell.currentIndex,
        type: BottomNavigationBarType.fixed,
        // 设置选中项的颜色
        selectedItemColor: AppColor.theme, // 使用蓝色作为选中颜色
        // 设置未选中项的颜色
        unselectedItemColor: Colors.grey, // 未选中项的颜色
        selectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 12.0,
        ),

        // 设置未选中标签的样式
        unselectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.normal,
          fontSize: 12.0,
        ),
        items: [
          BottomNavigationBarItem(
              icon: _buildCustomIcon(0, 'assets/images/calculator_normal@2x.png', 'assets/images/calculator_select@2x.png'),
              label: '计算器'),
          BottomNavigationBarItem(
              icon: _buildCustomIcon(1, 'assets/images/collect_normal@2x.png', 'assets/images/collect_select@2x.png'),
              label: '收藏'),
          BottomNavigationBarItem(
              icon: _buildCustomIcon(2, 'assets/images/history_normal@2x.png', 'assets/images/history_select@2x.png'),
              label: '历史'),
          BottomNavigationBarItem(
              icon: _buildCustomIcon(3, 'assets/images/me_normal@2x.png', 'assets/images/me_select@2x.png'),
              label: '我的'),
        ],
        onTap: _onTap,
      ),
    );
  }

  Widget _buildCustomIcon(int index, String activeImage, String inactiveImage) {
    final isActive = navigationShell.currentIndex == index;
    return Image.asset(
      isActive ? inactiveImage : activeImage,
      width: 24, // 设置合适的宽度
      height: 24, // 设置合适的高度
      // color: isActive ? Colors.blue : Colors.grey, // 可选：设置颜色
    );
  }

  void _onTap(int index) {
    navigationShell.goBranch(index,
        initialLocation: index == navigationShell.currentIndex);
  }
}
