import 'dart:math';
import 'package:flutter/material.dart';

/// Custom painter to draw a smooth circular dotted / dashed border
class DottedCirclePainter extends CustomPainter {
  const DottedCirclePainter({
    required this.color,
    this.strokeWidth = 1.5,
    this.dashLength = 4.0,
    this.gapLength = 3.5,
  });

  final Color color;
  final double strokeWidth;
  final double dashLength;
  final double gapLength;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final radius = size.width / 2;
    final circumference = 2 * pi * radius;
    final dashCount = (circumference / (dashLength + gapLength)).floor();
    final angleStep = (2 * pi) / dashCount;
    final dashAngle = (dashLength / circumference) * 2 * pi;

    for (var i = 0; i < dashCount; i++) {
      final startAngle = i * angleStep;
      canvas.drawArc(
        Rect.fromCircle(
          center: Offset(radius, radius),
          radius: radius - strokeWidth / 2,
        ),
        startAngle,
        dashAngle,
        false,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(DottedCirclePainter oldDelegate) =>
      color != oldDelegate.color || strokeWidth != oldDelegate.strokeWidth;
}
