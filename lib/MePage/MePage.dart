import 'package:flutter/material.dart';
import 'package:flutterdemols/Base/Extension/ColorApp.dart';
import 'package:flutterdemols/MePage/MeButton.dart';
import 'package:flutterdemols/WebPage.dart';

class MePage extends StatefulWidget {
  const MePage({Key? key}) : super(key: key);

  @override
  State<MePage> createState() => _MePageState();
}

class _MePageState extends State<MePage> {
  String _cacheSize = "0.00";
  bool _isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    _loadCacheSize();
  }

  void _loadCacheSize() async {
    // 模拟获取缓存大小
    await Future.delayed(const Duration(milliseconds: 500));
    setState(() {
      _cacheSize = "12.34"; // 模拟缓存大小
    });
  }

  void _clearCache() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('清除缓存'),
        content: const Text('确定要清除缓存吗？'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('取消'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                _cacheSize = "0";
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('缓存清除成功')),
              );
            },
            child: const Text('确定'),
          ),
        ],
      ),
    );
  }

  void _navigateToLogin() {
    // 跳转到登录页面
    // Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
    setState(() {
      _isLoggedIn = true;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('跳转到登录页面')),
    );
  }

  void _navigateToCollection() {
    // 跳转到收藏页面或切换tab
    // 这里需要根据您的实际导航结构来实现
    // ScaffoldMessenger.of(context).showSnackBar(
    //   const SnackBar(content: Text('跳转到收藏记录')),
    // );
    Navigator.push(context, MaterialPageRoute(builder: (_) => WebPage()));
  }

  void _navigateToHistory() {
    // 跳转到历史页面或切换tab
    // 这里需要根据您的实际导航结构来实现
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('跳转到历史计算')),
    );
  }

  void _navigateToWeb(String title) {
    // 跳转到网页页面
    // Navigator.push(context, MaterialPageRoute(builder: (context) => WebPage(title: title)));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('跳转到$title')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorApp.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // 隐藏默认AppBar，使用自定义布局
              Container(
                height: kToolbarHeight,
                color: const Color(0xFFF9FAFB),
                child: Center(
                  child: Text(
                    '我的',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              // 登录卡片
              _buildLoginCard(),
              // 功能导航
              _buildFunctionCard(),
              // 系统设置
              _buildSettingCard(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLoginCard() {
    return Container(
      margin: const EdgeInsets.all(15),
      width: MediaQuery.of(context).size.width - 30,
      height: 250,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: const LinearGradient(
          colors: [Color(0xFF228B22), ColorApp.theme],
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
        ),
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
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // 头像
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40),
              border: Border.all(color: Colors.white, width: 2),
              image: const DecorationImage(
                image: AssetImage('assets/images/logo.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 15),
          // 标题
          Text(
            _isLoggedIn ? '欢迎回来' : '未登录',
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 15),
          // 副标题
          Text(
            _isLoggedIn ? '已同步您的计算记录' : '登录后可同步计算记录',
            style: const TextStyle(
              fontSize: 14,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 15),
          // 登录按钮
          if (!_isLoggedIn)
            ElevatedButton(
              onPressed: _navigateToLogin,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: ColorApp.theme,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
                minimumSize: const Size(100, 36),
              ),
              child: const Text(
                '立即登录',
                style: TextStyle(fontSize: 14),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildFunctionCard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
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
          // 标题
          const Padding(
            padding: EdgeInsets.all(15),
            child: Text(
              '功能导航',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          // 收藏记录按钮
          MeButton(
            imageColor: const Color(0xFFFEF9C3),
            imageName: 'me_collection@2x',
            title: '收藏记录',
            showArrow: true,
            onTap: _navigateToCollection,
          ),
          const Divider(height: 1, color: ColorApp.line),
          // 历史计算按钮
          MeButton(
            imageColor: const Color(0xFFDBEAFE),
            imageName: 'me_history@2x',
            title: '历史计算',
            showArrow: true,
            onTap: _navigateToHistory,
          ),
          const Divider(height: 1, color: ColorApp.line),
          // 最新利率按钮
          MeButton(
            imageColor: const Color(0xFFDCFCE7),
            imageName: 'me_interestRate@2x',
            title: '最新利率',
            showArrow: true,
            onTap: () => _navigateToWeb('最新利率'),
          ),
          const Divider(height: 1, color: ColorApp.line),
          // 房产知识按钮
          MeButton(
            imageColor: const Color(0xFFF3E8FF),
            imageName: 'me_knowledge@2x',
            title: '房产知识',
            showArrow: true,
            onTap: () => _navigateToWeb('房贷知识'),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingCard() {
    return Container(
      margin: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
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
          // 标题
          const Padding(
            padding: EdgeInsets.all(15),
            child: Text(
              '系统设置',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          // 关于我们按钮
          MeButton(
            imageColor: const Color(0xFFF3F4F6),
            imageName: 'me_our@2x',
            title: '关于我们',
            showArrow: true,
            onTap: () => _navigateToWeb('关于我们'),
          ),
          const Divider(height: 1, color: ColorApp.line),
          // 帮助中心按钮
          MeButton(
            imageColor: const Color(0xFFF3F4F6),
            imageName: 'me_help@2x',
            title: '帮助中心',
            showArrow: true,
            onTap: () => _navigateToWeb('帮助中心'),
          ),
          const Divider(height: 1, color: ColorApp.line),
          // 隐私政策按钮
          MeButton(
            imageColor: const Color(0xFFF3F4F6),
            imageName: 'me_policy@2x',
            title: '隐私政策',
            showArrow: true,
            onTap: () => _navigateToWeb('隐私政策'),
          ),
          const Divider(height: 1, color: ColorApp.line),
          // 清除缓存按钮
          MeButton(
            imageColor: const Color(0xFFF3F4F6),
            imageName: 'me_cache@2x',
            title: '清除缓存',
            showArrow: false,
            cacheSize: _cacheSize,
            onTap: _clearCache,
          ),
        ],
      ),
    );
  }
}
