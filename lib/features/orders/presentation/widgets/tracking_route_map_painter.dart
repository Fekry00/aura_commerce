import 'package:aura/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class TrackingRouteMapPainter extends CustomPainter {
  const TrackingRouteMapPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final linePaint = Paint()
      ..color = AppColors.mintHighlight.withValues(alpha: 0.85)
      ..strokeWidth = 3.5
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final path = Path()
      ..moveTo(size.width * 0.25, size.height * 0.72)
      ..lineTo(size.width * 0.35, size.height * 0.52)
      ..lineTo(size.width * 0.52, size.height * 0.52)
      ..lineTo(size.width * 0.53, size.height * 0.35)
      ..lineTo(size.width * 0.72, size.height * 0.35)
      ..lineTo(size.width * 0.76, size.height * 0.22);

    canvas.drawPath(path, linePaint);

    final nodePaint = Paint()..color = Colors.white;
    final nodeBorder = Paint()
      ..color = AppColors.secondary
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;

    final courierPos = Offset(size.width * 0.49, size.height * 0.52);
    canvas.drawCircle(courierPos, 7, nodePaint);
    canvas.drawCircle(courierPos, 7, nodeBorder);

    final destPaint = Paint()..color = AppColors.secondary;
    canvas.drawCircle(
      Offset(size.width * 0.76, size.height * 0.22),
      8,
      destPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
