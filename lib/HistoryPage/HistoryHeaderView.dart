// history_header_view.dart
import 'package:flutter/material.dart';
import 'package:flutterdemols/Base/Extension/ColorApp.dart';

class HistoryHeaderView extends StatefulWidget {
  const HistoryHeaderView({Key? key}) : super(key: key);

  @override
  State<HistoryHeaderView> createState() => _HistoryHeaderViewState();
}

class _HistoryHeaderViewState extends State<HistoryHeaderView> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      color: const Color(0xFFF9FAFB),
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: ColorApp.line, width: 1),
        ),
        child: Row(
          children: [
            const SizedBox(width: 15),
            Icon(
              Icons.search,
              color: ColorApp.textSub,
              size: 20,
            ),
            const SizedBox(width: 15),
            Expanded(
              child: TextField(
                controller: _searchController,
                decoration: const InputDecoration(
                  hintText: '请输入搜索内容',
                  border: InputBorder.none,
                  hintStyle: TextStyle(fontSize: 14),
                ),
                style: const TextStyle(fontSize: 14, color: Colors.black),
                onChanged: (value) {
                  print(value);
                },
              ),
            ),
            if (_searchController.text.isNotEmpty)
              IconButton(
                icon: Icon(Icons.clear, color: ColorApp.textSub, size: 20),
                onPressed: () {
                  _searchController.clear();
                  setState(() {});
                },
              ),
            const SizedBox(width: 15),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}