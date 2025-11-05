import 'package:flutter/material.dart';

enum AnimationDirection { up, down, left, right }

class AnimationManager {
  static void startAnimation({
    required BuildContext context,
    required Widget child,
    required AnimationDirection direction,
    required double offset,
    Duration duration = const Duration(seconds: 5),
    Duration delay = Duration.zero,
  }) {
    final overlay = Overlay.of(context);
    if (overlay == null) return;

    // 先声明，再赋值 —— 关键点
    OverlayEntry? entry;
    entry = OverlayEntry(builder: (_) {
      return _AnimatedView(
        child: child,
        direction: direction,
        offset: offset,
        duration: duration,
        delay: delay,
        onEnd: () {
          // 使用可空访问，避免未初始化或重复移除的问题
          entry?.remove();
        },
      );
    });

    overlay.insert(entry);
  }
}

class _AnimatedView extends StatefulWidget {
  final Widget child;
  final AnimationDirection direction;
  final double offset;
  final Duration duration;
  final Duration delay;
  final VoidCallback onEnd;

  const _AnimatedView({
    Key? key,
    required this.child,
    required this.direction,
    required this.offset,
    required this.duration,
    required this.delay,
    required this.onEnd,
  }) : super(key: key);

  @override
  State<_AnimatedView> createState() => _AnimatedViewState();
}

class _AnimatedViewState extends State<_AnimatedView>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<Offset> _position;
  late final Animation<double> _opacity;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(vsync: this, duration: widget.duration);

    Offset begin;
    switch (widget.direction) {
      case AnimationDirection.up:
        begin = Offset(0, -widget.offset);
        break;
      case AnimationDirection.down:
        begin = Offset(0, widget.offset);
        break;
      case AnimationDirection.left:
        begin = Offset(-widget.offset, 0);
        break;
      case AnimationDirection.right:
        begin = Offset(widget.offset, 0);
        break;
    }

    _position = Tween<Offset>(begin: begin, end: Offset.zero).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic),
    );

    _opacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic),
    );

    Future.delayed(widget.delay, () {
      if (!mounted) return;
      _controller.forward().whenComplete(() {
        widget.onEnd();
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 使用 Center + Transform.translate 保持和原来 center/alpha 行为一致
    return Center(
      child: AnimatedBuilder(
        animation: _controller,
        builder: (_, child) {
          return Transform.translate(
            offset: _position.value,
            child: Opacity(
              opacity: _opacity.value,
              child: child,
            ),
          );
        },
        child: widget.child,
      ),
    );
  }
}
