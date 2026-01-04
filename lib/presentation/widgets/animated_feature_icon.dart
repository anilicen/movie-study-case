import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AnimatedFeatureIcon extends StatelessWidget {
  final bool isEnabled;
  final int index;

  const AnimatedFeatureIcon({
    super.key,
    required this.isEnabled,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40.h,
      width: 50.w,
      alignment: Alignment.center,
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 200),
        switchInCurve: Curves.easeOut,
        switchOutCurve: Curves.easeIn,
        transitionBuilder: (Widget child, Animation<double> animation) {
          return FadeTransition(opacity: animation, child: child);
        },
        child: isEnabled
            ? _FallingIcon(
                key: const ValueKey('check'),
                asset: 'assets/green_check_circle.png',
                isCheck: true,
                index: index,
              )
            : _FallingIcon(
                key: const ValueKey('cross'),
                asset: 'assets/gray-cross.png',
                isCheck: false,
                index: index,
              ),
      ),
    );
  }
}

class _FallingIcon extends StatefulWidget {
  final String asset;
  final bool isCheck;
  final int index;

  const _FallingIcon({
    super.key,
    required this.asset,
    required this.isCheck,
    required this.index,
  });

  @override
  State<_FallingIcon> createState() => _FallingIconState();
}

class _FallingIconState extends State<_FallingIcon>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    super.initState();

    Offset beginOffset = Offset.zero;
    int durationMs = 400;

    if (widget.isCheck) {
      beginOffset = const Offset(0, -1.5);
    } else {
      if (widget.index == 2) {
        beginOffset = const Offset(0, 1.5);
      } else if (widget.index == 3) {
        beginOffset = Offset.zero;
        durationMs = 0; // Instant
      } else {
        beginOffset = Offset.zero;
      }
    }

    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: durationMs),
    );

    _offsetAnimation = Tween<Offset>(
      begin: beginOffset,
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutBack));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_controller.duration == Duration.zero) {
      return Image.asset(widget.asset, width: 24.w, height: 24.h);
    }

    return SlideTransition(
      position: _offsetAnimation,
      child: Image.asset(widget.asset, width: 24.w, height: 24.h),
    );
  }
}
