import 'dart:math' as math;
import 'package:flutter/material.dart';

/// Represents a single gold stardust particle with its static distribution
/// and dynamic twinkle parameters.
class GoldParticle {
  final double angle;
  final double distance;
  final double radius;
  final double baseOpacity;
  final double pulseRate;
  final bool hasGlint;

  const GoldParticle({
    required this.angle,
    required this.distance,
    required this.radius,
    required this.baseOpacity,
    required this.pulseRate,
    this.hasGlint = false,
  });
}

/// CustomPainter that renders a luxurious subtle gold dust ring and floating
/// stardust particles around the central Aura emblem, matching the brand reference.
class SplashGoldParticlesPainter extends CustomPainter {
  final double animationValue;

  SplashGoldParticlesPainter({
    required this.animationValue,
  });

  // Pre-configured deterministic particles to eliminate runtime allocations
  static const List<GoldParticle> _particles = [
    // Orbital ring particles
    GoldParticle(angle: 0.15, distance: 130, radius: 1.6, baseOpacity: 0.85, pulseRate: 1.0, hasGlint: true),
    GoldParticle(angle: 0.35, distance: 138, radius: 1.1, baseOpacity: 0.65, pulseRate: 1.4),
    GoldParticle(angle: 0.60, distance: 125, radius: 1.8, baseOpacity: 0.80, pulseRate: 0.9),
    GoldParticle(angle: 0.82, distance: 142, radius: 0.9, baseOpacity: 0.50, pulseRate: 1.8),
    GoldParticle(angle: 1.05, distance: 128, radius: 2.2, baseOpacity: 0.90, pulseRate: 1.2, hasGlint: true),
    GoldParticle(angle: 1.25, distance: 134, radius: 1.0, baseOpacity: 0.55, pulseRate: 1.5),
    GoldParticle(angle: 1.50, distance: 122, radius: 1.5, baseOpacity: 0.70, pulseRate: 0.8),
    GoldParticle(angle: 1.78, distance: 140, radius: 1.2, baseOpacity: 0.60, pulseRate: 1.3),
    GoldParticle(angle: 2.05, distance: 127, radius: 1.9, baseOpacity: 0.85, pulseRate: 1.1),
    GoldParticle(angle: 2.30, distance: 136, radius: 1.3, baseOpacity: 0.65, pulseRate: 1.6),
    GoldParticle(angle: 2.55, distance: 124, radius: 2.0, baseOpacity: 0.88, pulseRate: 1.0, hasGlint: true),
    GoldParticle(angle: 2.80, distance: 143, radius: 1.0, baseOpacity: 0.50, pulseRate: 1.7),
    GoldParticle(angle: 3.05, distance: 130, radius: 1.4, baseOpacity: 0.75, pulseRate: 0.9),
    GoldParticle(angle: 3.32, distance: 138, radius: 1.1, baseOpacity: 0.55, pulseRate: 1.4),
    GoldParticle(angle: 3.58, distance: 126, radius: 1.7, baseOpacity: 0.80, pulseRate: 1.2),
    GoldParticle(angle: 3.85, distance: 144, radius: 0.9, baseOpacity: 0.45, pulseRate: 1.9),
    GoldParticle(angle: 4.12, distance: 129, radius: 2.1, baseOpacity: 0.90, pulseRate: 1.0, hasGlint: true),
    GoldParticle(angle: 4.40, distance: 135, radius: 1.2, baseOpacity: 0.60, pulseRate: 1.5),
    GoldParticle(angle: 4.68, distance: 123, radius: 1.5, baseOpacity: 0.70, pulseRate: 0.8),
    GoldParticle(angle: 4.95, distance: 141, radius: 1.1, baseOpacity: 0.55, pulseRate: 1.3),
    GoldParticle(angle: 5.22, distance: 127, radius: 1.8, baseOpacity: 0.85, pulseRate: 1.1),
    GoldParticle(angle: 5.50, distance: 137, radius: 1.3, baseOpacity: 0.65, pulseRate: 1.6),
    GoldParticle(angle: 5.80, distance: 125, radius: 2.0, baseOpacity: 0.88, pulseRate: 1.0, hasGlint: true),
    GoldParticle(angle: 6.08, distance: 139, radius: 1.0, baseOpacity: 0.50, pulseRate: 1.7),

    // Outer and inner floating ambient stardust
    GoldParticle(angle: 0.25, distance: 155, radius: 0.8, baseOpacity: 0.45, pulseRate: 1.1),
    GoldParticle(angle: 0.90, distance: 110, radius: 1.0, baseOpacity: 0.50, pulseRate: 1.3),
    GoldParticle(angle: 1.65, distance: 158, radius: 0.9, baseOpacity: 0.40, pulseRate: 1.2),
    GoldParticle(angle: 2.20, distance: 112, radius: 1.2, baseOpacity: 0.55, pulseRate: 1.0),
    GoldParticle(angle: 2.95, distance: 160, radius: 0.8, baseOpacity: 0.45, pulseRate: 1.4),
    GoldParticle(angle: 3.70, distance: 108, radius: 1.1, baseOpacity: 0.50, pulseRate: 0.9),
    GoldParticle(angle: 4.55, distance: 156, radius: 0.9, baseOpacity: 0.40, pulseRate: 1.3),
    GoldParticle(angle: 5.35, distance: 114, radius: 1.0, baseOpacity: 0.52, pulseRate: 1.2),
  ];

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final twoPi = 2 * math.pi;

    // 1. Draw ethereal soft gold dust ring
    final ringGlowPaint = Paint()
      ..color = const Color(0x18DFC48B)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.5;
    canvas.drawCircle(center, 131, ringGlowPaint);

    final ringCorePaint = Paint()
      ..color = const Color(0x32DFC48B)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;
    canvas.drawCircle(center, 131, ringCorePaint);

    // 2. Draw rotating particles
    final particlePaint = Paint()..style = PaintingStyle.fill;
    final glintPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.75;

    final slowRotation = animationValue * twoPi * 0.05;

    for (final p in _particles) {
      final currentAngle = p.angle + slowRotation;
      final radialDrift = math.sin(animationValue * twoPi * p.pulseRate + p.angle) * 2.0;
      final currentDistance = p.distance + radialDrift;

      final px = center.dx + currentDistance * math.cos(currentAngle);
      final py = center.dy + currentDistance * math.sin(currentAngle);
      final pos = Offset(px, py);

      // Twinkle calculation
      final twinkle = 0.55 + 0.45 * math.sin(animationValue * twoPi * p.pulseRate * 2 + p.angle);
      final alpha = (p.baseOpacity * twinkle).clamp(0.0, 1.0);

      // Draw particle dot
      particlePaint.color = const Color(0xFFD4AF37).withValues(alpha: alpha);
      canvas.drawCircle(pos, p.radius, particlePaint);

      // If particle has a star glint, draw delicate 4-point cross
      if (p.hasGlint && alpha > 0.4) {
        glintPaint.color = const Color(0xFFFFF6DE).withValues(alpha: alpha * 0.85);
        final glintLen = p.radius * 2.6;
        canvas.drawLine(
          Offset(pos.dx - glintLen, pos.dy),
          Offset(pos.dx + glintLen, pos.dy),
          glintPaint,
        );
        canvas.drawLine(
          Offset(pos.dx, pos.dy - glintLen),
          Offset(pos.dx, pos.dy + glintLen),
          glintPaint,
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant SplashGoldParticlesPainter oldDelegate) {
    return oldDelegate.animationValue != animationValue;
  }
}
