import 'package:flutter/material.dart';
import '../utils/color_extension.dart';

class MedalPainter extends CustomPainter {
  final Color color;

  MedalPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final borderPaint = Paint()
      ..color = color.darker()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;

    final path = Path();
    final centerX = size.width / 2;
    final centerY = size.height / 2;
    final radiusX = size.width / 2;
    final radiusY = size.height / 2;

    path.moveTo(centerX, 0);
    path.lineTo(centerX + radiusX * 0.85, radiusY * 0.3);
    path.lineTo(centerX + radiusX * 0.85, radiusY * 1.7);
    path.lineTo(centerX, size.height);
    path.lineTo(centerX - radiusX * 0.85, radiusY * 1.7);
    path.lineTo(centerX - radiusX * 0.85, radiusY * 0.3);
    path.close();

    final gradient = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        color.lighter(),
        color,
        color.darker(),
      ],
      stops: const [0.0, 0.5, 1.0],
    );

    final rect = Rect.fromPoints(
      Offset(0, 0),
      Offset(size.width, size.height),
    );

    final gradientPaint = Paint()
      ..shader = gradient.createShader(rect)
      ..style = PaintingStyle.fill;

    canvas.drawPath(path, gradientPaint) ;
    canvas.drawPath(path, borderPaint); 
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}