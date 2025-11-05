import 'package:flutter/material.dart';
import 'package:flutterdemols/Base/Extension/ColorApp.dart';

class MeButton extends StatelessWidget {
  final Color imageColor;
  final String imageName;
  final String title;
  final bool showArrow;
  final String? cacheSize;
  final VoidCallback? onTap;

  const MeButton({
    Key? key,
    required this.imageColor,
    required this.imageName,
    required this.title,
    this.showArrow = true,
    this.cacheSize,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 44,
        color: Colors.white,
        child: Row(
          children: [
            const SizedBox(width: 30),
            // 图标容器
            Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                color: imageColor,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Center(
                child: Image.asset(
                  'assets/images/$imageName.png',
                  width: 18,
                  height: 18,
                  color: Colors.black54,
                ),
              ),
            ),
            const SizedBox(width: 10),
            // 标题
            Text(
              title,
              style: const TextStyle(
                fontSize: 14,
                color: ColorApp.textTheme,
              ),
            ),
            const Spacer(),
            // 箭头或缓存大小
            if (showArrow)
              Icon(
                Icons.arrow_forward_ios,
                size: 15,
                color: ColorApp.textSub,
              )
            else
              Text(
                '${cacheSize ?? "0"}MB',
                style: TextStyle(
                  fontSize: 14,
                  color: ColorApp.nonActivated,
                ),
              ),
            const SizedBox(width: 10),
          ],
        ),
      ),
    );
  }
}