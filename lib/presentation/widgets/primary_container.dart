import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movie_study_case/config/theme/app_colors.dart';

class PrimaryContainer extends StatelessWidget {
  final Widget? child;
  final bool isActive;

  const PrimaryContainer({super.key, this.child, this.isActive = false});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      foregroundPainter: isActive
          ? InnerShadowPainter(
              shadowColor: AppColors.kLightRed.withValues(alpha: 0.3),
              blurRadius: 60,
              spread: 24,
              borderRadius: BorderRadius.circular(16),
            )
          : null,
      child: Container(
        height: 252,
        width: 180,
        decoration: BoxDecoration(
          color: AppColors.kWhite,
          borderRadius: BorderRadius.circular(16),
        ),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          fit: StackFit.expand,
          children: [
            if (child != null) child!,
            if (isActive)
              Positioned(
                right: 16,
                bottom: 24,
                child: SvgPicture.asset('assets/checkmark.svg'),
              ),
          ],
        ),
      ),
    );
  }
}

class InnerShadowPainter extends CustomPainter {
  final Color shadowColor;
  final double blurRadius;
  final double spread;
  final BorderRadius borderRadius;

  InnerShadowPainter({
    required this.shadowColor,
    required this.blurRadius,
    required this.spread,
    required this.borderRadius,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Rect rect = Offset.zero & size;
    final RRect rrect = borderRadius.toRRect(rect);

    canvas.save();
    canvas.clipRRect(rrect);

    final Paint paint = Paint()
      ..color = shadowColor
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, blurSigma);

    final RRect innerRRect = rrect.deflate(spread);

    final Rect outerRect = rect.inflate(blurRadius + spread + 50);

    final Path path = Path()
      ..fillType = PathFillType.evenOdd
      ..addRect(outerRect)
      ..addRRect(innerRRect);

    canvas.drawPath(path, paint);
    canvas.restore();
  }

  double get blurSigma => blurRadius / 2;

  @override
  bool shouldRepaint(covariant InnerShadowPainter oldDelegate) {
    return oldDelegate.shadowColor != shadowColor ||
        oldDelegate.blurRadius != blurRadius ||
        oldDelegate.spread != spread ||
        oldDelegate.borderRadius != borderRadius;
  }
}
