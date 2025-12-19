import 'package:flutter/material.dart';

import 'snowflake.dart';

class SnowflakePainter extends CustomPainter {
  final List<Snowflake> snowflakes;
  final Color color;

  SnowflakePainter({
    required this.snowflakes,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;

    for (final snowflake in snowflakes) {
      canvas.drawCircle(
        Offset(snowflake.x, snowflake.y),
        snowflake.radius,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
