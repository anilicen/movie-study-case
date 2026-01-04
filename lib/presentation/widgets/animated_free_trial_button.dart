import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_study_case/config/theme/app_colors.dart';

class AnimatedFreeTrialButton extends StatefulWidget {
  final VoidCallback? onPressed;
  final String line1;
  final String line2;
  final bool isLoading;

  const AnimatedFreeTrialButton({
    super.key,
    required this.onPressed,
    required this.line1,
    required this.line2,
    this.isLoading = false,
  });

  @override
  State<AnimatedFreeTrialButton> createState() =>
      _AnimatedFreeTrialButtonState();
}

class _AnimatedFreeTrialButtonState extends State<AnimatedFreeTrialButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    )..repeat(reverse: true);

    _scaleAnimation = Tween<double>(
      begin: -20.w,
      end: 0.w,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SizedBox(
          height: 60.h,
          child: AnimatedBuilder(
            animation: _scaleAnimation,
            builder: (context, child) {
              final double extraWidth = _scaleAnimation.value * 2;
              final double currentWidth = constraints.maxWidth + extraWidth;

              return OverflowBox(
                maxWidth: currentWidth,
                minWidth: currentWidth,
                maxHeight: null,
                minHeight: 0,
                alignment: Alignment.center,
                child: GestureDetector(
                  onTap: widget.isLoading ? null : widget.onPressed,
                  child: Container(
                    width: currentWidth,
                    decoration: BoxDecoration(
                      color: AppColors.kLightRed,
                      borderRadius: BorderRadius.circular(16.r),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.kLightRed.withValues(alpha: 0.5),
                          blurRadius: 20,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: Center(
                      child: widget.isLoading
                          ? SizedBox(
                              height: 24.h,
                              width: 24.w,
                              child: const CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2,
                              ),
                            )
                          : Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  widget.line1,
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                Text(
                                  widget.line2,
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
